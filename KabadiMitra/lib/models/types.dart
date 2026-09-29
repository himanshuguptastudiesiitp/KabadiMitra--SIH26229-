enum UserRole { collector, recycler, admin }

enum MaterialId { pcb, copper, aluminium, plastic, iron, mixed }

enum LotStatus {
  collected,
  identified,
  valued,
  offered,
  accepted,
  handover,
  paid,
  trace,
}

enum PayMethod { cash, upi }

enum PaymentStatus { none, pending, paid }

enum Lang { hi, en }

class Lot {
  final String id;
  final MaterialId category;
  final double weightKg;
  final String? photoDataUrl;
  final double estimatedValue;
  final double ratePerKg;
  final double? quotedPrice;
  final double? finalPrice;
  final LotStatus status;
  final String locationLabel;
  final PayMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final String collectorName;
  final String collectorArea;
  final String? recyclerId;
  final String? handoverRef;
  final DateTime createdAt;
  final bool synced;

  Lot({
    required this.id,
    required this.category,
    required this.weightKg,
    this.photoDataUrl,
    required this.estimatedValue,
    required this.ratePerKg,
    this.quotedPrice,
    this.finalPrice,
    required this.status,
    required this.locationLabel,
    this.paymentMethod = PayMethod.cash,
    this.paymentStatus = PaymentStatus.none,
    required this.collectorName,
    required this.collectorArea,
    this.recyclerId,
    this.handoverRef,
    required this.createdAt,
    this.synced = false,
  });

  Lot copyWith({
    MaterialId? category,
    double? weightKg,
    String? photoDataUrl,
    double? estimatedValue,
    double? ratePerKg,
    double? quotedPrice,
    double? finalPrice,
    LotStatus? status,
    PayMethod? paymentMethod,
    PaymentStatus? paymentStatus,
    String? recyclerId,
    String? handoverRef,
    bool? synced,
  }) {
    return Lot(
      id: id,
      category: category ?? this.category,
      weightKg: weightKg ?? this.weightKg,
      photoDataUrl: photoDataUrl ?? this.photoDataUrl,
      estimatedValue: estimatedValue ?? this.estimatedValue,
      ratePerKg: ratePerKg ?? this.ratePerKg,
      quotedPrice: quotedPrice ?? this.quotedPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      status: status ?? this.status,
      locationLabel: locationLabel,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      collectorName: collectorName,
      collectorArea: collectorArea,
      recyclerId: recyclerId ?? this.recyclerId,
      handoverRef: handoverRef ?? this.handoverRef,
      createdAt: createdAt,
      synced: synced ?? this.synced,
    );
  }

  double get amount => finalPrice ?? quotedPrice ?? estimatedValue;
}

class Recycler {
  final String id;
  final String name;
  final double km;
  final bool authorized;
  final List<MaterialId> materials;
  final double rateBonus;

  const Recycler({
    required this.id,
    required this.name,
    required this.km,
    required this.authorized,
    required this.materials,
    this.rateBonus = 0,
  });
}

class PriceRow {
  final MaterialId category;
  final double ratePerKg;
  final double low;
  final double high;
  final List<double> trend;

  const PriceRow({
    required this.category,
    required this.ratePerKg,
    required this.low,
    required this.high,
    required this.trend,
  });
}
