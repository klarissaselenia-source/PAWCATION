import React, {useState} from 'react';
import {
  ArrowRight,
  BadgeCheck,
  Bell,
  Building2,
  Calendar,
  Check,
  CheckCircle2,
  ChevronLeft,
  ChevronRight,
  Clock,
  Copy,
  Eye,
  EyeOff,
  FileText,
  Fingerprint,
  Hash,
  Home,
  Info,
  Lock,
  Mail,
  Navigation,
  PawPrint,
  Phone,
  PlusCircle,
  QrCode,
  Receipt,
  RefreshCw,
  Shield,
  ShieldCheck,
  Sparkles,
  Store,
  Truck,
  User,
  Video,
  X,
} from 'lucide-react';
import {
  NotificationBellButton,
  PawcationHeader,
  ProfileCircleButton,
} from '../components/MobilePrimitives';
import {
  calculatePawPointsEarned,
  formatRupiah,
  type AgendaItem,
  type RouteKey,
} from '../utils/pawcationLogic';

function AppleIcon() {
  return (
    <svg
      aria-hidden="true"
      viewBox="0 0 24 24"
      className="h-[18px] w-[18px] fill-[#1E293B]"
    >
      <path d="M16.365 1.43c0 1.14-.493 2.27-1.177 3.08-.744.9-1.99 1.57-2.987 1.57-.12 0-.23-.02-.3-.03-.01-.06-.04-.22-.04-.39 0-1.15.572-2.27 1.206-2.98.804-.94 2.142-1.64 3.248-1.68.03.13.05.28.05.43zm4.565 15.71c-.03.07-.463 1.58-1.518 3.12-.945 1.34-1.94 2.71-3.43 2.71-1.517 0-1.9-.88-3.63-.88-1.698 0-2.302.91-3.67.91-1.377 0-2.332-1.26-3.428-2.8-1.287-1.82-2.323-4.63-2.323-7.28 0-4.28 2.797-6.55 5.552-6.55 1.448 0 2.675.95 3.6.95.865 0 2.222-1.01 3.902-1.01.613 0 2.886.06 4.374 2.19-.13.09-2.383 1.37-2.383 4.19 0 3.26 2.854 4.42 2.955 4.45z" />
    </svg>
  );
}

