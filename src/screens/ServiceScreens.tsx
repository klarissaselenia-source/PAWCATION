import React, {useState} from 'react';
import {
  ArrowRight,
  ArrowUpDown,
  Calendar,
  Car,
  Check,
  Heart,
  Hotel,
  LogOut,
  MapPin,
  MessageSquare,
  Mic,
  MicOff,
  Minus,
  Navigation,
  Pencil,
  Phone,
  Plus,
  Search,
  Send,
  ShieldCheck,
  ShoppingBag,
  ShoppingCart,
  Stethoscope,
  Thermometer,
  Video,
} from 'lucide-react';
import {
  NotificationBellButton,
  PawcationBottomNav,
  PawcationHeader,
} from '../components/MobilePrimitives';
import {
  HOTEL_ROOMS,
  PRODUCTS,
  VETS,
  type ChatMsg,
} from '../data/pawcationData';
import {
  calculateCartTotals,
  calculatePetTaxiQuote,
  createCustomPinLocation,
  filterProducts,
  formatRupiah,
  TAXI_LOCATIONS,
  type CartEntry,
  type ProductItem,
  type RouteKey,
  type TaxiFleetType,
  type TaxiLocation,
} from '../utils/pawcationLogic';

export function HomeScreen({
  ownerName,
  pawPoints,
  cartCount,
  onAddToCart,
  onNavigate,
}: {
  ownerName: string;
  pawPoints: number;
  cartCount: number;
  onAddToCart: (p: ProductItem) => void;
  onNavigate: (r: RouteKey) => void;
}) {
  const services: Array<{
    label: string;
    route: RouteKey;
    bg: string;
    fg: string;
    icon: React.ReactNode;
  }> = [
    {
      label: 'Pet Hotel',
      route: 'pet-hotel',
      bg: '#E0F2FE',
      fg: '#0284C7',
      icon: <Hotel className="h-5 w-5" />,
    },
    {
      label: 'Konsultasi',
      route: 'vet-consult',
      bg: '#E6F7F4',
      fg: '#0D9488',
      icon: <Stethoscope className="h-5 w-5" />,
    },
    {
      label: 'Live Cam',
      route: 'live',
      bg: '#FEF3C7',
      fg: '#D97706',
      icon: <Video className="h-5 w-5" />,
    },
    {
      label: 'Pet Taxi',
      route: 'pet-taxi',
      bg: '#EDE9FE',
      fg: '#6D28D9',
      icon: <Car className="h-5 w-5" />,
    },
    {
      label: 'Jadwal',
      route: 'schedule',
      bg: '#E0F2FE',
      fg: '#0FA5E9',
      icon: <Calendar className="h-5 w-5" />,
    },
    {
      label: 'Pet Medical',
      route: 'medical',
      bg: '#FEE2E2',
      fg: '#EF4444',
      icon: <Heart className="h-5 w-5" />,
    },
  ];

  return (
    <div className="flex min-h-full flex-col bg-[#F4F8FC]">
      <PawcationHeader
        showBack={false}
        trailing={
          <NotificationBellButton onClick={() => onNavigate('schedule')} />
        }
      />

      <div className="flex-1 space-y-5 px-4 pt-4 pb-6">
        {/* Greeting Row */}
        <div className="flex items-center gap-3">
          <button
            type="button"
            onClick={() => onNavigate('account')}
            className="shrink-0 cursor-pointer"
          >
            <img
              src="/assets/images/dodo_avatar.png"
              alt="Dodo"
              className="h-11 w-11 rounded-full object-cover"
            />
          </button>
          <div className="min-w-0 flex-1">
            <h1 className="truncate text-[18px] font-black text-[#1E293B]">
              Halo, {ownerName.split(' ')[0]} &amp; Dodo! 👋
            </h1>
            <p className="truncate text-[12px] text-[#64748B]">
              Suite Room A-12 • Aktivitas jam 14:00
            </p>
          </div>
          <button
            type="button"
            onClick={() => onNavigate('cart')}
            aria-label="Buka Keranjang"
            className="flex items-center gap-1.5 rounded-2xl border border-[#E6EEF5] bg-white px-3 py-2 text-[12.5px] font-extrabold text-[#0284C7] cursor-pointer"
          >
            <ShoppingBag className="h-4 w-4" />
            <span>{cartCount}</span>
          </button>
        </div>

        {/* Hero Blue Banner */}
        <div className="rounded-[24px] bg-gradient-to-br from-[#0FA5E9] to-[#0284C7] p-4.5 text-white shadow-sm">
          <div className="flex items-center justify-between">
            <span className="inline-flex items-center gap-1.5 rounded-full bg-white/20 px-3 py-1 text-[11px] font-bold">
              <span className="h-2 w-2 rounded-full bg-[#4ADE80]" />
              LIVE BOARDING • SUITE A-12
            </span>
            <span className="text-[12.5px] font-extrabold">{pawPoints} Pts</span>
          </div>
          <h2 className="mt-3 text-[19px] font-black leading-snug">
            Dodo sedang nyaman{' '}
            <br />
            di Pawcation Sanctuary 🐾
          </h2>
          <p className="mt-1.5 text-[12.5px] leading-relaxed text-[#E0F2FE]">
            Pantau kamera 24 jam, jadwalkan grooming, atau konsultasi dokter
            kapan saja.
          </p>
          <div className="mt-3.5 flex gap-2.5">
            <button
              type="button"
              onClick={() => onNavigate('live')}
              className="inline-flex items-center gap-1.5 rounded-full bg-white px-4 py-2 text-[12.5px] font-extrabold text-[#0284C7] cursor-pointer"
            >
              <Video className="h-4 w-4" />
              <span>Pantau Live</span>
            </button>
            <button
              type="button"
              onClick={() => onNavigate('pet-hotel')}
              className="rounded-full border border-white/50 px-4 py-2 text-[12.5px] font-bold text-white cursor-pointer"
            >
              Pesan Hotel
            </button>
          </div>
        </div>

        {/* Layanan Pawcation 2x3 Grid */}
        <div>
          <h2 className="text-[16px] font-extrabold text-[#1E293B]">
            Layanan Pawcation
          </h2>
          <div className="mt-3 grid grid-cols-3 gap-2.5">
            {services.map((svc) => (
              <button
                key={svc.route}
                type="button"
                onClick={() => onNavigate(svc.route)}
                className="flex flex-col items-center rounded-[18px] border border-[#E6EEF5] bg-white px-2 py-3.5 shadow-sm hover:border-[#BAE6FD] cursor-pointer"
              >
                <span
                  className="flex h-11 w-11 items-center justify-center rounded-full"
                  style={{backgroundColor: svc.bg, color: svc.fg}}
                >
                  {svc.icon}
                </span>
                <span className="mt-2 text-[12px] font-bold text-[#1E293B]">
                  {svc.label}
                </span>
              </button>
            ))}
          </div>
        </div>

        {/* Belanja Kebutuhan Anabul */}
        <div>
          <div className="flex items-center justify-between">
            <h2 className="text-[16px] font-extrabold text-[#1E293B]">
              Belanja Kebutuhan Anabul
            </h2>
            <button
              type="button"
              onClick={() => onNavigate('marketplace')}
              className="text-[12.5px] font-bold text-[#0FA5E9] cursor-pointer"
            >
              Lihat Semua →
            </button>
          </div>
          <div className="mt-3 grid grid-cols-2 gap-3">
            {PRODUCTS.slice(0, 2).map((product) => (
              <div
                key={product.id}
                className="flex flex-col rounded-[20px] border border-[#E6EEF5] bg-white p-3 shadow-sm"
              >
                <div className="flex h-20 items-center justify-center rounded-2xl bg-[#F0F7FC] text-4xl">
                  {product.emoji}
                </div>
                <span className="mt-2.5 w-fit rounded-full bg-[#E6F4FD] px-2.5 py-0.5 text-[10.5px] font-bold text-[#0284C7]">
                  {product.badge}
                </span>
                <p className="mt-1.5 line-clamp-2 text-[13px] font-extrabold text-[#1E293B]">
                  {product.name}
                </p>
                <p className="mt-1 text-[13.5px] font-black text-[#0284C7]">
                  {formatRupiah(product.price)}
                </p>
                <button
                  type="button"
                  onClick={() => onAddToCart(product)}
                  className="mt-2.5 rounded-full bg-[#0FA5E9] py-2 text-[12px] font-bold text-white cursor-pointer"
                >
                  + Keranjang
                </button>
              </div>
            ))}
          </div>
        </div>
      </div>

      <PawcationBottomNav activeRoute="home" onNavigate={onNavigate} />
    </div>
  );
}

