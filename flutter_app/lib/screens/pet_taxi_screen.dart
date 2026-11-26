import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';

class _TaxiLocation {
  final String id;
  final String name;
  final String address;
  final double xPct;
  final double yPct;

  const _TaxiLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.xPct,
    required this.yPct,
  });

  _TaxiLocation copyWith({
    String? id,
    String? name,
    String? address,
    double? xPct,
    double? yPct,
  }) {
    return _TaxiLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      xPct: xPct ?? this.xPct,
      yPct: yPct ?? this.yPct,
    );
  }
}

class _TaxiQuote {
  final double distanceKm;
  final int etaMinutes;
  final int baseFare;
  final int perKmRate;
  final int distanceFee;
  final int totalFare;

  const _TaxiQuote({
    required this.distanceKm,
    required this.etaMinutes,
    required this.baseFare,
    required this.perKmRate,
    required this.distanceFee,
    required this.totalFare,
  });
}

class PetTaxiScreen extends StatefulWidget {
  const PetTaxiScreen({super.key});

  @override
  State<PetTaxiScreen> createState() => _PetTaxiScreenState();
}

class _PetTaxiScreenState extends State<PetTaxiScreen> {
  static const List<_TaxiLocation> _presetLocations = [
    _TaxiLocation(
      id: 'rumah-sele',
      name: 'Rumah Sele',
      address: 'Rumah Sele • Jl. Kemang Raya No. 18',
      xPct: 22,
      yPct: 68,
    ),
    _TaxiLocation(
      id: 'salon-malang',
      name: 'Pawcation Salon & Spa',
      address: 'Pawcation Salon & Spa',
      xPct: 72,
      yPct: 47,
    ),
    _TaxiLocation(
      id: 'klinik-kemang',
      name: 'Klinik Vet Kemang',
      address: 'Klinik Pawcation Vet Care (Kemang)',
      xPct: 40,
      yPct: 50,
    ),
    _TaxiLocation(
      id: 'sanctuary-senopati',
      name: 'Sanctuary Senopati',
      address: 'Pawcation Sanctuary Suite (Senopati)',
      xPct: 54,
      yPct: 24,
    ),
    _TaxiLocation(
      id: 'taman-menteng',
      name: 'Taman Menteng',
      address: 'Taman Bermain Anabul Menteng',
      xPct: 80,
      yPct: 74,
    ),
    _TaxiLocation(
      id: 'hub-pondok-indah',
      name: 'Hub Pondok Indah',
      address: 'Pawcation Hub Pondok Indah',
      xPct: 18,
      yPct: 28,
    ),
  ];

  String _selectedFleet = 'PawCar Standard';
  _TaxiLocation _pickup = _presetLocations[0];
  _TaxiLocation _dropoff = _presetLocations[1];
  String? _editingStop; // 'pickup' | 'dropoff'
  String _pinMode = 'dropoff';
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  _TaxiQuote _calculateQuote(_TaxiLocation p, _TaxiLocation d, String fleet) {
    final dxKm = ((d.xPct - p.xPct) / 100.0) * 8.0;
    final dyKm = ((d.yPct - p.yPct) / 100.0) * 6.0;
    final rawDist = math.sqrt(dxKm * dxKm + dyKm * dyKm);
    final distanceKm = rawDist < 0.05
        ? 0.0
        : math.max(0.5, (rawDist * 10).round() / 10.0);
    final etaMinutes = distanceKm == 0.0
        ? 0
        : math.max(4, (distanceKm * 1.9).round());
    final baseFare = fleet == 'PawCar Standard' ? 15000 : 35000;
    final perKmRate = fleet == 'PawCar Standard' ? 7000 : 9500;
    final distanceFee = distanceKm == 0.0
        ? 0
        : ((distanceKm * perKmRate) / 1000.0).ceil() * 1000;
    return _TaxiQuote(
      distanceKm: distanceKm,
      etaMinutes: etaMinutes,
      baseFare: baseFare,
      perKmRate: perKmRate,
      distanceFee: distanceFee,
      totalFare: baseFare + distanceFee,
    );
  }

  void _openEditor(String stop) {
    setState(() {
      if (_editingStop == stop) {
        _editingStop = null;
        return;
      }
      _editingStop = stop;
      _pinMode = stop;
      _addressController.text =
          stop == 'pickup' ? _pickup.address : _dropoff.address;
    });
  }

  void _saveCustomAddress() {
    final text = _addressController.text.trim();
    if (text.isEmpty || _editingStop == null) return;
    setState(() {
      if (_editingStop == 'pickup') {
        _pickup = _pickup.copyWith(
          id: 'custom-pickup',
          name: text.split('•').first.trim(),
          address: text,
        );
      } else {
        _dropoff = _dropoff.copyWith(
          id: 'custom-dropoff',
          name: text.split('•').first.trim(),
          address: text,
        );
      }
      _editingStop = null;
    });
  }

