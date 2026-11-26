class PetProfile {
  final String id;
  final String name;
  final String breed;
  final String species;
  final String age;
  final String weight;
  final String status;
  final String roomInfo;
  final String avatarAsset;

  const PetProfile({
    required this.id,
    required this.name,
    required this.breed,
    required this.species,
    required this.age,
    required this.weight,
    required this.status,
    required this.roomInfo,
    required this.avatarAsset,
  });
}

class ProductItem {
  final String id;
  final String name;
  final String category;
  final int price;
  final String weightLabel;
  final double rating;
  final String badge;
  final String emoji;

  const ProductItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.weightLabel,
    required this.rating,
    required this.badge,
    required this.emoji,
  });
}

class CartEntry {
  final ProductItem product;
  int quantity;
  bool selected;

  CartEntry({
    required this.product,
    this.quantity = 1,
    this.selected = true,
  });
}

enum AgendaStatus { confirmed, scheduled, reminder }

class AgendaItem {
  final String id;
  final String timeBadge;
  final String petLabel;
  final String statusLabel;
  final AgendaStatus status;
  final String title;
  final String dateTimeLabel;
  final String location;
  final String personLabel;
  final String noteLabel;
  final String primaryActionLabel;
  final String secondaryActionLabel;
  final int dayOfMonth;

  const AgendaItem({
    required this.id,
    required this.timeBadge,
    required this.petLabel,
    required this.statusLabel,
    required this.status,
    required this.title,
    required this.dateTimeLabel,
    required this.location,
    required this.personLabel,
    required this.noteLabel,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    required this.dayOfMonth,
  });
}

class HotelRoom {
  final String id;
  final String name;
  final String subtitle;
  final int pricePerNight;
  final List<String> facilities;
  final String badge;

  const HotelRoom({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.pricePerNight,
    required this.facilities,
    required this.badge,
  });
}

class VetDoctor {
  final String id;
  final String name;
  final String specialty;
  final String experience;
  final double rating;
  final bool isOnline;
  final int fee;

  const VetDoctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.experience,
    required this.rating,
    required this.isOnline,
    required this.fee,
  });
}

class ChatMessage {
  final String id;
  final String sender;
  final String text;
  final String time;
  final bool isUser;
  final String? recommendedProduct;

  const ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.time,
    required this.isUser,
    this.recommendedProduct,
  });
}