export function MarketplaceScreen({
  cartCount,
  onAddToCart,
  onNavigate,
}: {
  cartCount: number;
  onAddToCart: (p: ProductItem) => void;
  onNavigate: (r: RouteKey) => void;
}) {
  const [category, setCategory] = useState('Semua');
  const [query, setQuery] = useState('');
  const filtered = filterProducts(PRODUCTS, category, query);

  return (
    <div className="flex min-h-full flex-col bg-[#F4F8FC]">
      <PawcationHeader
        showBack
        onBack={() => onNavigate('home')}
        trailing={
          <button
            type="button"
            aria-label="Keranjang Belanja"
            onClick={() => onNavigate('cart')}
            className="relative flex h-9 w-9 items-center justify-center rounded-full text-[#1E293B] cursor-pointer"
          >
            <ShoppingCart className="h-5 w-5" />
            <span className="absolute right-0.5 top-0.5 flex h-4 min-w-4 items-center justify-center rounded-full bg-[#0FA5E9] px-1 text-[10px] font-extrabold text-white">
              {cartCount}
            </span>
          </button>
        }
      />

      <div className="flex-1 space-y-3.5 px-4 pt-4 pb-6">
        <h1 className="text-[20px] font-black text-[#1E293B]">
          Pawcation Marketplace 🛍️
        </h1>

        <div className="flex h-11 items-center gap-2.5 rounded-full border border-[#E6EEF5] bg-white px-4">
          <Search className="h-4 w-4 text-[#64748B]" />
          <input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Cari pakan, vitamin, grooming..."
            className="w-full bg-transparent text-[13.5px] outline-none"
          />
        </div>

        <div className="flex gap-2 overflow-x-auto pb-1">
          {['Semua', 'Makanan', 'Vitamin', 'Grooming', 'Aksesoris'].map(
            (cat) => (
              <button
                key={cat}
                type="button"
                onClick={() => setCategory(cat)}
                className={`shrink-0 rounded-full px-3.5 py-1.5 text-[12px] font-bold cursor-pointer ${
                  category === cat
                    ? 'bg-[#0FA5E9] text-white'
                    : 'border border-[#E6EEF5] bg-white text-[#64748B]'
                }`}
              >
                {cat}
              </button>
            ),
          )}
        </div>

        <div className="grid grid-cols-2 gap-3">
          {filtered.map((product) => (
            <div
              key={product.id}
              className="flex flex-col rounded-[20px] border border-[#E6EEF5] bg-white p-3 shadow-sm"
            >
              <div className="flex h-20 items-center justify-center rounded-2xl bg-[#F0F7FC] text-4xl">
                {product.emoji}
              </div>
              <span className="mt-2 w-fit rounded-full bg-[#E6F4FD] px-2.5 py-0.5 text-[10.5px] font-bold text-[#0284C7]">
                {product.badge}
              </span>
              <p className="mt-1.5 text-[13px] font-extrabold text-[#1E293B]">
                {product.name}
              </p>
              <p className="text-[11.5px] text-[#64748B]">
                {product.weightLabel} • ★ {product.rating}
              </p>
              <p className="mt-1.5 text-[14px] font-black text-[#0284C7]">
                {formatRupiah(product.price)}
              </p>
              <button
                type="button"
                onClick={() => onAddToCart(product)}
                className="mt-2.5 rounded-full bg-[#0FA5E9] py-2 text-[12px] font-bold text-white cursor-pointer"
              >
                + Keranjang
              </button>
            </div>
          ))}
        </div>
      </div>

      <PawcationBottomNav activeRoute="marketplace" onNavigate={onNavigate} />
    </div>
  );
}

export function CartScreen({
  cart,
  pawPoints,
  onUpdateQty,
  onToggleSelect,
  onCheckout,
  onNavigate,
}: {
  cart: CartEntry[];
  pawPoints: number;
  onUpdateQty: (p: ProductItem, delta: number) => void;
  onToggleSelect: (id: string) => void;
  onCheckout: (total: number, itemsText: string) => void;
  onNavigate: (r: RouteKey) => void;
}) {
  const [delivery, setDelivery] = useState('Antar via Pet Taxi');
  const [usePoints, setUsePoints] = useState(false);
  const {itemCount, subtotal, shipping, discount, total} = calculateCartTotals(
    cart,
    usePoints,
  );

  return (
    <div className="min-h-full bg-[#F4F8FC]">
      <PawcationHeader showBack onBack={() => onNavigate('marketplace')} />
      <div className="space-y-3.5 px-4 pt-4 pb-8">
        <div className="flex items-center justify-between">
          <h1 className="text-[20px] font-black text-[#1E293B]">
            Keranjang Saya 🛒
          </h1>
          <span className="rounded-full bg-[#E6F4FD] px-3 py-1 text-[12px] font-bold text-[#0284C7]">
            {itemCount} Item
          </span>
        </div>

        {cart.map((entry) => (
          <div
            key={entry.product.id}
            className="flex items-center gap-3 rounded-[22px] border border-[#E6EEF5] bg-white p-3.5 shadow-sm"
          >
            <input
              type="checkbox"
              checked={entry.selected}
              onChange={() => onToggleSelect(entry.product.id)}
              className="h-4 w-4 accent-[#0FA5E9]"
            />
            <div className="flex h-13 w-13 shrink-0 items-center justify-center rounded-2xl bg-[#F0F7FC] text-2xl">
              {entry.product.emoji}
            </div>
            <div className="min-w-0 flex-1">
              <p className="truncate text-[14px] font-extrabold text-[#1E293B]">
                {entry.product.name}
              </p>
              <p className="text-[12px] text-[#64748B]">
                {entry.product.weightLabel}
              </p>
              <p className="mt-1 text-[14px] font-black text-[#0284C7]">
                {formatRupiah(entry.product.price)}
              </p>
            </div>
            <div className="flex items-center gap-2">
              <button
                type="button"
                aria-label={`Kurangi ${entry.product.name}`}
                onClick={() => onUpdateQty(entry.product, -1)}
                className="flex h-7 w-7 items-center justify-center rounded-lg bg-[#F3F5F8] cursor-pointer"
              >
                <Minus className="h-3.5 w-3.5" />
              </button>
              <span className="text-[13.5px] font-extrabold">
                {entry.quantity}
              </span>
              <button
                type="button"
                aria-label={`Tambah ${entry.product.name}`}
                onClick={() => onUpdateQty(entry.product, 1)}
                className="flex h-7 w-7 items-center justify-center rounded-lg bg-[#F3F5F8] cursor-pointer"
              >
                <Plus className="h-3.5 w-3.5" />
              </button>
            </div>
          </div>
        ))}

        <div className="rounded-[22px] border border-[#E6EEF5] bg-white p-4 shadow-sm">
          <p className="text-[14px] font-extrabold text-[#1E293B]">
            Opsi Pengiriman
          </p>
          <div className="mt-2 space-y-2">
            {[
              'Antar via Pet Taxi',
              'Kurir Instant Pawcation',
              'Ambil di Cabang Kemang',
            ].map((opt) => (
              <label
                key={opt}
                className="flex items-center gap-2.5 text-[13px] font-semibold text-[#1E293B] cursor-pointer"
              >
                <input
                  type="radio"
                  name="delivery"
                  checked={delivery === opt}
                  onChange={() => setDelivery(opt)}
                  className="accent-[#0FA5E9]"
                />
                <span>{opt}</span>
              </label>
            ))}
          </div>
        </div>

        <label className="flex items-center justify-between rounded-[22px] border border-[#E6EEF5] bg-white p-4 shadow-sm cursor-pointer">
          <span className="text-[13.5px] font-bold text-[#1E293B]">
            Tukar {pawPoints} PawPoints (-Rp 15.000)
          </span>
          <input
            type="checkbox"
            checked={usePoints}
            onChange={(e) => setUsePoints(e.target.checked)}
            className="h-4 w-4 accent-[#0FA5E9]"
          />
        </label>

        <div className="space-y-2 rounded-[22px] border border-[#E6EEF5] bg-white p-4 text-[13px] shadow-sm">
          <div className="flex justify-between">
            <span className="text-[#64748B]">Subtotal Produk</span>
            <span className="font-bold">{formatRupiah(subtotal)}</span>
          </div>
          <div className="flex justify-between">
            <span className="text-[#64748B]">Ongkos Kirim</span>
            <span className="font-bold">{formatRupiah(shipping)}</span>
          </div>
          {discount > 0 && (
            <div className="flex justify-between text-[#0D9488]">
              <span>Diskon PawPoints</span>
              <span className="font-bold">-{formatRupiah(discount)}</span>
            </div>
          )}
          <div className="my-2 h-px bg-[#E2E8F0]" />
          <div className="flex items-center justify-between">
            <span className="text-[15px] font-extrabold">Total Pembayaran</span>
            <span className="text-[19px] font-black text-[#0B4F6C]">
              {formatRupiah(total)}
            </span>
          </div>
        </div>

        <button
          type="button"
          disabled={total <= 0}
          onClick={() => {
            const summary = cart
              .filter((e) => e.selected)
              .map((e) => `${e.product.name} (${e.quantity}x)`)
              .join(', ');
            onCheckout(total, summary);
          }}
          className="flex h-[50px] w-full items-center justify-center gap-2 rounded-full bg-[#0FA5E9] text-[15px] font-bold text-white shadow-sm disabled:opacity-50 cursor-pointer"
        >
          <span>Bayar Sekarang ({formatRupiah(total)})</span>
          <ArrowRight className="h-4 w-4" />
        </button>
      </div>
    </div>
  );
}

