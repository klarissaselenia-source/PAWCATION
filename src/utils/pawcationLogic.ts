export type RouteKey =
  | 'login'
  | 'register'
  | 'home'
  | 'marketplace'
  | 'cart'
  | 'payment-status'
  | 'schedule'
  | 'pet-hotel'
  | 'vet-consult'
  | 'consult-chat'
  | 'live'
  | 'pet-taxi'
  | 'account'
  | 'medical';

export interface ProductItem {
  id: string;
  name: string;
  category: 'Makanan' | 'Vitamin' | 'Grooming' | 'Aksesoris';
  price: number;
  weightLabel: string;
  rating: number;
  badge: string;
  emoji: string;
}

export interface CartEntry {
  product: ProductItem;
  quantity: number;
  selected: boolean;
}

export interface AgendaItem {
  id: string;
  timeBadge: string;
  petLabel: string;
  statusLabel: string;
  status: 'confirmed' | 'scheduled' | 'reminder';
  title: string;
  dateTimeLabel: string;
  location: string;
  personLabel: string;
  noteLabel: string;
  primaryActionLabel: string;
  secondaryActionLabel: string;
  dayOfMonth: number;
}

export function formatRupiah(amount: number): string {
  const safe = Math.max(0, Math.round(amount));
  const formatted = safe.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.');
  return `Rp ${formatted}`;
}

export function calculateCartTotals(
  entries: CartEntry[],
  usePawPoints: boolean,
): {
  itemCount: number;
  subtotal: number;
  shipping: number;
  discount: number;
  total: number;
} {
  const itemCount = entries.reduce((sum, e) => sum + e.quantity, 0);
  const subtotal = entries
    .filter((e) => e.selected)
    .reduce((sum, e) => sum + e.product.price * e.quantity, 0);
  const shipping = subtotal > 0 ? 15000 : 0;
  const discount = usePawPoints && subtotal > 0 ? 15000 : 0;
  const total = Math.max(0, subtotal + shipping - discount);
  return {itemCount, subtotal, shipping, discount, total};
}

export function calculatePawPointsEarned(amount: number): number {
  if (amount <= 0) return 0;
  return Math.floor(amount / 10000);
}

export function filterProducts(
  products: ProductItem[],
  category: string,
  query: string,
): ProductItem[] {
  const q = query.trim().toLowerCase();
  return products.filter((p) => {
    const catOk = category === 'Semua' || p.category === category;
    const queryOk = !q || p.name.toLowerCase().includes(q);
    return catOk && queryOk;
  });
}

export function updateCartEntry(
  entries: CartEntry[],
  product: ProductItem,
  delta: number,
): CartEntry[] {
  const existing = entries.find((e) => e.product.id === product.id);
  if (!existing && delta > 0) {
    return [...entries, {product, quantity: delta, selected: true}];
  }
  return entries
    .map((e) =>
      e.product.id === product.id
        ? {...e, quantity: e.quantity + delta}
        : e,
    )
    .filter((e) => e.quantity > 0);
}

export const ID_MONTHS = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
] as const;

const ID_DAYS_SHORT = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'] as const;
const ID_DAYS_FULL = [
  'Minggu',
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
] as const;

export interface CalendarDayCell {
  name: string;
  num: number;
  dot: string;
}

export function getDaysInMonth(year: number, monthIndex: number): number {
  return new Date(year, monthIndex + 1, 0).getDate();
}

export function getSevenDayWindow(
  year: number,
  monthIndex: number,
  selectedDay: number,
): CalendarDayCell[] {
  const maxDay = getDaysInMonth(year, monthIndex);
  const clamped = Math.min(Math.max(1, selectedDay), maxDay);
  let start = clamped - 2;
  if (start < 1) start = 1;
  if (start + 6 > maxDay) start = Math.max(1, maxDay - 6);

  const cells: CalendarDayCell[] = [];
  for (let d = start; d <= Math.min(maxDay, start + 6); d++) {
    const dt = new Date(year, monthIndex, d);
    const dot = d === 20 ? '#0D9488' : d === 24 ? '#0FA5E9' : d === 21 ? '#FFFFFF' : '';
    cells.push({
      name: ID_DAYS_SHORT[dt.getDay()],
      num: d,
      dot,
    });
  }
  return cells;
}

export function formatSelectedDateSummary(
  year: number,
  monthIndex: number,
  day: number,
): string {
  const maxDay = getDaysInMonth(year, monthIndex);
  const clamped = Math.min(Math.max(1, day), maxDay);
  const dt = new Date(year, monthIndex, clamped);
  const dayFull = ID_DAYS_FULL[dt.getDay()];
  const monthShort = ID_MONTHS[monthIndex].slice(0, 3);
  return `${dayFull}, ${clamped} ${monthShort} ${year}`;
}