  void _handleMapTap(Offset localPos, Size mapSize) {
    if (mapSize.width <= 0 || mapSize.height <= 0) return;
    final xPct = ((localPos.dx / mapSize.width) * 100).clamp(8.0, 92.0);
    final yPct = ((localPos.dy / mapSize.height) * 100).clamp(12.0, 88.0);

    // Snap if tapping close to a preset landmark
    for (final loc in _presetLocations) {
      final distPct = math.sqrt(
        math.pow(loc.xPct - xPct, 2) + math.pow(loc.yPct - yPct, 2),
      );
      if (distPct < 7.5) {
        setState(() {
          if (_pinMode == 'pickup') {
            _pickup = loc;
          } else {
            _dropoff = loc;
          }
        });
        return;
      }
    }

    final xKm = ((xPct / 100.0) * 8.0).toStringAsFixed(1);
    final yKm = ((yPct / 100.0) * 6.0).toStringAsFixed(1);
    setState(() {
      if (_pinMode == 'pickup') {
        _pickup = _TaxiLocation(
          id: 'custom-pickup',
          name: 'Pin Jemput',
          address: 'Titik Jemput Peta ($xKm, $yKm km)',
          xPct: xPct,
          yPct: yPct,
        );
      } else {
        _dropoff = _TaxiLocation(
          id: 'custom-dropoff',
          name: 'Pin Tujuan',
          address: 'Titik Tujuan Peta ($xKm, $yKm km)',
          xPct: xPct,
          yPct: yPct,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final quote = _calculateQuote(_pickup, _dropoff, _selectedFleet);
    final carQuote = _calculateQuote(_pickup, _dropoff, 'PawCar Standard');
    final vanQuote = _calculateQuote(_pickup, _dropoff, 'PawVan AC + Crate');

    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pemesanan Pet Taxi 🚕',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: PawcationColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // Map/Route preview card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: PawcationColors.primarySoft,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: PawcationColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PawcationPillBadge(
                        label: 'ETA ${quote.etaMinutes} Menit',
                        icon: Icons.near_me_rounded,
                        backgroundColor: PawcationColors.white,
                        textColor: PawcationColors.primaryDark,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            final prev = _pickup;
                            _pickup = _dropoff;
                            _dropoff = prev;
                          });
                        },
                        borderRadius: BorderRadius.circular(999),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: PawcationColors.white,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.swap_vert_rounded,
                                size: 14,
                                color: PawcationColors.primaryDark,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Tukar',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: PawcationColors.primaryDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${quote.distanceKm.toStringAsFixed(1)} km',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: PawcationColors.navyAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _RouteStop(
                    color: PawcationColors.primary,
                    label: 'Jemput',
                    address: _pickup.address,
                    isEditing: _editingStop == 'pickup',
                    onEditTap: () => _openEditor('pickup'),
                  ),
                  const SizedBox(height: 8),
                  _RouteStop(
                    color: PawcationColors.success,
                    label: 'Tujuan',
                    address: _dropoff.address,
                    isEditing: _editingStop == 'dropoff',
                    onEditTap: () => _openEditor('dropoff'),
                  ),
                  if (_editingStop != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: PawcationColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: PawcationColors.primary.withValues(alpha: 0.35),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _editingStop == 'pickup'
                                ? 'Ubah Lokasi Penjemputan'
                                : 'Ubah Lokasi Tujuan',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: PawcationColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _addressController,
                                  style: const TextStyle(fontSize: 12.5),
                                  decoration: InputDecoration(
                                    hintText: 'Ketik alamat atau pilih titik...',
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFFF8FBFE),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: PawcationColors.border,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: _saveCustomAddress,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: PawcationColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Lokasi Populer Pawcation:',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: PawcationColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: _presetLocations.map((loc) {
                              final selected = _editingStop == 'pickup'
                                  ? _pickup.id == loc.id
                                  : _dropoff.id == loc.id;
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_editingStop == 'pickup') {
                                      _pickup = loc;
                                    } else {
                                      _dropoff = loc;
                                    }
                                    _editingStop = null;
                                  });
                                },
                                borderRadius: BorderRadius.circular(999),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? PawcationColors.primary
                                        : const Color(0xFFF0F7FC),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    loc.name,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: selected
                                          ? Colors.white
                                          : PawcationColors.primaryDark,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 12),
                  // Interactive Map + Fare Breakdown Container
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: PawcationColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: PawcationColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.map_rounded,
                              size: 16,
                              color: PawcationColors.primary,
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text(
                                'Peta Rute',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: PawcationColors.textPrimary,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: PawcationColors.inputFill,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _PinTogglePill(
                                    label: 'Pin Jemput',
                                    active: _pinMode == 'pickup',
                                    activeColor: PawcationColors.primary,
                                    onTap: () =>
                                        setState(() => _pinMode = 'pickup'),
                                  ),
                                  _PinTogglePill(
                                    label: 'Pin Tujuan',
                                    active: _pinMode == 'dropoff',
                                    activeColor: PawcationColors.success,
                                    onTap: () =>
                                        setState(() => _pinMode = 'dropoff'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: PawcationColors.border),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 170,
                                  width: double.infinity,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final size = Size(
                                        constraints.maxWidth,
                                        170,
                                      );
                                      return GestureDetector(
                                        onTapDown: (details) => _handleMapTap(
                                          details.localPosition,
                                          size,
                                        ),
                                        child: CustomPaint(
                                          size: size,
                                          painter: _RouteMapPainter(
                                            pickup: _pickup,
                                            dropoff: _dropoff,
                                            presets: _presetLocations,
                                            quote: quote,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  color: PawcationColors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Ketuk peta untuk ubah ${_pinMode == 'pickup' ? 'Jemput' : 'Tujuan'}',
                                        style: const TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w600,
                                          color: PawcationColors.textSecondary,
                                        ),
                                      ),
                                      const Text(
                                        'Skala 8×6 km',
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w700,
                                          color: PawcationColors.navyAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F7FC),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.analytics_outlined,
                                    size: 15,
                                    color: PawcationColors.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  const Expanded(
                                    child: Text(
                                      'Rincian Tarif',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: PawcationColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  PawcationPillBadge(
                                    label:
                                        '${quote.distanceKm.toStringAsFixed(1)} km • ${quote.etaMinutes} mnt',
                                    backgroundColor: PawcationColors.white,
                                    textColor: PawcationColors.primaryDark,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _FareLine(
                                label: 'Tarif Dasar ($_selectedFleet)',
                                value: DummyData.formatRupiah(quote.baseFare),
                              ),
                              const SizedBox(height: 4),
                              _FareLine(
                                label:
                                    'Biaya Jarak (${quote.distanceKm.toStringAsFixed(1)} km × ${DummyData.formatRupiah(quote.perKmRate)})',
                                value:
                                    DummyData.formatRupiah(quote.distanceFee),
                              ),
                              const Divider(height: 14),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Estimasi Total',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w800,
                                      color: PawcationColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    DummyData.formatRupiah(quote.totalFare),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color: PawcationColors.navyAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Fleet Options
            const Text(
              'Pilih Armada Pet-Safe',
              style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            ...['PawCar Standard', 'PawVan AC + Crate'].map((fleet) {
              final selected = _selectedFleet == fleet;
              final price = fleet == 'PawCar Standard'
                  ? carQuote.totalFare
                  : vanQuote.totalFare;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: PawcationCard(
                  padding: const EdgeInsets.all(14),
                  border: Border.all(
                    color: selected
                        ? PawcationColors.primary
                        : PawcationColors.border,
                    width: selected ? 2 : 1,
                  ),
                  onTap: () => setState(() => _selectedFleet = fleet),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: PawcationColors.primarySoft,
                        child: Icon(
                          Icons.local_taxi_rounded,
                          color: PawcationColors.primaryDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fleet,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Text(
                              'Disinfeksi UV • Driver tersertifikasi',
                              style: TextStyle(
                                fontSize: 12,
                                color: PawcationColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        DummyData.formatRupiah(price),
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w900,
                          color: PawcationColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // Driver Card
            PawcationCard(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: PawcationColors.primarySoft,
                    child: Icon(
                      Icons.person_rounded,
                      color: PawcationColors.primaryDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mas Budi • B 1824 PAW',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '★ 4.9 • 320+ perjalanan anabul',
                          style: TextStyle(
                            fontSize: 12,
                            color: PawcationColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/consult-chat'),
                    icon: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: PawcationColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            PawcationPrimaryButton(
              label: 'Pesan Pet Taxi (${DummyData.formatRupiah(quote.totalFare)})',
              trailingIcon: Icons.arrow_forward_rounded,
              onPressed: () {
                state.completePayment(
                  totalAmount: quote.totalFare,
                  summaryText:
                      'Pet Taxi ($_selectedFleet) • ${_pickup.name} → ${_dropoff.name} (${quote.distanceKm.toStringAsFixed(1)} km)',
                );
                Navigator.pushNamed(context, '/payment-status');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteStop extends StatelessWidget {
  final Color color;
  final String label;
  final String address;
  final bool isEditing;
  final VoidCallback onEditTap;

  const _RouteStop({
    required this.color,
    required this.label,
    required this.address,
    required this.isEditing,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  address,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: PawcationColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onEditTap,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                isEditing ? 'Tutup' : 'Ubah',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PinTogglePill extends StatelessWidget {
  final String label;
  final bool active;
  final Color activeColor;
  final VoidCallback onTap;

  const _PinTogglePill({
    required this.label,
    required this.active,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: active ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : PawcationColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _FareLine extends StatelessWidget {
  final String label;
  final String value;

  const _FareLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              color: PawcationColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: PawcationColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _RouteMapPainter extends CustomPainter {
  final _TaxiLocation pickup;
  final _TaxiLocation dropoff;
  final List<_TaxiLocation> presets;
  final _TaxiQuote quote;

  _RouteMapPainter({
    required this.pickup,
    required this.dropoff,
    required this.presets,
    required this.quote,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFFF2F8FD),
    );

    final blockPaint = Paint()..color = const Color(0xFFE6F2FA);
    final parkPaint = Paint()..color = const Color(0xFFDCFCE7);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.06, h * 0.1, w * 0.2, h * 0.2),
        const Radius.circular(8),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.34, h * 0.08, w * 0.26, h * 0.23),
        const Radius.circular(8),
      ),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.67, h * 0.1, w * 0.26, h * 0.25),
        const Radius.circular(8),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.07, h * 0.42, w * 0.22, h * 0.24),
        const Radius.circular(8),
      ),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.36, h * 0.41, w * 0.27, h * 0.26),
        const Radius.circular(8),
      ),
      blockPaint,
    );

    // Subtle km grid
    final gridPaint = Paint()
      ..color = const Color(0xFFDCEAF5)
      ..strokeWidth = 1;
    for (int i = 1; i < 8; i++) {
      final gx = (w / 8) * i;
      canvas.drawLine(Offset(gx, 0), Offset(gx, h), gridPaint);
    }
    for (int j = 1; j < 6; j++) {
      final gy = (h / 6) * j;
      canvas.drawLine(Offset(0, gy), Offset(w, gy), gridPaint);
    }

    // Main roads
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6;
    canvas.drawLine(Offset(0, h * 0.35), Offset(w, h * 0.35), roadPaint);
    canvas.drawLine(Offset(0, h * 0.7), Offset(w, h * 0.7), roadPaint);
    canvas.drawLine(Offset(w * 0.31, 0), Offset(w * 0.31, h), roadPaint);
    canvas.drawLine(Offset(w * 0.65, 0), Offset(w * 0.65, h), roadPaint);

    final pOffset = Offset((pickup.xPct / 100) * w, (pickup.yPct / 100) * h);
    final dOffset = Offset((dropoff.xPct / 100) * w, (dropoff.yPct / 100) * h);
    final ctrl = Offset(
      (pOffset.dx + dOffset.dx) / 2,
      ((pOffset.dy + dOffset.dy) / 2 - h * 0.12).clamp(16.0, h - 16.0),
    );

    // Route curve
    final routePath = Path()
      ..moveTo(pOffset.dx, pOffset.dy)
      ..quadraticBezierTo(ctrl.dx, ctrl.dy, dOffset.dx, dOffset.dy);
    canvas.drawPath(
      routePath,
      Paint()
        ..color = PawcationColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round,
    );

    // Preset landmarks
    for (final loc in presets) {
      if (loc.id == pickup.id || loc.id == dropoff.id) continue;
      final pt = Offset((loc.xPct / 100) * w, (loc.yPct / 100) * h);
      canvas.drawCircle(pt, 5, Paint()..color = Colors.white);
      canvas.drawCircle(
        pt,
        5,
        Paint()
          ..color = PawcationColors.textSecondary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8,
      );
    }

    // Pickup & Dropoff pins
    _drawPin(canvas, pOffset, PawcationColors.primary);
    _drawPin(canvas, dOffset, PawcationColors.success);

    // Midpoint badge
    final mid = Offset(ctrl.dx, (ctrl.dy + (pOffset.dy + dOffset.dy) / 2) / 2);
    final badgeText = TextPainter(
      text: TextSpan(
        text:
            '${quote.distanceKm.toStringAsFixed(1)} km • ${DummyData.formatRupiah(quote.totalFare)}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final pillRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: mid,
        width: badgeText.width + 16,
        height: 20,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(pillRect, Paint()..color = PawcationColors.navyAccent);
    badgeText.paint(
      canvas,
      Offset(mid.dx - badgeText.width / 2, mid.dy - badgeText.height / 2),
    );
  }

  void _drawPin(Canvas canvas, Offset center, Color color) {
    canvas.drawCircle(
      center,
      12,
      Paint()..color = color.withValues(alpha: 0.2),
    );
    canvas.drawCircle(center, 7, Paint()..color = color);
    canvas.drawCircle(
      center,
      7,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2,
    );
  }

  @override
  bool shouldRepaint(covariant _RouteMapPainter oldDelegate) {
    return oldDelegate.pickup != pickup ||
        oldDelegate.dropoff != dropoff ||
        oldDelegate.quote.totalFare != quote.totalFare;
  }
}