export function PetHotelScreen({
  onCheckout,
  onNavigate,
}: {
  onCheckout: (total: number, summary: string) => void;
  onNavigate: (r: RouteKey) => void;
}) {
  const [roomId, setRoomId] = useState(HOTEL_ROOMS[0].id);
  const [nights, setNights] = useState(2);
  const [extras, setExtras] = useState<string[]>(['Live CCTV 24 Jam']);

  const extraFees: Record<string, number> = {
    'Grooming Harian': 75000,
    'Live CCTV 24 Jam': 35000,
    'Extra Playtime Sore': 40000,
    'Menu Makanan Khusus': 50000,
  };

  const room = HOTEL_ROOMS.find((r) => r.id === roomId) ?? HOTEL_ROOMS[0];
  const total =
    room.pricePerNight * nights +
    extras.reduce((sum, key) => sum + (extraFees[key] ?? 0), 0);

  return (
    <div className="min-h-full bg-[#F4F8FC]">
      <PawcationHeader showBack onBack={() => onNavigate('home')} />
      <div className="space-y-4 px-4 pt-4 pb-8">
        <div>
          <span className="inline-flex items-center gap-1.5 rounded-full bg-[#E6F4FD] px-3 py-1 text-[11px] font-bold text-[#0284C7]">
            <Hotel className="h-3.5 w-3.5" />
            PET HOTEL SANCTUARY
          </span>
          <h1 className="mt-2 text-[21px] font-black text-[#1E293B]">
            Pesan Kamar Pet Hotel 🏨
          </h1>
        </div>

        <div className="flex items-center justify-between rounded-[22px] border border-[#E6EEF5] bg-white p-4 shadow-sm">
          <div>
            <p className="text-[12px] text-[#64748B]">Check-in</p>
            <p className="text-[14px] font-extrabold">Sab, 21 Okt • 13:00</p>
          </div>
          <div className="flex items-center gap-2.5">
            <button
              type="button"
              onClick={() => setNights((n) => Math.max(1, n - 1))}
              className="flex h-8 w-8 items-center justify-center rounded-full bg-[#F3F5F8] cursor-pointer"
            >
              <Minus className="h-4 w-4" />
            </button>
            <span className="text-[14px] font-extrabold text-[#0284C7]">
              {nights} Malam
            </span>
            <button
              type="button"
              onClick={() => setNights((n) => n + 1)}
              className="flex h-8 w-8 items-center justify-center rounded-full bg-[#F3F5F8] cursor-pointer"
            >
              <Plus className="h-4 w-4" />
            </button>
          </div>
        </div>

        <div className="space-y-3">
          {HOTEL_ROOMS.map((item) => {
            const active = item.id === roomId;
            return (
              <button
                key={item.id}
                type="button"
                onClick={() => setRoomId(item.id)}
                className={`w-full rounded-[22px] border bg-white p-4 text-left shadow-sm cursor-pointer ${
                  active ? 'border-2 border-[#0FA5E9]' : 'border-[#E6EEF5]'
                }`}
              >
                <div className="flex items-center justify-between">
                  <span className="text-[15.5px] font-extrabold">
                    {item.name}
                  </span>
                  <span className="rounded-full bg-[#E6F4FD] px-2.5 py-0.5 text-[11px] font-bold text-[#0284C7]">
                    {item.badge}
                  </span>
                </div>
                <p className="mt-1 text-[12.5px] text-[#64748B]">
                  {item.subtitle}
                </p>
                <div className="mt-2.5 flex flex-wrap gap-1.5">
                  {item.facilities.map((f) => (
                    <span
                      key={f}
                      className="rounded-full bg-[#F0F7FC] px-2.5 py-0.5 text-[11px] font-bold text-[#0284C7]"
                    >
                      {f}
                    </span>
                  ))}
                </div>
                <p className="mt-2.5 text-[15px] font-black text-[#0284C7]">
                  {formatRupiah(item.pricePerNight)} / malam
                </p>
              </button>
            );
          })}
        </div>

        <div className="rounded-[22px] border border-[#E6EEF5] bg-white p-4 shadow-sm">
          <p className="mb-2 text-[14.5px] font-extrabold">Layanan Tambahan</p>
          <div className="space-y-2.5">
            {Object.entries(extraFees).map(([label, fee]) => {
              const checked = extras.includes(label);
              return (
                <label
                  key={label}
                  className="flex items-center justify-between text-[13.5px] cursor-pointer"
                >
                  <div>
                    <p className="font-bold">{label}</p>
                    <p className="text-[12px] text-[#0284C7]">
                      +{formatRupiah(fee)}
                    </p>
                  </div>
                  <input
                    type="checkbox"
                    checked={checked}
                    onChange={() =>
                      setExtras((prev) =>
                        checked
                          ? prev.filter((x) => x !== label)
                          : [...prev, label],
                      )
                    }
                    className="h-4 w-4 accent-[#0FA5E9]"
                  />
                </label>
              );
            })}
          </div>
        </div>

        <div className="flex items-center justify-between rounded-[22px] bg-[#F0F7FC] p-4">
          <span className="text-[13px] font-bold text-[#64748B]">
            Estimasi Total
          </span>
          <span className="text-[20px] font-black text-[#0B4F6C]">
            {formatRupiah(total)}
          </span>
        </div>

        <button
          type="button"
          onClick={() => onCheckout(total, `${room.name} (${nights} Malam)`)}
          className="flex h-[50px] w-full items-center justify-center gap-2 rounded-full bg-[#0FA5E9] text-[15px] font-bold text-white cursor-pointer"
        >
          <span>Konfirmasi &amp; Bayar Kamar</span>
          <ArrowRight className="h-4 w-4" />
        </button>
      </div>
    </div>
  );
}

