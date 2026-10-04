import '../models/types.dart';

const String kSampleArea = "Nagpur";

const List<MaterialId> materialOrder = [
  MaterialId.pcb,
  MaterialId.copper,
  MaterialId.aluminium,
  MaterialId.plastic,
  MaterialId.iron,
  MaterialId.mixed,
];

const List<PriceRow> priceBoard = [
  PriceRow(category: MaterialId.copper, ratePerKg: 420, low: 400, high: 450, trend: [410, 415, 420]),
  PriceRow(category: MaterialId.aluminium, ratePerKg: 130, low: 120, high: 140, trend: [125, 128, 130]),
  PriceRow(category: MaterialId.pcb, ratePerKg: 280, low: 250, high: 320, trend: [260, 270, 280]),
  PriceRow(category: MaterialId.plastic, ratePerKg: 18, low: 15, high: 22, trend: [16, 17, 18]),
  PriceRow(category: MaterialId.iron, ratePerKg: 28, low: 25, high: 32, trend: [26, 27, 28]),
  PriceRow(category: MaterialId.mixed, ratePerKg: 35, low: 30, high: 40, trend: [32, 34, 35]),
];

PriceRow rateFor(MaterialId id) =>
    priceBoard.firstWhere((r) => r.category == id, orElse: () => priceBoard.last);

const List<Recycler> recyclers = [
  Recycler(
    id: "r1",
    name: "Green Yard Nagpur",
    km: 2.4,
    authorized: true,
    materials: [MaterialId.copper, MaterialId.aluminium, MaterialId.pcb, MaterialId.mixed],
    rateBonus: 5,
  ),
  Recycler(
    id: "r2",
    name: "Metro Scrap Hub",
    km: 4.1,
    authorized: true,
    materials: [MaterialId.iron, MaterialId.plastic, MaterialId.mixed],
    rateBonus: 2,
  ),
  Recycler(
    id: "r3",
    name: "Eco Recycle Co",
    km: 6.8,
    authorized: false,
    materials: [MaterialId.pcb, MaterialId.copper, MaterialId.aluminium],
    rateBonus: 8,
  ),
];
