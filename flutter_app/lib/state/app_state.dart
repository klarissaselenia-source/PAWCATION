import 'package:flutter/foundation.dart';
import '../data/dummy_data.dart';
import '../models/pawcation_models.dart';

class PawcationAppState extends ChangeNotifier {
  final List<CartEntry> _cart = [
    CartEntry(product: DummyData.products[0], quantity: 1),
    CartEntry(product: DummyData.products[1], quantity: 2),
  ];

  final List<AgendaItem> _agendas = List.of(DummyData.initialAgendas);
  final List<ChatMessage> _messages = List.of(DummyData.initialMessages);

  String ownerName = 'Sele Clarissa';
  String ownerEmail = 'sele.clarissa@pawparent.com';
  String selectedPetType = 'Anjing';
  int selectedCalendarDay = 21;
  int pawPoints = 320;
  int lastPaidAmount = 430000;
  String lastTransactionItems =
      'Royal Canin Mini Adult (1x), PawDental Fresh Chews (2x)';
  String lastPaymentMethod = 'BCA Virtual Account';
  bool reminderNotificationsEnabled = true;

  List<CartEntry> get cart => List.unmodifiable(_cart);
  List<AgendaItem> get agendas => List.unmodifiable(_agendas);
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  int get cartCount => _cart.fold(0, (sum, e) => sum + e.quantity);

  int get cartSubtotal => _cart
      .where((e) => e.selected)
      .fold(0, (sum, e) => sum + (e.product.price * e.quantity));

  void addToCart(ProductItem product) {
    final index = _cart.indexWhere((e) => e.product.id == product.id);
    if (index >= 0) {
      _cart[index].quantity++;
    } else {
      _cart.add(CartEntry(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void updateQuantity(String productId, int delta) {
    final index = _cart.indexWhere((e) => e.product.id == productId);
    if (index < 0) return;
    _cart[index].quantity += delta;
    if (_cart[index].quantity <= 0) {
      _cart.removeAt(index);
    }
    notifyListeners();
  }

  void toggleCartSelection(String productId) {
    final index = _cart.indexWhere((e) => e.product.id == productId);
    if (index < 0) return;
    _cart[index].selected = !_cart[index].selected;
    notifyListeners();
  }

  void selectCalendarDay(int day) {
    selectedCalendarDay = day;
    notifyListeners();
  }

  void addAgenda(AgendaItem item) {
    _agendas.insert(0, item);
    notifyListeners();
  }

  void sendChatMessage(String text) {
    if (text.trim().isEmpty) return;
    _messages.add(
      ChatMessage(
        id: 'm${_messages.length + 1}',
        sender: ownerName,
        text: text.trim(),
        time: '14:16',
        isUser: true,
      ),
    );
    notifyListeners();
  }

  void completePayment({
    required int totalAmount,
    required String summaryText,
    String method = 'BCA Virtual Account',
  }) {
    lastPaidAmount = totalAmount;
    lastTransactionItems = summaryText;
    lastPaymentMethod = method;
    pawPoints += (totalAmount ~/ 10000);
    notifyListeners();
  }

  void setPetType(String type) {
    selectedPetType = type;
    notifyListeners();
  }

  void toggleReminderNotifications(bool value) {
    reminderNotificationsEnabled = value;
    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<PawcationAppState> {
  const AppStateScope({
    super.key,
    required PawcationAppState super.notifier,
    required super.child,
  });

  static PawcationAppState of(context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in widget tree');
    return scope!.notifier!;
  }
}