export function shiftDateByDays(
  year: number,
  monthIndex: number,
  day: number,
  delta: number,
): {year: number; monthIndex: number; day: number} {
  const dt = new Date(year, monthIndex, day + delta);
  return {
    year: dt.getFullYear(),
    monthIndex: dt.getMonth(),
    day: dt.getDate(),
  };
}

export interface TaxiLocation {
  id: string;
  name: string;
  address: string;
  area: string;
  xPct: number;
  yPct: number;
}

export type TaxiFleetType = 'PawCar Standard' | 'PawVan AC + Crate';

export interface PetTaxiQuote {
  distanceKm: number;
  etaMinutes: number;
  baseFare: number;
  perKmRate: number;
  distanceFee: number;
  totalFare: number;
}

export const TAXI_LOCATIONS: TaxiLocation[] = [
  {
    id: 'rumah-sele',
    name: 'Rumah Sele',
    address: 'Rumah Sele • Jl. Kemang Raya No. 18',
    area: 'Kemang',
    xPct: 22,
    yPct: 68,
  },
  {
    id: 'salon-malang',
    name: 'Pawcation Salon & Spa',
    address: 'Pawcation Salon & Spa',
    area: 'Kemang',
    xPct: 72,
    yPct: 47,
  },
  {
    id: 'klinik-kemang',
    name: 'Klinik Vet Kemang',
    address: 'Klinik Pawcation Vet Care (Kemang)',
    area: 'Kemang Selatan',
    xPct: 40,
    yPct: 50,
  },
  {
    id: 'sanctuary-senopati',
    name: 'Sanctuary Senopati',
    address: 'Pawcation Sanctuary Suite (Senopati)',
    area: 'Senopati',
    xPct: 54,
    yPct: 24,
  },
  {
    id: 'taman-menteng',
    name: 'Taman Menteng',
    address: 'Taman Bermain Anabul Menteng',
    area: 'Menteng',
    xPct: 80,
    yPct: 74,
  },
  {
    id: 'hub-pondok-indah',
    name: 'Hub Pondok Indah',
    address: 'Pawcation Hub Pondok Indah',
    area: 'Pondok Indah',
    xPct: 18,
    yPct: 28,
  },
];

export function calculatePetTaxiQuote(
  pickup: {xPct: number; yPct: number},
  dropoff: {xPct: number; yPct: number},
  fleet: TaxiFleetType,
): PetTaxiQuote {
  const dxKm = ((dropoff.xPct - pickup.xPct) / 100) * 8.0;
  const dyKm = ((dropoff.yPct - pickup.yPct) / 100) * 6.0;
  const rawDist = Math.hypot(dxKm, dyKm);
  const distanceKm =
    rawDist < 0.05 ? 0 : Math.max(0.5, Math.round(rawDist * 10) / 10);
  const etaMinutes =
    distanceKm === 0 ? 0 : Math.max(4, Math.round(distanceKm * 1.9));
  const baseFare = fleet === 'PawCar Standard' ? 15000 : 35000;
  const perKmRate = fleet === 'PawCar Standard' ? 7000 : 9500;
  const distanceFee =
    distanceKm === 0 ? 0 : Math.ceil((distanceKm * perKmRate) / 1000) * 1000;
  const totalFare = baseFare + distanceFee;

  return {
    distanceKm,
    etaMinutes,
    baseFare,
    perKmRate,
    distanceFee,
    totalFare,
  };
}

export function createCustomPinLocation(
  kind: 'pickup' | 'dropoff',
  xPct: number,
  yPct: number,
  customLabel?: string,
): TaxiLocation {
  const clampedX = Math.min(92, Math.max(8, Math.round(xPct)));
  const clampedY = Math.min(88, Math.max(12, Math.round(yPct)));
  const xKm = ((clampedX / 100) * 8.0).toFixed(1);
  const yKm = ((clampedY / 100) * 6.0).toFixed(1);
  const defaultTitle =
    kind === 'pickup'
      ? `Titik Jemput Peta (${xKm}, ${yKm} km)`
      : `Titik Tujuan Peta (${xKm}, ${yKm} km)`;

  return {
    id: `custom-${kind}`,
    name: customLabel?.trim() || (kind === 'pickup' ? 'Pin Jemput' : 'Pin Tujuan'),
    address: customLabel?.trim() || defaultTitle,
    area: 'Pin Peta Custom',
    xPct: clampedX,
    yPct: clampedY,
  };
}