export function VetConsultScreen({
  onCheckout,
  onNavigate,
}: {
  onCheckout: (total: number, summary: string) => void;
  onNavigate: (r: RouteKey) => void;
}) {
  const [vetId, setVetId] = useState(VETS[0].id);
  const [mode, setMode] = useState('Chat Online');
  const [slot, setSlot] = useState('14:30');
  const vet = VETS.find((v) => v.id === vetId) ?? VETS[0];

  return (
    <div className="flex min-h-full flex-col bg-[#F4F8FC]">
      <PawcationHeader showBack onBack={() => onNavigate('home')} />
      <div className="flex-1 space-y-4 px-4 pt-4 pb-6">
        <div>
          <h1 className="text-[21px] font-black text-[#1E293B]">
            Konsultasi Dokter Hewan 🩺
          </h1>
          <p className="mt-1 text-[13px] text-[#64748B]">
            Pilih dokter hewan berlisensi &amp; waktu konsultasi untuk Dodo.
          </p>
        </div>

        <div className="space-y-2.5">
          {VETS.map((item) => {
            const active = item.id === vetId;
            return (
              <button
                key={item.id}
                type="button"
                onClick={() => setVetId(item.id)}
                className={`flex w-full items-center gap-3 rounded-[22px] border bg-white p-3.5 text-left shadow-sm cursor-pointer ${
                  active ? 'border-2 border-[#0FA5E9]' : 'border-[#E6EEF5]'
                }`}
              >
                <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-[#E6F4FD] text-[#0284C7]">
                  <Stethoscope className="h-5 w-5" />
                </div>
                <div className="min-w-0 flex-1">
                  <div className="flex items-center justify-between gap-2">
                    <span className="truncate text-[14px] font-extrabold">
                      {item.name}
                    </span>
                    <span className="rounded-full bg-[#E6F7F4] px-2.5 py-0.5 text-[11px] font-bold text-[#0D9488]">
                      Online
                    </span>
                  </div>
                  <p className="text-[12px] text-[#64748B]">
                    {item.specialty} • ★ {item.rating}
                  </p>
                </div>
              </button>
            );
          })}
        </div>

        <div>
          <p className="mb-2 text-[14.5px] font-extrabold">Metode &amp; Jadwal</p>
          <div className="flex flex-wrap gap-2">
            {['Chat Online', 'Video Call', 'Kunjungan Klinik'].map((m) => (
              <button
                key={m}
                type="button"
                onClick={() => setMode(m)}
                className={`rounded-full px-3.5 py-1.5 text-[12.5px] font-bold cursor-pointer ${
                  mode === m
                    ? 'bg-[#0FA5E9] text-white'
                    : 'border border-[#E6EEF5] bg-white text-[#1E293B]'
                }`}
              >
                {m}
              </button>
            ))}
          </div>
          <div className="mt-2.5 flex flex-wrap gap-2">
            {['14:30', '15:00', '16:15', '19:00'].map((s) => (
              <button
                key={s}
                type="button"
                onClick={() => setSlot(s)}
                className={`rounded-full px-3 py-1.5 text-[12px] font-bold cursor-pointer ${
                  slot === s
                    ? 'bg-[#E6F4FD] text-[#0284C7]'
                    : 'border border-[#E6EEF5] bg-white text-[#64748B]'
                }`}
              >
                {s} WIB
              </button>
            ))}
          </div>
        </div>

        <textarea
          rows={3}
          placeholder="Ceritakan kondisi Dodo saat ini..."
          className="w-full rounded-2xl border border-[#E6EEF5] bg-white p-3.5 text-[13.5px] outline-none"
        />

        <div className="flex items-center justify-between rounded-[22px] bg-[#F0F7FC] p-4">
          <div>
            <p className="text-[12px] text-[#64748B]">Biaya Konsultasi</p>
            <p className="text-[20px] font-black text-[#0B4F6C]">
              {formatRupiah(vet.fee)}
            </p>
          </div>
          <button
            type="button"
            onClick={() => onNavigate('consult-chat')}
            className="rounded-full bg-[#0FA5E9] px-5 py-3 text-[13.5px] font-extrabold text-white cursor-pointer"
          >
            Mulai Chat
          </button>
        </div>

        <button
          type="button"
          onClick={() =>
            onCheckout(vet.fee, `Konsultasi ${mode} (${slot}) - ${vet.name}`)
          }
          className="h-[46px] w-full rounded-full bg-[#E5F2FA] text-[14px] font-bold text-[#0284C7] cursor-pointer"
        >
          Bayar &amp; Jadwalkan Sesi
        </button>
      </div>

      <PawcationBottomNav activeRoute="vet-consult" onNavigate={onNavigate} />
    </div>
  );
}

export function ConsultChatScreen({
  messages,
  onSendMessage,
  onNavigate,
  onShowToast,
}: {
  messages: ChatMsg[];
  onSendMessage: (t: string) => void;
  onNavigate: (r: RouteKey) => void;
  onShowToast: (msg: string) => void;
}) {
  const [draft, setDraft] = useState('');

  return (
    <div className="flex min-h-full flex-col bg-[#F4F8FC]">
      <PawcationHeader showBack onBack={() => onNavigate('vet-consult')} />
      <div className="flex items-center gap-3 border-b border-[#E6EEF5] bg-white px-4 py-3">
        <div className="flex h-10 w-10 items-center justify-center rounded-full bg-[#E6F4FD] text-[#0284C7]">
          <Stethoscope className="h-5 w-5" />
        </div>
        <div className="flex-1">
          <p className="text-[14px] font-extrabold">
            drh. Amanda Saraswati, M.Si
          </p>
          <p className="text-[12px] font-semibold text-[#0D9488]">
            Online • Konsultasi Aktif
          </p>
        </div>
        <button
          type="button"
          aria-label="Panggil Dokter"
          onClick={() => onShowToast('Menghubungkan panggilan suara...')}
          className="text-[#0284C7] cursor-pointer"
        >
          <Phone className="h-5 w-5" />
        </button>
      </div>

      <div className="flex-1 space-y-3 p-4">
        {messages.map((m) => (
          <div
            key={m.id}
            className={`flex ${m.isUser ? 'justify-end' : 'justify-start'}`}
          >
            <div
              className={`max-w-[80%] rounded-2xl p-3.5 text-[13px] leading-relaxed ${
                m.isUser
                  ? 'bg-[#0FA5E9] text-white'
                  : 'border border-[#E6EEF5] bg-white text-[#1E293B]'
              }`}
            >
              <p>{m.text}</p>
              {m.recommendedProduct && (
                <button
                  type="button"
                  onClick={() => onNavigate('marketplace')}
                  className="mt-2.5 flex w-full items-center gap-2.5 rounded-xl bg-[#F0F7FC] p-2.5 text-left cursor-pointer"
                >
                  <span className="text-xl">🦴</span>
                  <div>
                    <p className="text-[12.5px] font-extrabold text-[#1E293B]">
                      {m.recommendedProduct}
                    </p>
                    <p className="text-[11.5px] font-bold text-[#0284C7]">
                      Rp 115.000 • Lihat Produk →
                    </p>
                  </div>
                </button>
              )}
              <p
                className={`mt-1.5 text-right text-[10.5px] ${
                  m.isUser ? 'text-white/80' : 'text-[#94A3B8]'
                }`}
              >
                {m.time}
              </p>
            </div>
          </div>
        ))}
      </div>

      <form
        onSubmit={(e) => {
          e.preventDefault();
          if (!draft.trim()) return;
          onSendMessage(draft);
          setDraft('');
        }}
        className="sticky bottom-0 flex items-center gap-2 border-t border-[#E6EEF5] bg-white px-3.5 py-2.5"
      >
        <input
          value={draft}
          onChange={(e) => setDraft(e.target.value)}
          placeholder="Tulis pesan untuk dokter..."
          className="h-11 flex-1 rounded-full bg-[#F3F5F8] px-4 text-[13.5px] outline-none"
        />
        <button
          type="submit"
          aria-label="Kirim pesan"
          className="flex h-11 w-11 items-center justify-center rounded-full bg-[#0FA5E9] text-white cursor-pointer"
        >
          <Send className="h-4 w-4" />
        </button>
      </form>
    </div>
  );
}

export function LiveCamScreen({onNavigate}: {onNavigate: (r: RouteKey) => void}) {
  const [cam, setCam] = useState('Kamera Suite A-12');
  const [micOn, setMicOn] = useState(false);

  return (
    <div className="min-h-full bg-[#F4F8FC]">
      <PawcationHeader showBack onBack={() => onNavigate('home')} />
      <div className="space-y-4 px-4 pt-4 pb-8">
        <div className="flex items-center justify-between">
          <h1 className="text-[20px] font-black text-[#1E293B]">
            Live Monitoring Dodo 📹
          </h1>
          <span className="inline-flex items-center gap-1.5 rounded-full bg-[#FEE2E2] px-3 py-1 text-[11.5px] font-extrabold text-[#EF4444]">
            <span className="h-2 w-2 rounded-full bg-[#EF4444]" />
            LIVE
          </span>
        </div>

        <div className="relative h-56 overflow-hidden rounded-[24px] bg-[#0F2B3C] shadow-sm">
          <img
            src="/assets/images/dodo_avatar.png"
            alt="Live Cam Dodo"
            className="h-full w-full object-cover opacity-90"
          />
          <div className="absolute inset-0 flex flex-col justify-between bg-gradient-to-b from-black/35 via-transparent to-black/65 p-3.5 text-white">
            <div className="flex justify-between text-[11.5px] font-bold">
              <span className="rounded-full bg-black/45 px-3 py-1">{cam}</span>
              <span className="rounded-full bg-black/45 px-3 py-1">
                HD 1080p
              </span>
            </div>
            <div className="flex items-center justify-between">
              <span className="text-[13.5px] font-bold">
                Dodo sedang istirahat tenang
              </span>
              <button
                type="button"
                aria-label="Toggle mikrofon"
                onClick={() => setMicOn((v) => !v)}
                className={`flex h-9 w-9 items-center justify-center rounded-full cursor-pointer ${
                  micOn ? 'bg-[#0FA5E9]' : 'bg-black/45'
                }`}
              >
                {micOn ? (
                  <Mic className="h-4 w-4" />
                ) : (
                  <MicOff className="h-4 w-4" />
                )}
              </button>
            </div>
          </div>
        </div>

        <div className="flex gap-2">
          {['Kamera Suite A-12', 'Taman Bermain'].map((c) => (
            <button
              key={c}
              type="button"
              onClick={() => setCam(c)}
              className={`rounded-full px-3.5 py-1.5 text-[12.5px] font-bold cursor-pointer ${
                cam === c
                  ? 'bg-[#E6F4FD] text-[#0284C7]'
                  : 'border border-[#E6EEF5] bg-white text-[#64748B]'
              }`}
            >
              {c}
            </button>
          ))}
        </div>

        <div className="grid grid-cols-3 gap-2.5 text-center">
          {[
            {
              label: 'Suhu Kamar',
              val: '23°C',
              icon: <Thermometer className="h-5 w-5 text-[#0FA5E9]" />,
            },
            {
              label: 'Aktivitas',
              val: 'Aktif',
              icon: <Heart className="h-5 w-5 text-[#0FA5E9]" />,
            },
            {
              label: 'Makan',
              val: 'Habis',
              icon: <ShoppingBag className="h-5 w-5 text-[#0FA5E9]" />,
            },
          ].map((m) => (
            <div
              key={m.label}
              className="flex flex-col items-center rounded-[18px] border border-[#E6EEF5] bg-white p-3"
            >
              {m.icon}
              <span className="mt-1.5 text-[15px] font-black">{m.val}</span>
              <span className="text-[11px] text-[#64748B]">{m.label}</span>
            </div>
          ))}
        </div>

        <div className="space-y-2 rounded-[22px] border border-[#E6EEF5] bg-white p-4 text-[12.5px]">
          <p className="text-[15px] font-extrabold text-[#1E293B]">
            Log Aktivitas Hari Ini
          </p>
          <p>
            <strong className="text-[#0284C7]">13:30 WIB</strong> — Jalan sore
            di taman indoor 20 menit
          </p>
          <p>
            <strong className="text-[#0284C7]">12:00 WIB</strong> — Makan siang
            Royal Canin + air segar
          </p>
          <p>
            <strong className="text-[#0284C7]">09:30 WIB</strong> — Pengecekan
            suhu &amp; kebersihan suite
          </p>
        </div>

        <button
          type="button"
          onClick={() => onNavigate('consult-chat')}
          className="flex h-[50px] w-full items-center justify-center gap-2 rounded-full bg-[#0FA5E9] text-[15px] font-bold text-white cursor-pointer"
        >
          <MessageSquare className="h-4 w-4" />
          <span>Chat Pengasuh / Dokter Jaga</span>
        </button>
      </div>
    </div>
  );
}

export function PetTaxiScreen({
  onCheckout,
  onNavigate,
}: {
  onCheckout: (total: number, summary: string) => void;
  onNavigate: (r: RouteKey) => void;
}) {
  const [fleet, setFleet] = useState<TaxiFleetType>('PawCar Standard');
  const [pickup, setPickup] = useState<TaxiLocation>(TAXI_LOCATIONS[0]);
  const [dropoff, setDropoff] = useState<TaxiLocation>(TAXI_LOCATIONS[1]);
  const [editingStop, setEditingStop] = useState<'pickup' | 'dropoff' | null>(
    null,
  );
  const [customDraft, setCustomDraft] = useState('');
  const [pinMode, setPinMode] = useState<'pickup' | 'dropoff'>('dropoff');

  const quote = calculatePetTaxiQuote(pickup, dropoff, fleet);
  const carQuote = calculatePetTaxiQuote(pickup, dropoff, 'PawCar Standard');
  const vanQuote = calculatePetTaxiQuote(pickup, dropoff, 'PawVan AC + Crate');

  const openEditor = (stop: 'pickup' | 'dropoff') => {
    if (editingStop === stop) {
      setEditingStop(null);
      return;
    }
    setEditingStop(stop);
    setPinMode(stop);
    setCustomDraft(stop === 'pickup' ? pickup.address : dropoff.address);
  };

  const applyCustomAddress = () => {
    const trimmed = customDraft.trim();
    if (!trimmed) return;
    if (editingStop === 'pickup') {
      setPickup((prev) => ({
        ...prev,
        id: 'custom-pickup',
        name: trimmed.split('•')[0].trim() || trimmed,
        address: trimmed,
        area: 'Alamat Custom',
      }));
    } else if (editingStop === 'dropoff') {
      setDropoff((prev) => ({
        ...prev,
        id: 'custom-dropoff',
        name: trimmed.split('•')[0].trim() || trimmed,
        address: trimmed,
        area: 'Alamat Custom',
      }));
    }
    setEditingStop(null);
  };

  const handleSelectPreset = (
    stop: 'pickup' | 'dropoff',
    loc: TaxiLocation,
  ) => {
    if (stop === 'pickup') {
      setPickup(loc);
    } else {
      setDropoff(loc);
    }
    setEditingStop(null);
  };

  const handleMapClick = (e: React.MouseEvent<SVGSVGElement>) => {
    const rect = e.currentTarget.getBoundingClientRect();
    if (rect.width <= 0 || rect.height <= 0) return;
    const xPct = ((e.clientX - rect.left) / rect.width) * 100;
    const yPct = ((e.clientY - rect.top) / rect.height) * 100;
    const nextPin = createCustomPinLocation(pinMode, xPct, yPct);
    if (pinMode === 'pickup') {
      setPickup(nextPin);
    } else {
      setDropoff(nextPin);
    }
  };

  const handleSwapRoute = () => {
    const prevPickup = pickup;
    setPickup(dropoff);
    setDropoff(prevPickup);
  };

  const midX = (pickup.xPct + dropoff.xPct) / 2;
  const midY = (pickup.yPct + dropoff.yPct) / 2;
  const curveCx = midX;
  const curveCy = Math.max(10, Math.min(90, midY - 12));

  return (
    <div className="min-h-full bg-[#F4F8FC]">
      <PawcationHeader showBack onBack={() => onNavigate('home')} />
      <div className="space-y-4 px-4 pt-4 pb-8">
        <h1 className="text-[21px] font-black text-[#1E293B]">
          Pemesanan Pet Taxi 🚕
        </h1>

        <div className="rounded-[22px] border border-[#E6EEF5] bg-[#E6F4FD] p-4">
          <div className="flex items-center justify-between gap-2">
            <span className="rounded-full bg-white px-3 py-1 text-[11.5px] font-bold text-[#0284C7]">
              ETA {quote.etaMinutes} Menit
            </span>
            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={handleSwapRoute}
                aria-label="Tukar lokasi jemput dan tujuan"
                className="inline-flex items-center gap-1 rounded-full bg-white px-2.5 py-1 text-[11px] font-bold text-[#0284C7] hover:bg-[#F0F7FC] cursor-pointer"
              >
                <ArrowUpDown className="h-3 w-3" />
                <span>Tukar</span>
              </button>
              <span className="text-[13px] font-extrabold text-[#0B4F6C]">
                {quote.distanceKm.toFixed(1)} km
              </span>
            </div>
          </div>

          <div className="mt-3.5 space-y-2.5">
            <div className="flex items-start justify-between gap-2 rounded-2xl bg-white/75 p-2.5">
              <div className="min-w-0 flex-1">
                <p className="text-[11px] font-bold text-[#0284C7]">Jemput</p>
                <p className="text-[13.5px] font-extrabold text-[#1E293B]">
                  {pickup.address}
                </p>
              </div>
              <button
                type="button"
                onClick={() => openEditor('pickup')}
                className="inline-flex shrink-0 items-center gap-1 rounded-full bg-[#E6F4FD] px-2.5 py-1 text-[11px] font-bold text-[#0284C7] hover:bg-[#D5ECFA] cursor-pointer"
              >
                <Pencil className="h-3 w-3" />
                <span>{editingStop === 'pickup' ? 'Tutup' : 'Ubah'}</span>
              </button>
            </div>

            <div className="flex items-start justify-between gap-2 rounded-2xl bg-white/75 p-2.5">
              <div className="min-w-0 flex-1">
                <p className="text-[11px] font-bold text-[#0D9488]">Tujuan</p>
                <p className="text-[13.5px] font-extrabold text-[#1E293B]">
                  {dropoff.address}
                </p>
              </div>
              <button
                type="button"
                onClick={() => openEditor('dropoff')}
                className="inline-flex shrink-0 items-center gap-1 rounded-full bg-[#E6F7F4] px-2.5 py-1 text-[11px] font-bold text-[#0D9488] hover:bg-[#D1F2EB] cursor-pointer"
              >
                <Pencil className="h-3 w-3" />
                <span>{editingStop === 'dropoff' ? 'Tutup' : 'Ubah'}</span>
              </button>
            </div>
          </div>

          {editingStop && (
            <div className="mt-3 rounded-2xl border border-[#BAE6FD] bg-white p-3">
              <p className="text-[12px] font-extrabold text-[#1E293B]">
                {editingStop === 'pickup'
                  ? 'Ubah Lokasi Penjemputan'
                  : 'Ubah Lokasi Tujuan'}
              </p>
              <div className="mt-2 flex gap-1.5">
                <input
                  value={customDraft}
                  onChange={(e) => setCustomDraft(e.target.value)}
                  placeholder="Ketik alamat atau pilih titik cepat..."
                  aria-label={
                    editingStop === 'pickup'
                      ? 'Alamat penjemputan'
                      : 'Alamat tujuan'
                  }
                  className="h-9 flex-1 rounded-xl border border-[#E6EEF5] bg-[#F8FBFE] px-3 text-[12px] font-medium text-[#1E293B] outline-none focus:border-[#0FA5E9]"
                />
                <button
                  type="button"
                  onClick={applyCustomAddress}
                  className="inline-flex h-9 items-center gap-1 rounded-xl bg-[#0FA5E9] px-3 text-[11.5px] font-bold text-white cursor-pointer"
                >
                  <Check className="h-3.5 w-3.5" />
                  <span>Simpan</span>
                </button>
              </div>
              <p className="mt-2.5 text-[11px] font-bold text-[#64748B]">
                Lokasi Populer Pawcation:
              </p>
              <div className="mt-1.5 flex flex-wrap gap-1.5">
                {TAXI_LOCATIONS.map((loc) => {
                  const active =
                    editingStop === 'pickup'
                      ? pickup.id === loc.id
                      : dropoff.id === loc.id;
                  return (
                    <button
                      key={loc.id}
                      type="button"
                      onClick={() => handleSelectPreset(editingStop, loc)}
                      className={`rounded-full px-2.5 py-1 text-[11px] font-bold cursor-pointer ${
                        active
                          ? 'bg-[#0FA5E9] text-white'
                          : 'bg-[#F0F7FC] text-[#0284C7] hover:bg-[#E0F2FE]'
                      }`}
                    >
                      {loc.name}
                    </button>
                  );
                })}
              </div>
            </div>
          )}

          {/* Interactive City Route Map */}
          <div className="mt-3.5 rounded-2xl border border-[#BAE6FD] bg-white p-3">
            <div className="mb-2 flex items-center justify-between gap-2">
              <div className="flex min-w-0 items-center gap-1.5">
                <MapPin className="h-3.5 w-3.5 shrink-0 text-[#0FA5E9]" />
                <span className="truncate text-[12px] font-extrabold text-[#1E293B]">
                  Peta Rute
                </span>
              </div>
              <div className="flex shrink-0 items-center gap-1 rounded-full bg-[#F3F5F8] p-0.5">
                <button
                  type="button"
                  onClick={() => setPinMode('pickup')}
                  className={`whitespace-nowrap rounded-full px-2.5 py-1 text-[10px] font-bold cursor-pointer ${
                    pinMode === 'pickup'
                      ? 'bg-[#0FA5E9] text-white'
                      : 'text-[#64748B]'
                  }`}
                >
                  Pin Jemput
                </button>
                <button
                  type="button"
                  onClick={() => setPinMode('dropoff')}
                  className={`whitespace-nowrap rounded-full px-2.5 py-1 text-[10px] font-bold cursor-pointer ${
                    pinMode === 'dropoff'
                      ? 'bg-[#0D9488] text-white'
                      : 'text-[#64748B]'
                  }`}
                >
                  Pin Tujuan
                </button>
              </div>
            </div>

            <div className="relative overflow-hidden rounded-xl border border-[#E2EEF8] bg-[#F4FAFF]">
              <svg
                viewBox="0 0 320 180"
                role="img"
                aria-label="Peta rute Pet Taxi untuk memilih titik jemput, tujuan, dan menganalisis tarif"
                onClick={handleMapClick}
                className="block h-44 w-full cursor-crosshair select-none"
              >
                {/* City blocks & parks */}
                <rect x="0" y="0" width="320" height="180" fill="#F2F8FD" />
                <rect x="20" y="18" width="64" height="36" rx="8" fill="#E6F2FA" />
                <rect x="108" y="14" width="84" height="42" rx="8" fill="#DCFCE7" />
                <rect x="216" y="18" width="84" height="46" rx="8" fill="#E6F2FA" />
                <rect x="24" y="76" width="70" height="44" rx="8" fill="#DCFCE7" />
                <rect x="116" y="74" width="86" height="48" rx="8" fill="#E6F2FA" />
                <rect x="220" y="84" width="78" height="72" rx="8" fill="#E6F2FA" />
                <rect x="24" y="134" width="168" height="32" rx="8" fill="#E6F2FA" />

                {/* Subtle 1 km grid lines */}
                {[40, 80, 120, 160, 200, 240, 280].map((gx) => (
                  <line
                    key={`gx-${gx}`}
                    x1={gx}
                    y1={0}
                    x2={gx}
                    y2={180}
                    stroke="#DCEAF5"
                    strokeWidth="1"
                  />
                ))}
                {[30, 60, 90, 120, 150].map((gy) => (
                  <line
                    key={`gy-${gy}`}
                    x1={0}
                    y1={gy}
                    x2={320}
                    y2={gy}
                    stroke="#DCEAF5"
                    strokeWidth="1"
                  />
                ))}

                {/* Main roads */}
                <path
                  d="M0 64 H320 M0 126 H320 M98 0 V180 M208 0 V180"
                  stroke="#FFFFFF"
                  strokeWidth="6"
                  fill="none"
                />
                <path
                  d="M0 64 H320 M0 126 H320 M98 0 V180 M208 0 V180"
                  stroke="#CBD5E1"
                  strokeWidth="1"
                  strokeDasharray="4 4"
                  fill="none"
                />

                {/* Preset landmark dots */}
                {TAXI_LOCATIONS.map((loc) => {
                  const lx = (loc.xPct / 100) * 320;
                  const ly = (loc.yPct / 100) * 180;
                  const isEndpoint =
                    loc.id === pickup.id || loc.id === dropoff.id;
                  if (isEndpoint) return null;
                  return (
                    <g
                      key={loc.id}
                      onClick={(ev) => {
                        ev.stopPropagation();
                        if (pinMode === 'pickup') setPickup(loc);
                        else setDropoff(loc);
                      }}
                      className="cursor-pointer"
                    >
                      <circle
                        cx={lx}
                        cy={ly}
                        r="5"
                        fill="#FFFFFF"
                        stroke="#64748B"
                        strokeWidth="2"
                      />
                      <text
                        x={lx}
                        y={ly - 8}
                        textAnchor="middle"
                        fontSize="7.5"
                        fontWeight="700"
                        fill="#475569"
                        stroke="#FFFFFF"
                        strokeWidth="2.5"
                        paintOrder="stroke"
                      >
                        {loc.name}
                      </text>
                    </g>
                  );
                })}

                {/* Route curve between pickup and dropoff */}
                <path
                  d={`M ${(pickup.xPct / 100) * 320} ${(pickup.yPct / 100) * 180} Q ${(curveCx / 100) * 320} ${(curveCy / 100) * 180} ${(dropoff.xPct / 100) * 320} ${(dropoff.yPct / 100) * 180}`}
                  stroke="#0FA5E9"
                  strokeWidth="4"
                  strokeLinecap="round"
                  strokeDasharray="7 5"
                  fill="none"
                />

                {/* Pickup pin */}
                <g
                  transform={`translate(${(pickup.xPct / 100) * 320}, ${(pickup.yPct / 100) * 180})`}
                >
                  <circle r="13" fill="#0FA5E9" fillOpacity="0.2" />
                  <circle
                    r="7.5"
                    fill="#0FA5E9"
                    stroke="#FFFFFF"
                    strokeWidth="2.5"
                  />
                  <rect
                    x="-28"
                    y="-25"
                    width="56"
                    height="15"
                    rx="7.5"
                    fill="#0284C7"
                  />
                  <text
                    x="0"
                    y="-15"
                    textAnchor="middle"
                    fontSize="8.5"
                    fontWeight="800"
                    fill="#FFFFFF"
                  >
                    Jemput
                  </text>
                </g>

                {/* Dropoff pin */}
                <g
                  transform={`translate(${(dropoff.xPct / 100) * 320}, ${(dropoff.yPct / 100) * 180})`}
                >
                  <circle r="13" fill="#0D9488" fillOpacity="0.2" />
                  <circle
                    r="7.5"
                    fill="#0D9488"
                    stroke="#FFFFFF"
                    strokeWidth="2.5"
                  />
                  <rect
                    x="-28"
                    y="-25"
                    width="56"
                    height="15"
                    rx="7.5"
                    fill="#0D9488"
                  />
                  <text
                    x="0"
                    y="-15"
                    textAnchor="middle"
                    fontSize="8.5"
                    fontWeight="800"
                    fill="#FFFFFF"
                  >
                    Tujuan
                  </text>
                </g>

                {/* Distance + fare pill at route midpoint */}
                <g
                  transform={`translate(${(curveCx / 100) * 320}, ${((curveCy + midY) / 2 / 100) * 180})`}
                >
                  <rect
                    x="-46"
                    y="-10"
                    width="92"
                    height="20"
                    rx="10"
                    fill="#0B4F6C"
                  />
                  <text
                    x="0"
                    y="3.5"
                    textAnchor="middle"
                    fontSize="9"
                    fontWeight="800"
                    fill="#FFFFFF"
                  >
                    {quote.distanceKm.toFixed(1)} km • {formatRupiah(quote.totalFare)}
                  </text>
                </g>
              </svg>

              <div className="flex items-center justify-between border-t border-[#E6EEF5] bg-white px-2.5 py-1.5 text-[10.5px] font-semibold text-[#64748B]">
                <span>
                  Ketuk peta atau titik untuk ubah{' '}
                  <strong
                    className={
                      pinMode === 'pickup'
                        ? 'text-[#0284C7]'
                        : 'text-[#0D9488]'
                    }
                  >
                    {pinMode === 'pickup' ? 'Jemput' : 'Tujuan'}
                  </strong>
                </span>
                <span className="font-bold text-[#0B4F6C]">Skala 8×6 km</span>
              </div>
            </div>

            {/* Fare Analysis Breakdown */}
            <div className="mt-2.5 rounded-xl bg-[#F0F7FC] p-3 text-[12px]">
              <div className="flex items-center justify-between">
                <span className="inline-flex items-center gap-1.5 font-extrabold text-[#1E293B]">
                  <Navigation className="h-3.5 w-3.5 text-[#0FA5E9]" />
                  Rincian Tarif
                </span>
                <span className="rounded-full bg-white px-2 py-0.5 text-[10.5px] font-extrabold text-[#0284C7]">
                  {quote.distanceKm.toFixed(1)} km • {quote.etaMinutes} mnt
                </span>
              </div>
              <div className="mt-2 space-y-1 text-[11.5px]">
                <div className="flex justify-between text-[#64748B]">
                  <span>Tarif Dasar ({fleet})</span>
                  <span className="font-bold text-[#1E293B]">
                    {formatRupiah(quote.baseFare)}
                  </span>
                </div>
                <div className="flex justify-between text-[#64748B]">
                  <span>
                    Biaya Jarak ({quote.distanceKm.toFixed(1)} km ×{' '}
                    {formatRupiah(quote.perKmRate)})
                  </span>
                  <span className="font-bold text-[#1E293B]">
                    {formatRupiah(quote.distanceFee)}
                  </span>
                </div>
                <div className="my-1 h-px bg-[#DCEAF5]" />
                <div className="flex justify-between text-[12.5px]">
                  <span className="font-extrabold text-[#1E293B]">
                    Estimasi Total
                  </span>
                  <span className="font-black text-[#0B4F6C]">
                    {formatRupiah(quote.totalFare)}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="space-y-2.5">
          {(['PawCar Standard', 'PawVan AC + Crate'] as TaxiFleetType[]).map(
            (opt) => {
              const active = fleet === opt;
              const price =
                opt === 'PawCar Standard'
                  ? carQuote.totalFare
                  : vanQuote.totalFare;
              return (
                <button
                  key={opt}
                  type="button"
                  onClick={() => setFleet(opt)}
                  className={`flex w-full items-center gap-3 rounded-[22px] border bg-white p-3.5 text-left cursor-pointer ${
                    active ? 'border-2 border-[#0FA5E9]' : 'border-[#E6EEF5]'
                  }`}
                >
                  <div className="flex h-10 w-10 items-center justify-center rounded-full bg-[#E6F4FD] text-[#0284C7]">
                    <Car className="h-5 w-5" />
                  </div>
                  <div className="flex-1">
                    <p className="text-[14.5px] font-extrabold">{opt}</p>
                    <p className="text-[12px] text-[#64748B]">
                      Disinfeksi UV • Driver tersertifikasi
                    </p>
                  </div>
                  <span className="text-[14.5px] font-black text-[#0284C7]">
                    {formatRupiah(price)}
                  </span>
                </button>
              );
            },
          )}
        </div>

        <div className="flex items-center gap-3 rounded-[22px] border border-[#E6EEF5] bg-white p-3.5">
          <div className="flex h-11 w-11 items-center justify-center rounded-full bg-[#E6F4FD] font-extrabold text-[#0284C7]">
            MB
          </div>
          <div className="flex-1">
            <p className="text-[14px] font-extrabold">Mas Budi • B 1824 PAW</p>
            <p className="text-[12px] text-[#64748B]">
              ★ 4.9 • 320+ perjalanan anabul
            </p>
          </div>
          <button
            type="button"
            onClick={() => onNavigate('consult-chat')}
            className="text-[#0FA5E9] cursor-pointer"
          >
            <MessageSquare className="h-5 w-5" />
          </button>
        </div>

        <button
          type="button"
          onClick={() =>
            onCheckout(
              quote.totalFare,
              `Pet Taxi (${fleet}) • ${pickup.name} → ${dropoff.name} (${quote.distanceKm.toFixed(1)} km)`,
            )
          }
          className="flex h-[50px] w-full items-center justify-center gap-2 rounded-full bg-[#0FA5E9] text-[15px] font-bold text-white cursor-pointer"
        >
          <span>Pesan Pet Taxi ({formatRupiah(quote.totalFare)})</span>
          <ArrowRight className="h-4 w-4" />
        </button>
      </div>
    </div>
  );
}

export function AccountScreen({
  ownerName,
  ownerEmail,
  pawPoints,
  onNavigate,
}: {
  ownerName: string;
  ownerEmail: string;
  pawPoints: number;
  onNavigate: (r: RouteKey) => void;
}) {
  const [notif, setNotif] = useState(true);

  return (
    <div className="flex min-h-full flex-col bg-[#F4F8FC]">
      <PawcationHeader showBack onBack={() => onNavigate('home')} />
      <div className="flex-1 space-y-4 px-4 pt-4 pb-6">
        <div className="flex items-center gap-3.5 rounded-[22px] border border-[#E6EEF5] bg-white p-4 shadow-sm">
          <div className="flex h-14 w-14 items-center justify-center rounded-full bg-[#E6F4FD] text-[20px] font-black text-[#0284C7]">
            {ownerName.slice(0, 2).toUpperCase()}
          </div>
          <div>
            <p className="text-[17px] font-black">{ownerName}</p>
            <p className="text-[12.5px] text-[#64748B]">{ownerEmail}</p>
            <span className="mt-1.5 inline-block rounded-full bg-[#E6F4FD] px-2.5 py-0.5 text-[11px] font-bold text-[#0284C7]">
              ★ {pawPoints} PawPoints • Sanctuary Member
            </span>
          </div>
        </div>

        <button
          type="button"
          onClick={() => onNavigate('medical')}
          className="flex w-full items-center gap-3 rounded-[22px] border border-[#E6EEF5] bg-[#F0F7FC] p-4 text-left cursor-pointer"
        >
          <img
            src="/assets/images/dodo_avatar.png"
            alt="Dodo"
            className="h-13 w-13 rounded-full object-cover"
          />
          <div className="flex-1">
            <div className="flex items-center gap-2">
              <span className="text-[16px] font-black">Dodo</span>
              <span className="rounded-full bg-[#E6F7F4] px-2.5 py-0.5 text-[11px] font-bold text-[#0D9488]">
                Sedang Boarding
              </span>
            </div>
            <p className="text-[12.5px] text-[#64748B]">
              Toy Poodle • 2 Tahun • 5.2 kg
            </p>
          </div>
          <ArrowRight className="h-4 w-4 text-[#0284C7]" />
        </button>

        <div className="divide-y divide-[#E6EEF5] rounded-[22px] border border-[#E6EEF5] bg-white px-4 shadow-sm">
          <button
            type="button"
            onClick={() => onNavigate('medical')}
            className="flex w-full items-center justify-between py-3.5 text-[14px] font-bold cursor-pointer"
          >
            <span>Rekam Medis &amp; Buku Vaksin</span>
            <ArrowRight className="h-4 w-4 text-[#64748B]" />
          </button>
          <button
            type="button"
            onClick={() => onNavigate('payment-status')}
            className="flex w-full items-center justify-between py-3.5 text-[14px] font-bold cursor-pointer"
          >
            <span>Riwayat Pembayaran</span>
            <ArrowRight className="h-4 w-4 text-[#64748B]" />
          </button>
          <label className="flex items-center justify-between py-3.5 text-[14px] font-bold cursor-pointer">
            <span>Notifikasi Jadwal &amp; Vaksin</span>
            <input
              type="checkbox"
              checked={notif}
              onChange={(e) => setNotif(e.target.checked)}
              className="h-4 w-4 accent-[#0FA5E9]"
            />
          </label>
        </div>

        <button
          type="button"
          onClick={() => onNavigate('login')}
          className="flex h-12 w-full items-center justify-center gap-2 rounded-full border border-[#FEE2E2] bg-white text-[14px] font-extrabold text-[#EF4444] cursor-pointer"
        >
          <LogOut className="h-4 w-4" />
          <span>Keluar Akun</span>
        </button>
      </div>

      <PawcationBottomNav activeRoute="account" onNavigate={onNavigate} />
    </div>
  );
}

export function PetMedicalScreen({
  onNavigate,
}: {
  onNavigate: (r: RouteKey) => void;
}) {
  return (
    <div className="min-h-full bg-[#F4F8FC]">
      <PawcationHeader showBack onBack={() => onNavigate('schedule')} />
      <div className="flex flex-col items-center space-y-4 px-4 pt-4 pb-8">
        <img
          src="/assets/images/dodo_avatar.png"
          alt="Dodo"
          className="h-22 w-22 rounded-full object-cover shadow-sm"
        />
        <div className="text-center">
          <h1 className="text-[21px] font-black text-[#1E293B]">Dodo 🐶</h1>
          <p className="text-[12.5px] text-[#64748B]">
            Toy Poodle • ID: #PC-MC-2022-8819
          </p>
        </div>

        <div className="grid w-full grid-cols-2 gap-2.5">
          {[
            ['Berat Badan', '5.2 kg', 'Ideal'],
            ['Suhu Tubuh', '38.4°C', 'Normal'],
            ['Status Vaksin', 'Lengkap', 'Aktif'],
            ['Alergi', 'Ayam', 'Catatan'],
          ].map(([label, value, tag]) => (
            <div
              key={label}
              className="rounded-[18px] border border-[#E6EEF5] bg-white p-3.5"
            >
              <p className="text-[12px] text-[#64748B]">{label}</p>
              <div className="mt-1 flex items-center justify-between">
                <span className="text-[16px] font-black">{value}</span>
                <span className="rounded-full bg-[#E6F4FD] px-2.5 py-0.5 text-[11px] font-bold text-[#0284C7]">
                  {tag}
                </span>
              </div>
            </div>
          ))}
        </div>

        <div className="w-full rounded-[22px] bg-[#0B4F6C] p-4.5 text-white shadow-sm">
          <p className="flex items-center gap-2 text-[11.5px] font-extrabold tracking-wider text-[#BAE6FD]">
            <ShieldCheck className="h-4 w-4" />
            PASPOR VAKSIN DIGITAL
          </p>
          <p className="mt-2.5 text-[17px] font-black">
            Rabies &amp; DHPPi Terverifikasi
          </p>
          <p className="mt-1 text-[12.5px] text-[#E0F2FE]">
            Vaksin Terakhir: Agustus 2025 • Booster Berikutnya: 24 Des 2026
          </p>
        </div>

        <div className="w-full space-y-3 rounded-[22px] border border-[#E6EEF5] bg-white p-4">
          <p className="text-[15.5px] font-extrabold">
            Riwayat Pemeriksaan Medis
          </p>
          <div className="flex items-center justify-between">
            <div>
              <p className="text-[13.5px] font-bold">
                Pemeriksaan Umum &amp; Kebersihan Telinga
              </p>
              <p className="text-[12px] text-[#64748B]">
                12 Okt 2024 • drh. Amanda Saraswati, M.Si
              </p>
            </div>
            <span className="rounded-full bg-[#E6F7F4] px-2.5 py-0.5 text-[11px] font-bold text-[#0D9488]">
              Sehat
            </span>
          </div>
          <div className="h-px bg-[#E2E8F0]" />
          <div className="flex items-center justify-between">
            <div>
              <p className="text-[13.5px] font-bold">
                Vaksinasi Rabies Tahunan
              </p>
              <p className="text-[12px] text-[#64748B]">
                18 Agu 2025 • Klinik Pawcation Kemang
              </p>
            </div>
            <span className="rounded-full bg-[#E6F7F4] px-2.5 py-0.5 text-[11px] font-bold text-[#0D9488]">
              Sah
            </span>
          </div>
        </div>

        <button
          type="button"
          onClick={() => onNavigate('schedule')}
          className="flex h-[50px] w-full items-center justify-center gap-2 rounded-full bg-[#0FA5E9] text-[15px] font-bold text-white cursor-pointer"
        >
          <Calendar className="h-4 w-4" />
          <span>Kembali ke Jadwal &amp; Agenda</span>
        </button>
      </div>
    </div>
  );
}
