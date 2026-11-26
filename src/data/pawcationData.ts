import type {AgendaItem, CartEntry, ProductItem} from '../utils/pawcationLogic';

export const PRODUCTS: ProductItem[] = [
  {
    id: 'p1',
    name: 'Royal Canin Mini Adult',
    category: 'Makanan',
    price: 185000,
    weightLabel: '2 kg',
    rating: 4.9,
    badge: 'Terlaris',
    emoji: '🥣',
  },
  {
    id: 'p2',
    name: 'PawDental Fresh Chews',
    category: 'Vitamin',
    price: 115000,
    weightLabel: '140 g',
    rating: 4.8,
    badge: 'Rekomendasi Vet',
    emoji: '🦴',
  },
  {
    id: 'p3',
    name: 'Gentle Coat Oatmeal Shampoo',
    category: 'Grooming',
    price: 98000,
    weightLabel: '300 ml',
    rating: 4.9,
    badge: 'Pet-Safe',
    emoji: '🫧',
  },
  {
    id: 'p4',
    name: 'Omega-3 Coat Booster Drops',
    category: 'Vitamin',
    price: 135000,
    weightLabel: '60 ml',
    rating: 4.7,
    badge: 'Baru',
    emoji: '💧',
  },
  {
    id: 'p5',
    name: 'CloudSoft Orthopedic Bed',
    category: 'Aksesoris',
    price: 265000,
    weightLabel: 'Size M',
    rating: 4.9,
    badge: 'Favorit',
    emoji: '🛏️',
  },
  {
    id: 'p6',
    name: 'Probiotic Digestive Treats',
    category: 'Makanan',
    price: 89000,
    weightLabel: '120 g',
    rating: 4.8,
    badge: 'Organik',
    emoji: '🍖',
  },
];

export const INITIAL_CART: CartEntry[] = [
  {product: PRODUCTS[0], quantity: 1, selected: true},
  {product: PRODUCTS[1], quantity: 2, selected: true},
];

export const INITIAL_AGENDAS: AgendaItem[] = [
  {
    id: 'a1',
    timeBadge: 'Hari Ini',
    petLabel: 'Dodo • Poodle',
    statusLabel: 'Dikonfirmasi',
    status: 'confirmed',
    title: 'Grooming Lengkap',
    dateTimeLabel: '14:00 WIB (Siang Ini)',
    location: 'Pawcation Salon & Spa (Cabang Malang)',
    personLabel: 'Groomer: Mas Budi • Disinfeksi Pet-Safe',
    noteLabel: 'Driver Siap Menjemput (13:15)',
    primaryActionLabel: 'Detail Pet Taxi',
    secondaryActionLabel: 'Ingatkan 1 Jam',
    dayOfMonth: 21,
  },
  {
    id: 'a2',
    timeBadge: 'Dalam 3 Hari',
    petLabel: 'Dodo • Poodle',
    statusLabel: 'Terjadwal',
    status: 'scheduled',
    title: 'Vaksinasi Tahunan Rabies & DHPPi 💉',
    dateTimeLabel: 'Sel, 24 Okt • 10:30 WIB',
    location: 'Klinik Pawcation Vet Care (Kemang)',
    personLabel: 'drh. Amanda Saraswati, M.Si',
    noteLabel: 'Jangan lupa bawa Buku Vaksin digital Mochi.',
    primaryActionLabel: 'Lihat Persiapan',
    secondaryActionLabel: 'Reschedule',
    dayOfMonth: 24,
  },
  {
    id: 'a3',
    timeBadge: 'Bulan Depan',
    petLabel: 'Dodo • Poodle',
    statusLabel: 'Pengingat Dibuat',
    status: 'reminder',
    title: 'Pemeriksaan Gigi & Scaling',
    dateTimeLabel: 'Jum, 03 Nov • 11:00 WIB',
    location: 'Pawcation Dental Center',
    personLabel: 'drh. Gilang Pratama',
    noteLabel: 'Puasa ringan 4 jam sebelum pemeriksaan.',
    primaryActionLabel: 'Detail Jadwal',
    secondaryActionLabel: 'Atur Ulang',
    dayOfMonth: 20,
  },
];

export const HOTEL_ROOMS = [
  {
    id: 'r1',
    name: 'Deluxe Cozy Suite',
    subtitle: 'Kamar nyaman ber-AC + kasur ortopedi & mainan',
    pricePerNight: 185000,
    facilities: ['AC 24 Jam', 'Live CCTV', '2x Walk/Hari'],
    badge: 'Terpopuler',
  },
  {
    id: 'r2',
    name: 'Royal VIP Sanctuary',
    subtitle: 'Suite privat luas dengan taman indoor & laporan video',
    pricePerNight: 295000,
    facilities: ['Private Yard', '24h Vet Watch', 'Daily Brush'],
    badge: 'Suite A-12',
  },
  {
    id: 'r3',
    name: 'Garden Play Villa',
    subtitle: 'Akses langsung ke area bermain rumput pet-safe',
    pricePerNight: 240000,
    facilities: ['Play Park', 'Snack Sore', 'Live CCTV'],
    badge: 'Ramah Sosial',
  },
];

export const VETS = [
  {
    id: 'v1',
    name: 'drh. Amanda Saraswati, M.Si',
    specialty: 'Dokter Hewan Umum & Vaksinasi',
    rating: 4.9,
    fee: 75000,
  },
  {
    id: 'v2',
    name: 'drh. Gilang Pratama',
    specialty: 'Dermatologi & Nutrisi Anabul',
    rating: 4.8,
    fee: 75000,
  },
];

export interface ChatMsg {
  id: string;
  text: string;
  time: string;
  isUser: boolean;
  recommendedProduct?: string;
}

export const INITIAL_MESSAGES: ChatMsg[] = [
  {
    id: 'm1',
    text: 'Halo Kak Sele! Ada keluhan apa dengan Dodo hari ini?',
    time: '14:10',
    isUser: false,
  },
  {
    id: 'm2',
    text: 'Halo Dok, Dodo agak kurang nafsu makan sejak pagi dan lebih sering tidur.',
    time: '14:12',
    isUser: true,
  },
  {
    id: 'm3',
    text: 'Baik Kak, suhu Dodo di Suite A-12 terpantau normal 38.4°C. Untuk bantu nafsu makan & pencernaannya, Dokter sarankan snack dental & probiotik berikut ya:',
    time: '14:14',
    isUser: false,
    recommendedProduct: 'PawDental Fresh Chews',
  },
];
