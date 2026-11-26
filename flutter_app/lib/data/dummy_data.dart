import '../models/pawcation_models.dart';

class DummyData {
  DummyData._();

  static const PetProfile dodo = PetProfile(
    id: '#PC-MC-2022-8819',
    name: 'Dodo',
    breed: 'Toy Poodle',
    species: 'Anjing',
    age: '2 Tahun',
    weight: '5.2 kg',
    status: 'Sedang Boarding',
    roomInfo: 'Suite Room A-12 • Aktivitas jam 14:00 terjadwal',
    avatarAsset: 'assets/images/dodo_avatar.png',
  );

  static const List<ProductItem> products = [
    ProductItem(
      id: 'p1',
      name: 'Royal Canin Mini Adult',
      category: 'Makanan',
      price: 185000,
      weightLabel: '2 kg',
      rating: 4.9,
      badge: 'Terlaris',
      emoji: '🥣',
    ),
    ProductItem(
      id: 'p2',
      name: 'PawDental Fresh Chews',
      category: 'Vitamin',
      price: 115000,
      weightLabel: '140 g',
      rating: 4.8,
      badge: 'Rekomendasi Vet',
      emoji: '🦴',
    ),
    ProductItem(
      id: 'p3',
      name: 'Gentle Coat Oatmeal Shampoo',
      category: 'Grooming',
      price: 98000,
      weightLabel: '300 ml',
      rating: 4.9,
      badge: 'Pet-Safe',
      emoji: '🫧',
    ),
    ProductItem(
      id: 'p4',
      name: 'Omega-3 Coat Booster Drops',
      category: 'Vitamin',
      price: 135000,
      weightLabel: '60 ml',
      rating: 4.7,
      badge: 'Baru',
      emoji: '💧',
    ),
    ProductItem(
      id: 'p5',
      name: 'CloudSoft Orthopedic Bed',
      category: 'Aksesoris',
      price: 265000,
      weightLabel: 'Size M',
      rating: 4.9,
      badge: 'Favorit',
      emoji: '🛏️',
    ),
    ProductItem(
      id: 'p6',
      name: 'Probiotic Digestive Treats',
      category: 'Makanan',
      price: 89000,
      weightLabel: '120 g',
      rating: 4.8,
      badge: 'Organik',
      emoji: '🍖',
    ),
  ];

  static const List<AgendaItem> initialAgendas = [
    AgendaItem(
      id: 'a1',
      timeBadge: 'Hari Ini',
      petLabel: 'Dodo • Poodle',
      statusLabel: 'Dikonfirmasi',
      status: AgendaStatus.confirmed,
      title: 'Grooming Lengkap',
      dateTimeLabel: '14:00 WIB (Siang Ini)',
      location: 'Pawcation Salon & Spa (Cabang Malang)',
      personLabel: 'Groomer: Mas Budi • Disinfeksi Pet-Safe',
      noteLabel: 'Driver Siap Menjemput (13:15)',
      primaryActionLabel: 'Detail Pet Taxi',
      secondaryActionLabel: 'Ingatkan 1 Jam',
      dayOfMonth: 21,
    ),
    AgendaItem(
      id: 'a2',
      timeBadge: 'Dalam 3 Hari',
      petLabel: 'Dodo • Poodle',
      statusLabel: 'Terjadwal',
      status: AgendaStatus.scheduled,
      title: 'Vaksinasi Tahunan Rabies & DHPPi 💉',
      dateTimeLabel: 'Sel, 24 Okt • 10:30 WIB',
      location: 'Klinik Pawcation Vet Care (Kemang)',
      personLabel: 'drh. Amanda Saraswati, M.Si',
      noteLabel: 'Jangan lupa bawa Buku Vaksin digital Mochi.',
      primaryActionLabel: 'Lihat Persiapan',
      secondaryActionLabel: 'Reschedule',
      dayOfMonth: 24,
    ),
    AgendaItem(
      id: 'a3',
      timeBadge: 'Bulan Depan',
      petLabel: 'Dodo • Poodle',
      statusLabel: 'Pengingat Dibuat',
      status: AgendaStatus.reminder,
      title: 'Pemeriksaan Gigi & Scaling',
      dateTimeLabel: 'Jum, 03 Nov • 11:00 WIB',
      location: 'Pawcation Dental Center',
      personLabel: 'drh. Gilang Pratama',
      noteLabel: 'Puasa ringan 4 jam sebelum pemeriksaan.',
      primaryActionLabel: 'Detail Jadwal',
      secondaryActionLabel: 'Atur Ulang',
      dayOfMonth: 20,
    ),
  ];

  static const List<HotelRoom> hotelRooms = [
    HotelRoom(
      id: 'r1',
      name: 'Deluxe Cozy Suite',
      subtitle: 'Kamar nyaman ber-AC + kasur ortopedi & mainan',
      pricePerNight: 185000,
      facilities: ['AC 24 Jam', 'Live CCTV', '2x Walk/Hari'],
      badge: 'Terpopuler',
    ),
    HotelRoom(
      id: 'r2',
      name: 'Royal VIP Sanctuary',
      subtitle: 'Suite privat luas dengan taman indoor & laporan video',
      pricePerNight: 295000,
      facilities: ['Private Yard', '24h Vet Watch', 'Daily Brush'],
      badge: 'Suite A-12',
    ),
    HotelRoom(
      id: 'r3',
      name: 'Garden Play Villa',
      subtitle: 'Akses langsung ke area bermain rumput pet-safe',
      pricePerNight: 240000,
      facilities: ['Play Park', 'Snack Sore', 'Live CCTV'],
      badge: 'Ramah Sosial',
    ),
  ];

  static const List<VetDoctor> vets = [
    VetDoctor(
      id: 'v1',
      name: 'drh. Amanda Saraswati, M.Si',
      specialty: 'Dokter Hewan Umum & Vaksinasi',
      experience: '8 tahun pengalaman',
      rating: 4.9,
      isOnline: true,
      fee: 75000,
    ),
    VetDoctor(
      id: 'v2',
      name: 'drh. Gilang Pratama',
      specialty: 'Dermatologi & Nutrisi Anabul',
      experience: '6 tahun pengalaman',
      rating: 4.8,
      isOnline: true,
      fee: 75000,
    ),
  ];

  static const List<ChatMessage> initialMessages = [
    ChatMessage(
      id: 'm1',
      sender: 'drh. Amanda Saraswati, M.Si',
      text: 'Halo Kak Sele! Ada keluhan apa dengan Dodo hari ini?',
      time: '14:10',
      isUser: false,
    ),
    ChatMessage(
      id: 'm2',
      sender: 'Sele Clarissa',
      text: 'Halo Dok, Dodo agak kurang nafsu makan sejak pagi dan lebih sering tidur.',
      time: '14:12',
      isUser: true,
    ),
    ChatMessage(
      id: 'm3',
      sender: 'drh. Amanda Saraswati, M.Si',
      text:
          'Baik Kak, suhu Dodo di Suite A-12 terpantau normal 38.4°C. Untuk bantu nafsu makan & pencernaannya, Dokter sarankan snack dental & probiotik berikut ya:',
      time: '14:14',
      isUser: false,
      recommendedProduct: 'PawDental Fresh Chews',
    ),
  ];

  static String formatRupiah(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      final reverseIndex = str.length - i;
      buffer.write(str[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write('.');
      }
    }
    return 'Rp $buffer';
  }
}
