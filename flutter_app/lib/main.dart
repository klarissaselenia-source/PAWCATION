import 'package:flutter/material.dart';
import 'screens/account_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/consult_chat_screen.dart';
import 'screens/home_screen.dart';
import 'screens/live_cam_screen.dart';
import 'screens/login_screen.dart';
import 'screens/marketplace_screen.dart';
import 'screens/payment_status_screen.dart';
import 'screens/pet_hotel_screen.dart';
import 'screens/pet_medical_screen.dart';
import 'screens/pet_taxi_screen.dart';
import 'screens/register_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/vet_consult_screen.dart';
import 'state/app_state.dart';
import 'theme/pawcation_theme.dart';

void main() {
  runApp(const PawcationApp());
}

class PawcationApp extends StatefulWidget {
  const PawcationApp({super.key});

  @override
  State<PawcationApp> createState() => _PawcationAppState();
}

class _PawcationAppState extends State<PawcationApp> {
  final PawcationAppState _appState = PawcationAppState();

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      notifier: _appState,
      child: MaterialApp(
        title: 'Pawcation',
        debugShowCheckedModeBanner: false,
        theme: PawcationTheme.lightTheme,
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          '/home': (_) => const HomeScreen(),
          '/marketplace': (_) => const MarketplaceScreen(),
          '/cart': (_) => const CartScreen(),
          '/payment-status': (_) => const PaymentStatusScreen(),
          '/schedule': (_) => const ScheduleScreen(),
          '/pet-hotel': (_) => const PetHotelScreen(),
          '/vet-consult': (_) => const VetConsultScreen(),
          '/consult-chat': (_) => const ConsultChatScreen(),
          '/live': (_) => const LiveCamScreen(),
          '/pet-taxi': (_) => const PetTaxiScreen(),
          '/account': (_) => const AccountScreen(),
          '/medical': (_) => const PetMedicalScreen(),
        },
      ),
    );
  }
}
