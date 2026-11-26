import React from 'react';
import {
  Bell,
  Calendar,
  ChevronLeft,
  Home,
  PawPrint,
  Stethoscope,
  Store,
  User,
} from 'lucide-react';
import type {RouteKey} from '../utils/pawcationLogic';

export function PawcationHeader({
  showBack = true,
  onBack,
  trailing,
}: {
  showBack?: boolean;
  onBack?: () => void;
  trailing?: React.ReactNode;
}) {
  return (
    <header className="sticky top-0 z-20 flex h-14 items-center justify-between border-b border-[#E6EEF5] bg-white px-3.5">
      <div className="w-10">
        {showBack && (
          <button
            type="button"
            onClick={onBack}
            aria-label="Kembali"
            className="flex h-9 w-9 items-center justify-center rounded-full text-[#1E293B] hover:bg-[#F3F5F8] cursor-pointer"
          >
            <ChevronLeft className="h-6 w-6" />
          </button>
        )}
      </div>
      <div className="flex items-center gap-1.5">
        <PawPrint className="h-5 w-5 fill-[#0FA5E9] text-[#0FA5E9]" />
        <span className="text-[17px] font-extrabold tracking-tight text-[#1E293B]">
          Pawcation
        </span>
      </div>
      <div className="flex w-10 justify-end">{trailing}</div>
    </header>
  );
}

export function NotificationBellButton({onClick}: {onClick: () => void}) {
  return (
    <button
      type="button"
      onClick={onClick}
      aria-label="Notifikasi Jadwal"
      className="relative flex h-9 w-9 items-center justify-center rounded-full text-[#1E293B] hover:bg-[#F3F5F8] cursor-pointer"
    >
      <Bell className="h-5 w-5" />
      <span className="absolute right-2 top-2 h-2 w-2 rounded-full bg-[#EF4444]" />
    </button>
  );
}

export function ProfileCircleButton({onClick}: {onClick: () => void}) {
  return (
    <button
      type="button"
      onClick={onClick}
      aria-label="Profil Akun"
      className="flex h-8 w-8 items-center justify-center rounded-full bg-[#0B4F6C] text-white cursor-pointer"
    >
      <User className="h-4 w-4" />
    </button>
  );
}

export function PawcationBottomNav({
  activeRoute,
  onNavigate,
}: {
  activeRoute: RouteKey;
  onNavigate: (r: RouteKey) => void;
}) {
  const items: Array<{key: RouteKey; label: string; icon: React.ReactNode}> = [
    {key: 'home', label: 'Beranda', icon: <Home className="h-5 w-5" />},
    {key: 'marketplace', label: 'Belanja', icon: <Store className="h-5 w-5" />},
    {key: 'schedule', label: 'Jadwal', icon: <Calendar className="h-5 w-5" />},
    {
      key: 'vet-consult',
      label: 'Dokter',
      icon: <Stethoscope className="h-5 w-5" />,
    },
    {key: 'account', label: 'Akun', icon: <User className="h-5 w-5" />},
  ];

  return (
    <nav
      aria-label="Navigasi utama"
      className="sticky bottom-0 mt-auto shrink-0 z-20 grid grid-cols-5 border-t border-[#E6EEF5] bg-white px-2 py-1.5"
    >
      {items.map((item) => {
        const active = activeRoute === item.key;
        return (
          <button
            key={item.key}
            type="button"
            onClick={() => onNavigate(item.key)}
            className="flex flex-col items-center gap-0.5 py-1 cursor-pointer"
          >
            <span
              className={`rounded-full px-3 py-1 transition-colors ${
                active
                  ? 'bg-[#E6F4FD] text-[#0FA5E9]'
                  : 'text-[#94A3B8] hover:text-[#64748B]'
              }`}
            >
              {item.icon}
            </span>
            <span
              className={`text-[11px] ${
                active
                  ? 'font-bold text-[#0284C7]'
                  : 'font-medium text-[#94A3B8]'
              }`}
            >
              {item.label}
            </span>
          </button>
        );
      })}
    </nav>
  );
}
