import {useRef, useState} from 'react';
import {
  INITIAL_AGENDAS,
  INITIAL_CART,
  INITIAL_MESSAGES,
  type ChatMsg,
} from './data/pawcationData';
import {
  LoginScreen,
  PaymentStatusScreen,
  RegisterScreen,
  ScheduleScreen,
} from './screens/AuthAndScheduleScreens';
import {
  AccountScreen,
  CartScreen,
  ConsultChatScreen,
  HomeScreen,
  LiveCamScreen,
  MarketplaceScreen,
  PetHotelScreen,
  PetMedicalScreen,
  PetTaxiScreen,
  VetConsultScreen,
} from './screens/ServiceScreens';
import {
  calculateCartTotals,
  calculatePawPointsEarned,
  updateCartEntry,
  type AgendaItem,
  type CartEntry,
  type ProductItem,
  type RouteKey,
} from './utils/pawcationLogic';

function getInitialRoute(): RouteKey {
  if (typeof window !== 'undefined') {
    const params = new URLSearchParams(window.location.search);
    if (params.get('autostart') === '1') return 'home';
  }
  return 'login';
}

export default function App() {
  const [route, setRoute] = useState<RouteKey>(getInitialRoute);
  const [ownerName, setOwnerName] = useState('Sele Clarissa');
  const [ownerEmail] = useState('sele.clarissa@pawparent.com');
  const [selectedPetType, setSelectedPetType] = useState('Anjing');
  const [cart, setCart] = useState<CartEntry[]>(INITIAL_CART);
  const [agendas, setAgendas] = useState<AgendaItem[]>(INITIAL_AGENDAS);
  const [selectedDay, setSelectedDay] = useState(21);
  const [messages, setMessages] = useState<ChatMsg[]>(INITIAL_MESSAGES);
  const [pawPoints, setPawPoints] = useState(320);
  const [lastPaidAmount, setLastPaidAmount] = useState(430000);
  const [lastTransactionItems, setLastTransactionItems] = useState(
    'Royal Canin Mini Adult (1x), PawDental Fresh Chews (2x)',
  );
  const [toast, setToast] = useState<string | null>(null);

  const showToast = (msg: string) => {
    setToast(msg);
    setTimeout(() => {
      setToast((curr) => (curr === msg ? null : curr));
    }, 2400);
  };

  const scrollContainerRef = useRef<HTMLDivElement>(null);

  const navigate = (next: RouteKey) => {
    setRoute(next);
    scrollContainerRef.current?.scrollTo({top: 0, behavior: 'smooth'});
  };

  const handleAddToCart = (product: ProductItem) => {
    setCart((prev) => updateCartEntry(prev, product, 1));
    showToast(`${product.name} ditambahkan ke keranjang`);
  };

  const handleUpdateQty = (product: ProductItem, delta: number) => {
    setCart((prev) => updateCartEntry(prev, product, delta));
  };

  const handleToggleSelect = (id: string) => {
    setCart((prev) =>
      prev.map((e) =>
        e.product.id === id ? {...e, selected: !e.selected} : e,
      ),
    );
  };

  const handleCheckout = (total: number, summaryText: string) => {
    setLastPaidAmount(total);
    setLastTransactionItems(summaryText);
    setPawPoints((p) => p + calculatePawPointsEarned(total));
    navigate('payment-status');
  };

  const handleSendMessage = (text: string) => {
    setMessages((prev) => [
      ...prev,
      {
        id: `m${prev.length + 1}`,
        text,
        time: '14:16',
        isUser: true,
      },
    ]);
  };

  const {itemCount} = calculateCartTotals(cart, false);

  const quickTabs: Array<{key: RouteKey; label: string}> = [
    {key: 'login', label: 'Login'},
    {key: 'register', label: 'Register'},
    {key: 'home', label: 'Home'},
    {key: 'schedule', label: 'Jadwal'},
    {key: 'cart', label: 'Cart'},
    {key: 'payment-status', label: 'Status Bayar'},
  ];

  return (
    <div className="min-h-screen bg-[#E9F1F8] sm:py-5 sm:px-4 flex flex-col items-center">
      {/* Compact desktop-only flow bar outside mobile screen */}
      <div className="mb-3 hidden sm:flex flex-wrap items-center justify-center gap-1.5 rounded-full border border-[#D8E5F1] bg-white/90 px-3 py-1.5 shadow-sm">
        {quickTabs.map((t) => (
          <button
            key={t.key}
            type="button"
            onClick={() => navigate(t.key)}
            className={`rounded-full px-3 py-1 text-[11.5px] font-bold transition-colors cursor-pointer ${
              route === t.key
                ? 'bg-[#0FA5E9] text-white'
                : 'text-[#64748B] hover:bg-[#F3F5F8]'
            }`}
          >
            {t.label}
          </button>
        ))}
      </div>

      {/* Mobile Viewport Frame */}
      <main className="relative w-full max-w-[395px] h-dvh sm:h-[820px] sm:rounded-[34px] sm:border-[6px] sm:border-[#1E293B] bg-[#F4F8FC] sm:shadow-2xl overflow-hidden flex flex-col">
        <div
          ref={scrollContainerRef}
          className="flex-1 min-h-0 flex flex-col overflow-y-auto"
        >
          {route === 'login' && (
            <LoginScreen onNavigate={navigate} onShowToast={showToast} />
          )}
          {route === 'register' && (
            <RegisterScreen
              onNavigate={navigate}
              ownerName={ownerName}
              setOwnerName={setOwnerName}
              selectedPetType={selectedPetType}
              setSelectedPetType={setSelectedPetType}
            />
          )}
          {route === 'home' && (
            <HomeScreen
              ownerName={ownerName}
              pawPoints={pawPoints}
              cartCount={itemCount}
              onAddToCart={handleAddToCart}
              onNavigate={navigate}
            />
          )}
          {route === 'marketplace' && (
            <MarketplaceScreen
              cartCount={itemCount}
              onAddToCart={handleAddToCart}
              onNavigate={navigate}
            />
          )}
          {route === 'cart' && (
            <CartScreen
              cart={cart}
              pawPoints={pawPoints}
              onUpdateQty={handleUpdateQty}
              onToggleSelect={handleToggleSelect}
              onCheckout={handleCheckout}
              onNavigate={navigate}
            />
          )}
          {route === 'payment-status' && (
            <PaymentStatusScreen
              totalPaid={lastPaidAmount}
              transactionItems={lastTransactionItems}
              paymentMethod="BCA Virtual Account"
              onNavigate={navigate}
              onShowToast={showToast}
            />
          )}
          {route === 'schedule' && (
            <ScheduleScreen
              agendas={agendas}
              onAddAgenda={(a) => setAgendas((prev) => [a, ...prev])}
              selectedDay={selectedDay}
              setSelectedDay={setSelectedDay}
              onNavigate={navigate}
              onShowToast={showToast}
            />
          )}
          {route === 'pet-hotel' && (
            <PetHotelScreen onCheckout={handleCheckout} onNavigate={navigate} />
          )}
          {route === 'vet-consult' && (
            <VetConsultScreen
              onCheckout={handleCheckout}
              onNavigate={navigate}
            />
          )}
          {route === 'consult-chat' && (
            <ConsultChatScreen
              messages={messages}
              onSendMessage={handleSendMessage}
              onNavigate={navigate}
              onShowToast={showToast}
            />
          )}
          {route === 'live' && <LiveCamScreen onNavigate={navigate} />}
          {route === 'pet-taxi' && (
            <PetTaxiScreen onCheckout={handleCheckout} onNavigate={navigate} />
          )}
          {route === 'account' && (
            <AccountScreen
              ownerName={ownerName}
              ownerEmail={ownerEmail}
              pawPoints={pawPoints}
              onNavigate={navigate}
            />
          )}
          {route === 'medical' && <PetMedicalScreen onNavigate={navigate} />}
        </div>

        {toast && (
          <div
            role="status"
            className="pointer-events-none fixed bottom-20 left-1/2 z-50 -translate-x-1/2 rounded-full bg-[#1E293B] px-4 py-2 text-[12px] font-bold text-white shadow-lg"
          >
            {toast}
          </div>
        )}
      </main>
    </div>
  );
}
