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