export function LoginScreen({
  onNavigate,
  onShowToast,
}: {
  onNavigate: (r: RouteKey) => void;
  onShowToast: (msg: string) => void;
}) {
  const [email, setEmail] = useState('sele.clarissa@pawparent.com');
  const [password, setPassword] = useState('pawcationsecret2025');
  const [showPass, setShowPass] = useState(false);
  const [remember, setRemember] = useState(true);

  return (
    <div className="min-h-full bg-[#F4F8FC]">
      <PawcationHeader showBack onBack={() => onNavigate('home')} />
      <div className="px-5 pt-5 pb-8 flex flex-col items-center">
        {/* Poodle avatar with soft blue halo & paw badge */}
        <div className="relative">
          <div className="h-[106px] w-[106px] rounded-full bg-[#0FA5E9]/15 p-1.5">
            <img
              src="/assets/images/dodo_avatar.png"
              alt="Dodo the Poodle"
              className="h-full w-full rounded-full object-cover"
            />
          </div>
          <div className="absolute bottom-0.5 right-0.5 flex h-8 w-8 items-center justify-center rounded-full border-2 border-white bg-[#0FA5E9] text-white">
            <PawPrint className="h-4 w-4 fill-white" />
          </div>
        </div>

        <div className="mt-3.5 inline-flex items-center gap-1.5 rounded-full bg-[#E6F4FD] px-3 py-1 text-[11.5px] font-bold text-[#0284C7]">
          <BadgeCheck className="h-3.5 w-3.5" />
          <span>Pawcation Sanctuary ID</span>
        </div>

        <h1 className="mt-3 text-center text-[25px] font-black tracking-tight text-[#1E293B]">
          Selamat Datang! 🐾
        </h1>
        <p className="mt-1.5 max-w-[290px] text-center text-[13.5px] leading-relaxed text-[#64748B]">
          Masuk untuk memantau, merawat, dan manjakan anabul kesayanganmu.
        </p>

        {/* Social Auth Buttons */}
        <div className="mt-5 w-full space-y-3">
          <button
            type="button"
            onClick={() => onNavigate('home')}
            className="flex h-12 w-full items-center justify-center gap-2.5 rounded-full border border-[#E6EEF5] bg-white text-[14px] font-bold text-[#1E293B] shadow-sm hover:bg-slate-50 cursor-pointer"
          >
            <span className="text-[17px] font-black text-[#4285F4]">G</span>
            <span>Masuk dengan Google</span>
          </button>
          <button
            type="button"
            onClick={() => onNavigate('home')}
            className="flex h-12 w-full items-center justify-center gap-2.5 rounded-full border border-[#E6EEF5] bg-white text-[14px] font-bold text-[#1E293B] shadow-sm hover:bg-slate-50 cursor-pointer"
          >
            <AppleIcon />
            <span>Masuk dengan Apple</span>
          </button>
        </div>

        <div className="my-5 flex w-full items-center gap-3">
          <div className="h-px flex-1 bg-[#E2E8F0]" />
          <span className="text-[12px] font-medium text-[#64748B]">
            atau masuk dengan email
          </span>
          <div className="h-px flex-1 bg-[#E2E8F0]" />
        </div>

        {/* Email Field */}
        <div className="w-full space-y-4">
          <div>
            <div className="mb-1.5 flex items-center justify-between">
              <label
                htmlFor="login-email"
                className="text-[13px] font-bold text-[#1E293B]"
              >
                Email / Nomor Handphone
              </label>
              <span className="inline-flex items-center gap-1 text-[12px] font-bold text-[#0D9488]">
                <ShieldCheck className="h-3.5 w-3.5" />
                Aktif
              </span>
            </div>
            <div className="flex h-12 items-center gap-2.5 rounded-full bg-[#F3F5F8] px-4">
              <Mail className="h-4 w-4 shrink-0 text-[#64748B]" />
              <input
                id="login-email"
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="nama@email.com"
                className="w-full bg-transparent text-[14px] font-medium text-[#1E293B] outline-none"
              />
              {email && (
                <button
                  type="button"
                  aria-label="Hapus email"
                  onClick={() => setEmail('')}
                  className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-[#E2E8F0] text-[#64748B] cursor-pointer"
                >
                  <X className="h-3 w-3" />
                </button>
              )}
            </div>
          </div>

          <div>
            <label
              htmlFor="login-password"
              className="mb-1.5 block text-[13px] font-bold text-[#1E293B]"
            >
              Kata Sandi
            </label>
            <div className="flex h-12 items-center gap-2.5 rounded-full bg-[#F3F5F8] px-4">
              <Lock className="h-4 w-4 shrink-0 text-[#64748B]" />
              <input
                id="login-password"
                type={showPass ? 'text' : 'password'}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="Masukkan kata sandi"
                className="w-full bg-transparent text-[14px] font-medium text-[#1E293B] outline-none"
              />
              <button
                type="button"
                aria-label="Tampilkan sandi"
                onClick={() => setShowPass((v) => !v)}
                className="text-[#64748B] cursor-pointer"
              >
                {showPass ? (
                  <EyeOff className="h-4 w-4" />
                ) : (
                  <Eye className="h-4 w-4" />
                )}
              </button>
            </div>
          </div>

          <div className="flex items-center justify-between pt-0.5">
            <label className="flex items-center gap-2 text-[13px] font-semibold text-[#1E293B] cursor-pointer">
              <input
                type="checkbox"
                checked={remember}
                onChange={(e) => setRemember(e.target.checked)}
                className="h-4 w-4 rounded accent-[#0FA5E9]"
              />
              <span>Ingat Saya</span>
            </label>
            <button
              type="button"
              onClick={() =>
                onShowToast('Tautan reset kata sandi dikirim ke email.')
              }
              className="text-[13px] font-bold text-[#0FA5E9] cursor-pointer"
            >
              Lupa Kata Sandi?
            </button>
          </div>
        </div>

        {/* CTAs */}
        <div className="mt-5 w-full space-y-3">
          <button
            type="button"
            onClick={() => onNavigate('home')}
            className="flex h-[50px] w-full items-center justify-center gap-2 rounded-full bg-[#0FA5E9] text-[15px] font-bold text-white shadow-sm hover:bg-[#0284C7] cursor-pointer"
          >
            <span>Masuk Sekarang</span>
            <ArrowRight className="h-4 w-4" />
          </button>

          <button
            type="button"
            onClick={() => onNavigate('home')}
            className="flex h-[46px] w-full items-center justify-center gap-2 rounded-full bg-[#E5F2FA] text-[13.5px] font-bold text-[#0284C7] hover:bg-[#D9ECFA] cursor-pointer"
          >
            <Fingerprint className="h-4 w-4" />
            <span>Atau gunakan Face ID / Biometrik</span>
          </button>
        </div>

        {/* Dodo Boarding Quick Preview Card -> Live Cam */}
        <button
          type="button"
          onClick={() => onNavigate('live')}
          className="mt-5 flex w-full items-center gap-3 rounded-[22px] border border-[#E6EEF5] bg-white p-3.5 text-left shadow-sm hover:border-[#BAE6FD] cursor-pointer"
        >
          <div className="relative shrink-0">
            <img
              src="/assets/images/dodo_avatar.png"
              alt="Dodo"
              className="h-12 w-12 rounded-full object-cover"
            />
            <span className="absolute bottom-0 right-0 h-3 w-3 rounded-full border-2 border-white bg-[#10B981]" />
          </div>
          <div className="min-w-0 flex-1">
            <div className="flex items-center gap-2">
              <span className="text-[15px] font-extrabold text-[#1E293B]">
                Dodo
              </span>
              <span className="rounded-full bg-[#E6F7F4] px-2.5 py-0.5 text-[11px] font-bold text-[#0D9488]">
                Sedang Boarding
              </span>
            </div>
            <p className="mt-0.5 text-[12px] leading-snug text-[#64748B]">
              Suite Room A-12 • Aktivitas jam 14:00 terjadwal
            </p>
          </div>
          <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-[#E6F4FD] text-[#0FA5E9]">
            <Video className="h-4 w-4" />
          </div>
        </button>

        <p className="mt-5 text-[13.5px] text-[#64748B]">
          Belum punya akun Pawcation?{' '}
          <button
            type="button"
            onClick={() => onNavigate('register')}
            className="font-extrabold text-[#0FA5E9] cursor-pointer"
          >
            Daftar Sekarang
          </button>
        </p>

        <div className="mt-3.5 flex items-center gap-1.5 text-[11.5px] font-semibold text-[#64748B]">
          <ShieldCheck className="h-3.5 w-3.5 text-[#0D9488]" />
          <span>Data &amp; privasi anabul terenkripsi 256-bit 🔒</span>
        </div>
      </div>
    </div>
  );
}

export function RegisterScreen({
  onNavigate,
  ownerName,
  setOwnerName,
  selectedPetType,
  setSelectedPetType,
}: {
  onNavigate: (r: RouteKey) => void;
  ownerName: string;
  setOwnerName: (n: string) => void;
  selectedPetType: string;
  setSelectedPetType: (t: string) => void;
}) {
  const [nameInput, setNameInput] = useState(
    ownerName === 'Sele Clarissa' ? '' : ownerName,
  );
  const [emailInput, setEmailInput] = useState('');
  const [phoneInput, setPhoneInput] = useState('');
  const [agree, setAgree] = useState(false);

  const submit = () => {
    if (nameInput.trim()) setOwnerName(nameInput.trim());
    onNavigate('home');
  };

  return (
    <div className="min-h-full bg-[#F4F8FC]">
      <PawcationHeader showBack onBack={() => onNavigate('login')} />
      <div className="space-y-4 px-4 pt-4 pb-8">
        {/* Welcome Promo Card */}
        <div className="rounded-[24px] border border-[#E6EEF5] bg-gradient-to-br from-[#EEF3FA] to-[#E0F0FC] p-5">
          <div className="inline-flex items-center gap-1.5 rounded-full bg-white px-3 py-1 text-[11px] font-extrabold text-[#0284C7]">
            <span>★</span>
            <span>PROMO SELAMAT DATANG</span>
          </div>
          <h1 className="mt-3 text-[25px] font-black leading-[1.15] tracking-tight text-[#1E293B]">
            Mulai Bersama
            <br />
            PAWCATION 🐶🐱
          </h1>
          <p className="mt-2 text-[13.5px] leading-relaxed text-[#64748B]">
            Daftar akun gratis dan nikmati diskon{' '}
            <span className="font-extrabold text-[#0284C7]">20%</span> untuk
            perawatan &amp; penitipan pertama anabulmu!
          </p>
          <div className="mt-3.5 flex items-center gap-2.5">
            <img
              src="/assets/images/register_pets_cluster.png"
              alt="12.8k+ anabul terdaftar"
              className="h-9 rounded-full object-contain"
            />
            <span className="text-[12.5px] font-semibold text-[#64748B]">
              12.8k+ anabul terdaftar
            </span>
          </div>
        </div>

        {/* Stepper Card */}
        <div className="rounded-[22px] border border-[#E6EEF5] bg-white p-4 shadow-sm">
          <div className="flex items-center gap-2.5">
            <span className="flex h-6 w-6 items-center justify-center rounded-full bg-[#0FA5E9] text-[12px] font-extrabold text-white">
              1
            </span>
            <span className="flex-1 text-[14px] font-extrabold text-[#1E293B]">
              Data Pemilik &amp; Akun
            </span>
            <span className="text-[12.5px] font-bold text-[#64748B]">
              50% Selesai
            </span>
          </div>
          <div className="mt-2.5 h-1.5 w-full overflow-hidden rounded-full bg-[#E6F4FD]">
            <div className="h-full w-1/2 rounded-full bg-[#0FA5E9]" />
          </div>
          <div className="mt-2.5 flex items-center justify-between text-[11.5px] font-bold">
            <span className="text-[#64748B]">Langkah 1 dari 2</span>
            <button
              type="button"
              onClick={submit}
              className="text-[#0FA5E9] cursor-pointer"
            >
              Berikutnya: Profil Anabul →
            </button>
          </div>
        </div>

        {/* Form Card */}
        <div className="space-y-4 rounded-[22px] border border-[#E6EEF5] bg-white p-4 shadow-sm">
          <div>
            <label className="mb-1.5 block text-[13px] font-bold text-[#1E293B]">
              Nama Lengkap Pemilik <span className="text-[#0FA5E9]">*</span>
            </label>
            <div className="flex h-12 items-center gap-2.5 rounded-full bg-[#F3F5F8] px-4">
              <User className="h-4 w-4 text-[#64748B]" />
              <input
                value={nameInput}
                onChange={(e) => setNameInput(e.target.value)}
                placeholder="contoh: Sarah Kartika"
                className="w-full bg-transparent text-[13.5px] outline-none"
              />
            </div>
          </div>

          <div>
            <label className="mb-1.5 block text-[13px] font-bold text-[#1E293B]">
              Alamat Email Aktif <span className="text-[#0FA5E9]">*</span>
            </label>
            <div className="flex h-12 items-center gap-2.5 rounded-full bg-[#F3F5F8] px-4">
              <Mail className="h-4 w-4 text-[#64748B]" />
              <input
                type="email"
                value={emailInput}
                onChange={(e) => setEmailInput(e.target.value)}
                placeholder="sarah@example.com"
                className="w-full bg-transparent text-[13.5px] outline-none"
              />
            </div>
          </div>

          <div>
            <label className="mb-1.5 block text-[13px] font-bold text-[#1E293B]">
              Nomor WhatsApp / HP <span className="text-[#0FA5E9]">*</span>
            </label>
            <div className="flex gap-2.5">
              <div className="flex h-12 items-center gap-1.5 rounded-full bg-[#F3F5F8] px-3.5 text-[13.5px] font-bold">
                <span>🇮🇩</span>
                <span>+62</span>
              </div>
              <div className="flex h-12 flex-1 items-center gap-2 rounded-full bg-[#F3F5F8] px-4">
                <Phone className="h-4 w-4 text-[#64748B]" />
                <input
                  value={phoneInput}
                  onChange={(e) => setPhoneInput(e.target.value)}
                  placeholder="812-3456-7890"
                  className="w-full bg-transparent text-[13.5px] outline-none"
                />
              </div>
            </div>
            <p className="mt-1.5 flex items-center gap-1.5 text-[11.5px] font-semibold text-[#0D9488]">
              <ShieldCheck className="h-3.5 w-3.5" />
              Untuk notifikasi darurat &amp; rekam medis anabul
            </p>
          </div>

          <div>
            <label className="mb-1.5 block text-[13px] font-bold text-[#1E293B]">
              Kata Sandi <span className="text-[#0FA5E9]">*</span>
            </label>
            <div className="flex h-12 items-center gap-2.5 rounded-full bg-[#F3F5F8] px-4">
              <Lock className="h-4 w-4 text-[#64748B]" />
              <input
                type="password"
                placeholder="Minimal 8 karakter & 1 angka"
                className="w-full bg-transparent text-[13.5px] outline-none"
              />
            </div>
          </div>

          <div>
            <label className="mb-1.5 block text-[13px] font-bold text-[#1E293B]">
              Konfirmasi Kata Sandi <span className="text-[#0FA5E9]">*</span>
            </label>
            <div className="flex h-12 items-center gap-2.5 rounded-full bg-[#F3F5F8] px-4">
              <CheckCircle2 className="h-4 w-4 text-[#64748B]" />
              <input
                type="password"
                placeholder="Ketik ulang kata sandi"
                className="w-full bg-transparent text-[13.5px] outline-none"
              />
            </div>
          </div>

          <div>
            <div className="flex items-center gap-1.5 text-[13.5px] font-extrabold text-[#1E293B]">
              <PawPrint className="h-4 w-4 text-[#0FA5E9]" />
              <span>Peliharaan Utama Kamu:</span>
            </div>
            <div className="mt-2.5 flex flex-wrap gap-2">
              {[
                {key: 'Anjing', label: '🐶 Anjing'},
                {key: 'Kucing', label: '🐱 Kucing'},
                {key: 'Keduanya', label: '🐰 Keduanya'},
              ].map((opt) => {
                const active = selectedPetType === opt.key;
                return (
                  <button
                    key={opt.key}
                    type="button"
                    onClick={() => setSelectedPetType(opt.key)}
                    className={`rounded-full border px-4 py-1.5 text-[13px] font-bold cursor-pointer ${
                      active
                        ? 'border-[#0FA5E9] bg-[#E6F4FD] text-[#0284C7]'
                        : 'border-transparent bg-[#F3F5F8] text-[#64748B]'
                    }`}
                  >
                    {opt.label}
                  </button>
                );
              })}
            </div>
            <p className="mt-2 text-[11.5px] text-[#64748B]">
              Bisa ditambahkan &amp; disesuaikan kembali nanti di profil.
            </p>
          </div>

          <label className="flex items-start gap-2.5 text-[12.5px] text-[#64748B] cursor-pointer">
            <input
              type="checkbox"
              checked={agree}
              onChange={(e) => setAgree(e.target.checked)}
              className="mt-0.5 h-4 w-4 rounded accent-[#0FA5E9]"
            />
            <span>
              Saya menyetujui{' '}
              <strong className="text-[#0284C7]">Syarat &amp; Ketentuan</strong>{' '}
              serta{' '}
              <strong className="text-[#0284C7]">Kebijakan Privasi</strong>{' '}
              Pawcation Care.
            </span>
          </label>

          <button
            type="button"
            onClick={submit}
            className="flex h-[50px] w-full items-center justify-center gap-2 rounded-full bg-[#0FA5E9] text-[15px] font-bold text-white shadow-sm hover:bg-[#0284C7] cursor-pointer"
          >
            <span>Lanjut &amp; Buat Profil Anabul</span>
            <PawPrint className="h-4 w-4 fill-white" />
          </button>
        </div>

        <div className="flex items-center gap-3 pt-1">
          <div className="h-px flex-1 bg-[#E2E8F0]" />
          <span className="text-[11px] font-bold tracking-wider text-[#64748B]">
            ATAU DAFTAR CEPAT DENGAN
          </span>
          <div className="h-px flex-1 bg-[#E2E8F0]" />
        </div>

        <div className="grid grid-cols-2 gap-3">
          <button
            type="button"
            onClick={submit}
            className="flex h-12 items-center justify-center gap-2 rounded-full border border-[#E6EEF5] bg-white text-[14px] font-bold shadow-sm cursor-pointer"
          >
            <span className="text-[16px] font-black text-[#4285F4]">G</span>
            <span>Google</span>
          </button>
          <button
            type="button"
            onClick={submit}
            className="flex h-12 items-center justify-center gap-2 rounded-full border border-[#E6EEF5] bg-white text-[14px] font-bold shadow-sm cursor-pointer"
          >
            <AppleIcon />
            <span>Apple</span>
          </button>
        </div>

        <div className="flex justify-center">
          <span className="inline-flex items-center gap-1.5 rounded-full bg-white px-3.5 py-1.5 text-[11.5px] font-semibold text-[#64748B] shadow-sm">
            <CheckCircle2 className="h-3.5 w-3.5 text-[#0D9488]" />
            Bebas biaya langganan • Batal kapan saja
          </span>
        </div>

        <p className="text-center text-[13.5px] text-[#64748B]">
          Sudah punya akun?{' '}
          <button
            type="button"
            onClick={() => onNavigate('login')}
            className="font-extrabold text-[#0FA5E9] cursor-pointer"
          >
            Masuk di sini
          </button>
        </p>
      </div>
    </div>
  );
}

export function ScheduleScreen({
  agendas,
  onAddAgenda,
  selectedDay,
  setSelectedDay,
  onNavigate,
  onShowToast,
}: {
  agendas: AgendaItem[];
  onAddAgenda: (item: AgendaItem) => void;
  selectedDay: number;
  setSelectedDay: (d: number) => void;
  onNavigate: (r: RouteKey) => void;
  onShowToast: (msg: string) => void;
}) {
  const [showAddModal, setShowAddModal] = useState(false);
  const [newTitle, setNewTitle] = useState('');

  const days = [
    {name: 'Kam', num: 19, dot: ''},
    {name: 'Jum', num: 20, dot: '#0D9488'},
    {name: 'Sab', num: 21, dot: '#FFFFFF'},
    {name: 'Min', num: 22, dot: ''},
    {name: 'Sen', num: 23, dot: ''},
    {name: 'Sel', num: 24, dot: '#0FA5E9'},
    {name: 'Rab', num: 25, dot: ''},
  ];

  return (
    <div className="min-h-full bg-[#F4F8FC]">
      <PawcationHeader
        showBack
        onBack={() => onNavigate('home')}
        trailing={
          <NotificationBellButton
            onClick={() => onShowToast('Semua pengingat jadwal aktif!')}
          />
        }
      />
      <div className="space-y-4 px-4 pt-4 pb-8">
        {/* Title Row */}
        <div className="flex items-start justify-between gap-3">
          <div>
            <h1 className="text-[21px] font-black tracking-tight text-[#1E293B]">
              Jadwal &amp; Agenda Anabul 📆
            </h1>
            <p className="mt-1 text-[13px] leading-snug text-[#64748B]">
              Pengingat vaksin, grooming rutin, dan janji temu dokter.
            </p>
          </div>
          <button
            type="button"
            aria-label="Segarkan jadwal"
            onClick={() => onShowToast('Jadwal disinkronkan')}
            className="flex h-10 w-10 shrink-0 items-center justify-center rounded-2xl bg-[#E6F4FD] text-[#0FA5E9] cursor-pointer"
          >
            <RefreshCw className="h-4 w-4" />
          </button>
        </div>

        {/* Summary Pills */}
        <div className="flex flex-wrap gap-2">
          <span className="inline-flex items-center gap-1.5 rounded-full border border-[#E6EEF5] bg-white px-3 py-1 text-[11.5px] font-bold text-[#1E293B]">
            <span className="h-2 w-2 rounded-full bg-[#0FA5E9]" />
            {agendas.length} Jadwal Bulan Ini
          </span>
          <span className="inline-flex items-center gap-1.5 rounded-full border border-[#E6EEF5] bg-white px-3 py-1 text-[11.5px] font-bold text-[#1E293B]">
            <span className="h-2 w-2 rounded-full bg-[#F59E0B]" />1 Menunggu
          </span>
          <span className="inline-flex items-center gap-1.5 rounded-full border border-[#E6EEF5] bg-white px-3 py-1 text-[11.5px] font-bold text-[#1E293B]">
            <span className="h-2 w-2 rounded-full bg-[#0D9488]" />1 Selesai
          </span>
        </div>

        {/* Calendar Strip Card */}
        <div className="rounded-[22px] border border-[#E6EEF5] bg-white p-4 shadow-sm">
          <div className="flex items-center gap-2">
            <span className="text-[16px] font-extrabold text-[#1E293B]">
              Oktober 2024
            </span>
            <span className="rounded-full bg-[#E6F4FD] px-2.5 py-0.5 text-[11px] font-bold text-[#0284C7]">
              Bulan Ini
            </span>
            <div className="ml-auto flex items-center gap-1.5">
              <button
                type="button"
                aria-label="Sebelumnya"
                onClick={() => setSelectedDay(20)}
                className="flex h-7 w-7 items-center justify-center rounded-full bg-[#F3F5F8] text-[#64748B] cursor-pointer"
              >
                <ChevronLeft className="h-4 w-4" />
              </button>
              <button
                type="button"
                onClick={() => setSelectedDay(21)}
                className="rounded-full bg-[#E6F4FD] px-2.5 py-1 text-[11.5px] font-bold text-[#0284C7] cursor-pointer"
              >
                Hari Ini
              </button>
              <button
                type="button"
                aria-label="Berikutnya"
                onClick={() => setSelectedDay(24)}
                className="flex h-7 w-7 items-center justify-center rounded-full bg-[#F3F5F8] text-[#64748B] cursor-pointer"
              >
                <ChevronRight className="h-4 w-4" />
              </button>
            </div>
          </div>

          <div className="mt-3.5 grid grid-cols-7 gap-1">
            {days.map((d) => {
              const selected = selectedDay === d.num;
              return (
                <button
                  key={d.num}
                  type="button"
                  onClick={() => setSelectedDay(d.num)}
                  className={`flex flex-col items-center rounded-xl py-2 transition-colors cursor-pointer ${
                    selected
                      ? 'bg-[#0FA5E9] text-white'
                      : 'bg-[#F3F5F8]/70 text-[#1E293B]'
                  }`}
                >
                  <span
                    className={`text-[11px] font-semibold ${
                      selected ? 'text-white' : 'text-[#64748B]'
                    }`}
                  >
                    {d.name}
                  </span>
                  <span className="mt-1 text-[14px] font-extrabold">
                    {d.num}
                  </span>
                  <span
                    className="mt-1 h-1.5 w-1.5 rounded-full"
                    style={{
                      backgroundColor: selected
                        ? '#FFFFFF'
                        : d.dot || 'transparent',
                    }}
                  />
                </button>
              );
            })}
          </div>

          <div className="mt-3 flex items-center justify-between rounded-xl bg-[#F0F7FC] px-3 py-2.5 text-[12.5px] font-bold">
            <div className="flex items-center gap-2 text-[#1E293B]">
              <Calendar className="h-4 w-4 text-[#0FA5E9]" />
              <span>
                {selectedDay === 24
                  ? 'Selasa, 24 Okt • Vaksinasi Tahunan'
                  : `Sabtu, ${selectedDay} Okt • 1 Sesi Grooming`}
              </span>
            </div>
            <span className="text-[11.5px] text-[#0284C7]">Hari Ini</span>
          </div>
        </div>

        {/* Agenda Terjadwal Header */}
        <div className="flex items-center justify-between pt-1">
          <div className="flex items-center gap-2">
            <h2 className="text-[16px] font-extrabold text-[#1E293B]">
              Agenda Terjadwal
            </h2>
            <span className="flex h-6 w-6 items-center justify-center rounded-full bg-[#E6F4FD] text-[12px] font-extrabold text-[#0284C7]">
              {agendas.length}
            </span>
          </div>
          <span className="text-[12.5px] font-bold text-[#0FA5E9]">
            Lihat Kalender Penuh
          </span>
        </div>

        {/* Agenda Cards */}
        <div className="space-y-3">
          {agendas.map((agenda) => {
            const isConfirmed = agenda.status === 'confirmed';
            return (
              <div
                key={agenda.id}
                className="rounded-[22px] border border-[#E6EEF5] bg-white p-4 shadow-sm"
              >
                <div className="flex items-start gap-3">
                  <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-[#E6F4FD] text-[#0FA5E9]">
                    {isConfirmed ? (
                      <Sparkles className="h-5 w-5" />
                    ) : (
                      <Shield className="h-5 w-5" />
                    )}
                  </div>
                  <div className="min-w-0 flex-1">
                    <div className="flex flex-wrap items-center gap-1.5">
                      <span className="rounded-full bg-[#E6F4FD] px-2.5 py-0.5 text-[11px] font-bold text-[#0284C7]">
                        {agenda.timeBadge}
                      </span>
                      <span className="text-[12px] font-bold text-[#1E293B]">
                        {agenda.petLabel}
                      </span>
                      <span
                        className={`ml-auto rounded-full px-2.5 py-0.5 text-[11px] font-bold ${
                          isConfirmed
                            ? 'bg-[#E6F4FD] text-[#0284C7]'
                            : 'bg-[#F3F5F8] text-[#64748B]'
                        }`}
                      >
                        {agenda.statusLabel}
                      </span>
                    </div>
                    <h3 className="mt-1.5 text-[14.5px] font-extrabold leading-snug text-[#1E293B]">
                      {agenda.title}
                    </h3>
                    <p
                      className={`text-[12.5px] font-bold ${
                        isConfirmed ? 'text-[#0284C7]' : 'text-[#64748B]'
                      }`}
                    >
                      {agenda.dateTimeLabel}
                    </p>
                  </div>
                </div>

                <div className="mt-3 space-y-1.5 rounded-2xl bg-[#F0F7FC] p-3 text-[12px] text-[#64748B]">
                  <p className="flex items-center gap-2">
                    <Store className="h-3.5 w-3.5 shrink-0" />
                    <span>{agenda.location}</span>
                  </p>
                  <p className="flex items-center gap-2">
                    <User className="h-3.5 w-3.5 shrink-0" />
                    <span>{agenda.personLabel}</span>
                  </p>
                  <p
                    className={`flex items-center gap-2 ${
                      isConfirmed ? 'font-bold text-[#0284C7]' : ''
                    }`}
                  >
                    <Info className="h-3.5 w-3.5 shrink-0" />
                    <span>{agenda.noteLabel}</span>
                  </p>
                </div>

                <div className="mt-3 grid grid-cols-2 gap-2.5">
                  <button
                    type="button"
                    onClick={() =>
                      onShowToast(`${agenda.secondaryActionLabel} diaktifkan`)
                    }
                    className="flex h-10 items-center justify-center gap-1.5 rounded-full border border-[#E6EEF5] text-[12.5px] font-bold text-[#1E293B] cursor-pointer"
                  >
                    <Bell className="h-3.5 w-3.5" />
                    <span>{agenda.secondaryActionLabel}</span>
                  </button>
                  <button
                    type="button"
                    onClick={() =>
                      onNavigate(isConfirmed ? 'pet-taxi' : 'medical')
                    }
                    className={`flex h-10 items-center justify-center gap-1.5 rounded-full text-[12.5px] font-bold cursor-pointer ${
                      isConfirmed
                        ? 'bg-[#0FA5E9] text-white'
                        : 'border border-[#0FA5E9] bg-white text-[#0284C7]'
                    }`}
                  >
                    <Navigation className="h-3.5 w-3.5" />
                    <span>{agenda.primaryActionLabel}</span>
                  </button>
                </div>
              </div>
            );
          })}
        </div>

        {/* Rekam Medis & E-Card */}
        <div className="flex items-center justify-between pt-2">
          <h2 className="text-[16px] font-extrabold text-[#1E293B]">
            Rekam Medis &amp; E-Card
          </h2>
          <button
            type="button"
            onClick={() => onNavigate('medical')}
            className="text-[12.5px] font-bold text-[#0FA5E9] cursor-pointer"
          >
            Riwayat Lengkap
          </button>
        </div>

        <div className="rounded-[22px] border border-[#E6EEF5] bg-[#F0F7FC] p-4 shadow-sm">
          <div className="flex items-center gap-3">
            <div className="flex h-10 w-10 items-center justify-center rounded-full bg-[#0FA5E9] text-white">
              <Shield className="h-5 w-5" />
            </div>
            <div className="flex-1">
              <p className="text-[14.5px] font-extrabold text-[#1E293B]">
                Buku Vaksin Digital Dodo
              </p>
              <p className="text-[12px] text-[#64748B]">
                ID Anabul: #PC-MC-2022-8819
              </p>
            </div>
            <QrCode className="h-7 w-7 text-[#0284C7]" />
          </div>

          <div className="mt-3.5 grid grid-cols-2 gap-2.5">
            <div className="rounded-2xl bg-white p-3">
              <p className="text-[11.5px] text-[#64748B]">Vaksin Terakhir:</p>
              <p className="mt-1 text-[13.5px] font-extrabold text-[#1E293B]">
                Agustus 2025 (Rabies)
              </p>
              <p className="mt-1 text-[11.5px] font-bold text-[#0D9488]">
                Lengkap &amp; Sah
              </p>
            </div>
            <div className="rounded-2xl bg-white p-3">
              <p className="text-[11.5px] text-[#64748B]">Booster Mendatang:</p>
              <p className="mt-1 text-[13.5px] font-extrabold text-[#0284C7]">
                24 Des 2026
              </p>
              <p className="mt-1 text-[11.5px] font-semibold text-[#0FA5E9]">
                DHPPi Booster #2
              </p>
            </div>
          </div>

          <button
            type="button"
            onClick={() => onNavigate('medical')}
            className="mt-3 flex h-10 w-full items-center justify-center gap-2 rounded-full border border-[#E6EEF5] bg-white text-[13px] font-bold text-[#0284C7] cursor-pointer"
          >
            <FileText className="h-4 w-4" />
            <span>Buka E-Card &amp; Paspor Vaksin</span>
          </button>
        </div>

        <button
          type="button"
          onClick={() => setShowAddModal(true)}
          className="flex h-[50px] w-full items-center justify-center gap-2 rounded-full bg-[#0FA5E9] text-[14.5px] font-bold text-white shadow-sm hover:bg-[#0284C7] cursor-pointer"
        >
          <PlusCircle className="h-4 w-4" />
          <span>+ Tambah Jadwal Baru (Jadwalkan Layanan)</span>
        </button>
      </div>

      {showAddModal && (
        <div className="fixed inset-0 z-50 flex items-end justify-center bg-black/40 p-3">
          <div className="w-full max-w-[390px] rounded-3xl bg-white p-5 shadow-xl">
            <h3 className="text-[17px] font-extrabold text-[#1E293B]">
              Tambah Jadwal Baru
            </h3>
            <input
              value={newTitle}
              onChange={(e) => setNewTitle(e.target.value)}
              placeholder="Contoh: Vitamin Bulanan / Nail Trim"
              className="mt-3 h-11 w-full rounded-2xl bg-[#F3F5F8] px-4 text-[13.5px] outline-none"
            />
            <div className="mt-4 flex gap-2">
              <button
                type="button"
                onClick={() => setShowAddModal(false)}
                className="h-11 flex-1 rounded-full bg-[#F3F5F8] text-[13.5px] font-bold text-[#64748B] cursor-pointer"
              >
                Batal
              </button>
              <button
                type="button"
                onClick={() => {
                  onAddAgenda({
                    id: `a${agendas.length + 1}`,
                    timeBadge: 'Baru',
                    petLabel: 'Dodo • Poodle',
                    statusLabel: 'Terjadwal',
                    status: 'scheduled',
                    title: newTitle.trim() || 'Perawatan Spa & Nail Trim',
                    dateTimeLabel: 'Min, 22 Okt • 09:30 WIB',
                    location: 'Pawcation Salon & Care',
                    personLabel: 'Tim Perawat Pawcation',
                    noteLabel: 'Pengingat otomatis aktif.',
                    primaryActionLabel: 'Detail Jadwal',
                    secondaryActionLabel: 'Ingatkan',
                    dayOfMonth: 22,
                  });
                  setNewTitle('');
                  setShowAddModal(false);
                }}
                className="h-11 flex-1 rounded-full bg-[#0FA5E9] text-[13.5px] font-bold text-white cursor-pointer"
              >
                Simpan
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export function PaymentStatusScreen({
  totalPaid,
  transactionItems,
  paymentMethod,
  onNavigate,
  onShowToast,
}: {
  totalPaid: number;
  transactionItems: string;
  paymentMethod: string;
  onNavigate: (r: RouteKey) => void;
  onShowToast: (msg: string) => void;
}) {
  const earnedPoints = calculatePawPointsEarned(totalPaid);

  return (
    <div className="min-h-full bg-[#F4F8FC]">
      <PawcationHeader
        showBack
        onBack={() => onNavigate('home')}
        trailing={<ProfileCircleButton onClick={() => onNavigate('account')} />}
      />
      <div className="space-y-4 px-4 pt-3.5 pb-8">
        {/* Sub-header */}
        <div className="flex items-center gap-2.5">
          <div className="flex h-8 w-8 items-center justify-center rounded-xl bg-[#E6F4FD] text-[#0284C7]">
            <Receipt className="h-4 w-4" />
          </div>
          <h1 className="flex-1 text-[16.5px] font-extrabold text-[#1E293B]">
            Status Pembayaran
          </h1>
          <button
            type="button"
            aria-label="Tutup"
            onClick={() => onNavigate('home')}
            className="flex h-8 w-8 items-center justify-center rounded-full bg-[#F3F5F8] text-[#64748B] cursor-pointer"
          >
            <X className="h-4 w-4" />
          </button>
        </div>

        {/* Hero Success Card */}
        <div className="flex flex-col items-center rounded-[26px] border border-[#E6EEF5] bg-white px-4 pt-5 pb-6 shadow-sm">
          <span className="inline-flex items-center gap-1.5 rounded-full bg-[#E6F7F4] px-3.5 py-1 text-[12px] font-extrabold text-[#0D9488]">
            <Check className="h-3.5 w-3.5" />
            Pembayaran Berhasil!
          </span>

          <div className="relative mt-4">
            <img
              src="/assets/images/payment_success_hero.png"
              alt="Hore! Pesanan Diproses"
              className="h-[220px] w-[235px] rounded-[22px] object-cover"
            />
            <div className="absolute bottom-2.5 left-1/2 -translate-x-1/2 whitespace-nowrap rounded-full bg-white px-3.5 py-1.5 text-[12px] font-extrabold text-[#0B4F6C] shadow-md">
              🎉 Hore! Pesanan Diproses
            </div>
          </div>

          <p className="mt-4 text-[13px] font-medium text-[#64748B]">
            Total Terbayar
          </p>
          <p className="mt-0.5 text-[32px] font-black tracking-tight text-[#0B4F6C]">
            {formatRupiah(totalPaid)}
          </p>

          <div className="mt-3 inline-flex items-center gap-2 rounded-full bg-[#F0F7FC] px-4 py-2 text-[12.5px] font-semibold text-[#1E293B]">
            <span className="flex h-5 w-5 items-center justify-center rounded-full bg-[#0FA5E9] text-[10px] font-bold text-white">
              ★
            </span>
            <span>
              <strong className="text-[#0B4F6C]">
                +{earnedPoints} PawPoints
              </strong>{' '}
              berhasil ditambahkan!
            </span>
          </div>
        </div>

        {/* Rincian Transaksi Card */}
        <div className="rounded-[24px] border border-[#E6EEF5] bg-white p-4 shadow-sm">
          <div className="flex items-center justify-between gap-2">
            <h2 className="text-[15.5px] font-extrabold text-[#1E293B]">
              Rincian Transaksi
            </h2>
            <span className="rounded-full bg-[#E6F4FD] px-2.5 py-1 text-[11px] font-bold text-[#0B4F6C]">
              Terverifikasi Otomatis
            </span>
          </div>

          <div className="mt-4 space-y-3 text-[13px]">
            <div className="flex items-center gap-2">
              <Hash className="h-4 w-4 text-[#64748B]" />
              <span className="flex-1 text-[#64748B]">ID Transaksi</span>
              <span className="font-extrabold text-[#1E293B]">
                #PAW-202505-8910
              </span>
              <button
                type="button"
                aria-label="Salin ID Transaksi"
                onClick={() => onShowToast('ID Transaksi #PAW-202505-8910 disalin')}
                className="text-[#0FA5E9] cursor-pointer"
              >
                <Copy className="h-4 w-4" />
              </button>
            </div>

            <div className="flex items-center gap-2">
              <Building2 className="h-4 w-4 text-[#64748B]" />
              <span className="flex-1 text-[#64748B]">Metode Pembayaran</span>
              <span className="font-bold text-[#1E293B]">{paymentMethod}</span>
            </div>

            <div className="flex items-center gap-2">
              <Clock className="h-4 w-4 text-[#64748B]" />
              <span className="flex-1 text-[#64748B]">Waktu Transaksi</span>
              <span className="font-bold text-[#1E293B]">
                Hari ini, 14:32 WIB
              </span>
            </div>
          </div>

          <div className="mt-3.5 rounded-2xl bg-[#F0F7FC] p-3.5">
            <p className="flex items-center gap-1.5 text-[13px] font-bold text-[#1E293B]">
              <PawPrint className="h-3.5 w-3.5 text-[#0FA5E9]" />
              <span>Untuk Anabul:</span>
              <span className="text-[#0284C7]">Dodo 🐶</span>
            </p>
            <p className="mt-1 text-[12.5px] leading-relaxed text-[#64748B]">
              {transactionItems}
            </p>
          </div>
        </div>

        {/* Actions */}
        <div className="space-y-2.5 pt-1">
          <button
            type="button"
            onClick={() => onNavigate('home')}
            className="flex h-[50px] w-full items-center justify-center gap-2 rounded-full bg-[#0FA5E9] text-[15px] font-bold text-white shadow-sm hover:bg-[#0284C7] cursor-pointer"
          >
            <Home className="h-4 w-4" />
            <span>Kembali ke Beranda</span>
          </button>

          <button
            type="button"
            onClick={() =>
              onShowToast('Pesanan sedang dikemas di Pawcation Hub Kemang')
            }
            className="flex h-[46px] w-full items-center justify-center gap-2 rounded-full bg-[#E5F2FA] text-[14px] font-bold text-[#0B4F6C] cursor-pointer"
          >
            <Truck className="h-4 w-4" />
            <span>Lacak Status Pesanan</span>
          </button>
        </div>

        <div className="pt-1 text-center">
          <button
            type="button"
            onClick={() =>
              onShowToast('Invoice #PAW-202505-8910 siap diunduh')
            }
            className="inline-flex items-center gap-1.5 text-[13px] font-bold text-[#1E293B] underline cursor-pointer"
          >
            <FileText className="h-3.5 w-3.5 text-[#64748B]" />
            <span>Lihat Invoice / Bukti Pembayaran</span>
          </button>
          <p className="mt-2 text-[12px] text-[#64748B]">
            🐾 Terima kasih telah mempercayakan kebutuhan anabulmu!
          </p>
        </div>
      </div>
    </div>
  );
}
