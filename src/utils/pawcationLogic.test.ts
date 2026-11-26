import test from 'node:test';
import assert from 'node:assert/strict';
import {
  calculateCartTotals,
  calculatePawPointsEarned,
  calculatePetTaxiQuote,
  createCustomPinLocation,
  filterProducts,
  formatRupiah,
  formatSelectedDateSummary,
  getDaysInMonth,
  getSevenDayWindow,
  shiftDateByDays,
  TAXI_LOCATIONS,
  updateCartEntry,
  type CartEntry,
  type ProductItem,
} from './pawcationLogic';

const sampleProducts: ProductItem[] = [
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
];

test('formatRupiah formats Indonesian currency accurately', () => {
  assert.equal(formatRupiah(430000), 'Rp 430.000');
  assert.equal(formatRupiah(75000), 'Rp 75.000');
  assert.equal(formatRupiah(0), 'Rp 0');
});

test('calculateCartTotals computes exact Figma default Rp 430.000', () => {
  const cart: CartEntry[] = [
    {product: sampleProducts[0], quantity: 1, selected: true},
    {product: sampleProducts[1], quantity: 2, selected: true},
  ];
  const res = calculateCartTotals(cart, false);
  assert.equal(res.itemCount, 3);
  assert.equal(res.subtotal, 415000);
  assert.equal(res.shipping, 15000);
  assert.equal(res.total, 430000);
  assert.equal(calculatePawPointsEarned(res.total), 43);
});

test('calculateCartTotals applies PawPoints discount cleanly', () => {
  const cart: CartEntry[] = [
    {product: sampleProducts[0], quantity: 1, selected: true},
  ];
  const res = calculateCartTotals(cart, true);
  assert.equal(res.discount, 15000);
  assert.equal(res.total, 185000);
});

test('filterProducts filters by category and search query', () => {
  assert.equal(filterProducts(sampleProducts, 'Semua', '').length, 2);
  assert.equal(filterProducts(sampleProducts, 'Vitamin', '').length, 1);
  assert.equal(filterProducts(sampleProducts, 'Semua', 'royal').length, 1);
});

test('updateCartEntry adds, increments, and removes when quantity reaches zero', () => {
  let cart: CartEntry[] = [];
  cart = updateCartEntry(cart, sampleProducts[0], 1);
  assert.equal(cart.length, 1);
  assert.equal(cart[0].quantity, 1);

  cart = updateCartEntry(cart, sampleProducts[0], 1);
  assert.equal(cart[0].quantity, 2);

  cart = updateCartEntry(cart, sampleProducts[0], -2);
  assert.equal(cart.length, 0);
});

test('2026 calendar helpers compute days, window, and month transitions accurately', () => {
  assert.equal(getDaysInMonth(2026, 1), 28); // Feb 2026 non-leap year
  assert.equal(getDaysInMonth(2026, 9), 31); // Okt 2026
  const strip = getSevenDayWindow(2026, 9, 21);
  assert.equal(strip.length, 7);
  assert.equal(strip[0].num, 19);
  assert.equal(strip[2].num, 21);
  assert.equal(strip[2].name, 'Rab'); // Oct 21, 2026 is Wednesday (Rabu)
  assert.equal(formatSelectedDateSummary(2026, 9, 21), 'Rabu, 21 Okt 2026');
  const nextMonth = shiftDateByDays(2026, 9, 31, 1);
  assert.deepEqual(nextMonth, {year: 2026, monthIndex: 10, day: 1});
});

test('calculatePetTaxiQuote computes distance, ETA, and fare breakdown from map pins', () => {
  const pickup = TAXI_LOCATIONS[0]; // Rumah Sele
  const dropoff = TAXI_LOCATIONS[1]; // Pawcation Salon & Spa (Malang)

  const carQuote = calculatePetTaxiQuote(pickup, dropoff, 'PawCar Standard');
  assert.equal(carQuote.distanceKm, 4.2);
  assert.equal(carQuote.etaMinutes, 8);
  assert.equal(carQuote.baseFare, 15000);
  assert.equal(carQuote.distanceFee, 30000);
  assert.equal(carQuote.totalFare, 45000);

  const vanQuote = calculatePetTaxiQuote(pickup, dropoff, 'PawVan AC + Crate');
  assert.equal(vanQuote.totalFare, 75000);

  const customDest = createCustomPinLocation('dropoff', 80, 74, 'Taman Menteng');
  const longerQuote = calculatePetTaxiQuote(
    TAXI_LOCATIONS[5],
    customDest,
    'PawCar Standard',
  );
  assert.equal(longerQuote.distanceKm, 5.7);
  assert.equal(longerQuote.totalFare, 55000);

  const sameSpot = calculatePetTaxiQuote(pickup, pickup, 'PawCar Standard');
  assert.equal(sameSpot.distanceKm, 0);
  assert.equal(sameSpot.totalFare, 15000);
});

