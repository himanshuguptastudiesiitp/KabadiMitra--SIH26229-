import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/types.dart';
import 'mock_data.dart';

class AppStore extends ChangeNotifier {
  Lang language = Lang.hi;
  UserRole role = UserRole.collector;
  String displayName = "Ramesh";
  bool onboardingDone = false;
  bool voiceOn = false;
  bool isDark = false;
  String? pendingPhoto;
  final List<Lot> lots = [];

  Lot? get activeLot {
    if (lots.isEmpty) return null;
    try {
      return lots.firstWhere(
        (l) =>
            l.paymentStatus != PaymentStatus.paid &&
            l.status != LotStatus.paid,
      );
    } catch (_) {
      return lots.isNotEmpty ? lots.first : null;
    }
  }

  void setLanguage(Lang lang) {
    language = lang;
    notifyListeners();
  }

  void setVoiceOn(bool value) {
    voiceOn = value;
    notifyListeners();
  }

  void setDark(bool value) {
    isDark = value;
    notifyListeners();
  }

  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }

  void setRole(UserRole value) {
    role = value;
    notifyListeners();
  }

  void setDisplayName(String name) {
    displayName = name.trim().isEmpty ? displayName : name.trim();
    notifyListeners();
  }

  void completeOnboarding() {
    onboardingDone = true;
    notifyListeners();
  }

  void setPendingPhoto(String? path) {
    pendingPhoto = path;
    notifyListeners();
  }

  void seedDemo() {
    if (lots.isNotEmpty) {
      notifyListeners();
      return;
    }
    displayName = "Ramesh";
    role = UserRole.collector;
    final now = DateTime.now();
    lots.addAll([
      Lot(
        id: "LOT-1001",
        category: MaterialId.copper,
        weightKg: 5.0,
        estimatedValue: 2250,
        ratePerKg: 450,
        status: LotStatus.valued,
        locationLabel: "Indore",
        collectorName: displayName,
        collectorArea: "Indore",
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      Lot(
        id: "LOT-1002",
        category: MaterialId.pcb,
        weightKg: 2.5,
        estimatedValue: 800,
        ratePerKg: 320,
        status: LotStatus.offered,
        locationLabel: "Indore",
        collectorName: displayName,
        collectorArea: "Indore",
        recyclerId: recyclers.isNotEmpty ? recyclers.first.id : null,
        quotedPrice: 850,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      Lot(
        id: "LOT-1003",
        category: MaterialId.aluminium,
        weightKg: 8.0,
        estimatedValue: 1200,
        ratePerKg: 150,
        status: LotStatus.paid,
        locationLabel: "Indore",
        collectorName: displayName,
        collectorArea: "Indore",
        paymentStatus: PaymentStatus.paid,
        paymentMethod: PayMethod.upi,
        finalPrice: 1200,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
    ]);
    notifyListeners();
  }

  Lot addLot({
    required MaterialId category,
    required double weightKg,
    required double estimatedValue,
    required double ratePerKg,
  }) {
    final lot = Lot(
      id: "LOT-${const Uuid().v4().substring(0, 8).toUpperCase()}",
      category: category,
      weightKg: weightKg,
      photoDataUrl: pendingPhoto,
      estimatedValue: estimatedValue,
      ratePerKg: ratePerKg,
      status: LotStatus.valued,
      locationLabel: "Indore",
      collectorName: displayName,
      collectorArea: "Indore",
      createdAt: DateTime.now(),
    );
    lots.insert(0, lot);
    pendingPhoto = null;
    notifyListeners();
    return lot;
  }

  void offerLot(String lotId, String recyclerId, double price) {
    final i = lots.indexWhere((l) => l.id == lotId);
    if (i < 0) return;
    lots[i] = lots[i].copyWith(
      recyclerId: recyclerId,
      quotedPrice: price,
      status: LotStatus.offered,
    );
    notifyListeners();
  }

  void acceptOffer(String lotId) {
    final i = lots.indexWhere((l) => l.id == lotId);
    if (i < 0) return;
    lots[i] = lots[i].copyWith(status: LotStatus.accepted);
    notifyListeners();
  }

  void handoverLot(String lotId, PayMethod method) {
    final i = lots.indexWhere((l) => l.id == lotId);
    if (i < 0) return;
    final lot = lots[i];
    lots[i] = lot.copyWith(
      status: LotStatus.paid,
      paymentMethod: method,
      paymentStatus: PaymentStatus.paid,
      finalPrice: lot.amount,
      handoverRef: "HO-${DateTime.now().millisecondsSinceEpoch % 100000}",
    );
    notifyListeners();
  }

  double todayEarned() {
    final now = DateTime.now();
    return lots
        .where((l) =>
            l.paymentStatus == PaymentStatus.paid &&
            l.createdAt.year == now.year &&
            l.createdAt.month == now.month &&
            l.createdAt.day == now.day)
        .fold(0.0, (sum, l) => sum + l.amount);
  }
}
