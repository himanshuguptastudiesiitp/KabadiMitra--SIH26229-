import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/types.dart';
import 'mock_data.dart';

class AppStore extends ChangeNotifier {
  Lang language = Lang.hi;
  UserRole role = UserRole.collector;
  String displayName = "रमेश";
  bool onboardingDone = false;
  bool voiceOn = false;
  bool darkMode = false;
  List<Lot> lots = [];
  String? pendingPhoto;

  void setLanguage(Lang l) {
    language = l;
    notifyListeners();
  }

  void setRole(UserRole r) {
    role = r;
    notifyListeners();
  }

  void setDisplayName(String n) {
    displayName = n;
    notifyListeners();
  }

  void completeOnboarding() {
    onboardingDone = true;
    notifyListeners();
  }

  void setVoiceOn(bool v) {
    voiceOn = v;
    notifyListeners();
  }

  void setDarkMode(bool v) {
    darkMode = v;
    notifyListeners();
  }

  void toggleDarkMode() {
    darkMode = !darkMode;
    notifyListeners();
  }

  void setPendingPhoto(String? url) {
    pendingPhoto = url;
    notifyListeners();
  }

  Lot addLot({
    required MaterialId category,
    required double weightKg,
    String? photoDataUrl,
    required double estimatedValue,
    required double ratePerKg,
  }) {
    final lot = Lot(
      id: const Uuid().v4().substring(0, 8),
      category: category,
      weightKg: weightKg,
      photoDataUrl: photoDataUrl ?? pendingPhoto,
      estimatedValue: estimatedValue,
      ratePerKg: ratePerKg,
      quotedPrice: estimatedValue,
      status: LotStatus.valued,
      locationLabel: kSampleArea,
      collectorName: displayName,
      collectorArea: kSampleArea,
      createdAt: DateTime.now(),
    );
    lots = [lot, ...lots];
    pendingPhoto = null;
    notifyListeners();
    return lot;
  }

  void offerLot(String lotId, String recyclerId, double price) {
    lots = lots.map((l) {
      if (l.id != lotId) return l;
      return l.copyWith(
        recyclerId: recyclerId,
        quotedPrice: price,
        status: LotStatus.offered,
      );
    }).toList();
    notifyListeners();
  }

  void acceptOffer(String lotId) {
    lots = lots.map((l) {
      if (l.id != lotId) return l;
      return l.copyWith(status: LotStatus.accepted);
    }).toList();
    notifyListeners();
  }

  void handoverLot(String lotId, PayMethod method) {
    lots = lots.map((l) {
      if (l.id != lotId) return l;
      return l.copyWith(
        status: LotStatus.paid,
        paymentMethod: method,
        paymentStatus: PaymentStatus.paid,
        finalPrice: l.quotedPrice ?? l.estimatedValue,
        handoverRef: "HO-${l.id.toUpperCase()}",
      );
    }).toList();
    notifyListeners();
  }

  Lot? get activeLot {
    try {
      return lots.firstWhere(
        (l) => l.status != LotStatus.paid && l.status != LotStatus.trace,
      );
    } catch (_) {
      return lots.isNotEmpty ? lots.first : null;
    }
  }

  double todayEarned() {
    final today = DateTime.now();
    return lots
        .where((l) =>
            l.paymentStatus == PaymentStatus.paid &&
            l.createdAt.year == today.year &&
            l.createdAt.month == today.month &&
            l.createdAt.day == today.day)
        .fold(0.0, (s, l) => s + l.amount);
  }

  // Seed demo data
  void seedDemo() {
    if (lots.isNotEmpty) return;
    final row = rateFor(MaterialId.mixed);
    lots = [
      Lot(
        id: "demo01",
        category: MaterialId.mixed,
        weightKg: 12,
        estimatedValue: 12 * row.ratePerKg,
        ratePerKg: row.ratePerKg,
        finalPrice: 560,
        status: LotStatus.paid,
        locationLabel: kSampleArea,
        paymentMethod: PayMethod.cash,
        paymentStatus: PaymentStatus.paid,
        collectorName: displayName,
        collectorArea: kSampleArea,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        synced: true,
      ),
      Lot(
        id: "demo02",
        category: MaterialId.plastic,
        weightKg: 40,
        estimatedValue: 40 * rateFor(MaterialId.plastic).ratePerKg,
        ratePerKg: rateFor(MaterialId.plastic).ratePerKg,
        quotedPrice: 680,
        status: LotStatus.offered,
        locationLabel: kSampleArea,
        paymentStatus: PaymentStatus.pending,
        collectorName: displayName,
        collectorArea: kSampleArea,
        recyclerId: "r2",
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ];
    notifyListeners();
  }
}
