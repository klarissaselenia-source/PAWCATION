import test from 'node:test';
import assert from 'node:assert/strict';
import {
  calculateCartTotals,
  calculatePawPointsEarned,
  filterProducts,
  formatRupiah,
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
