import '../models/types.dart';

const List<MaterialId> materialOrder = [
  MaterialId.pcb,
  MaterialId.copper,
  MaterialId.aluminium,
  MaterialId.plastic,
  MaterialId.iron,
  MaterialId.mixed,
];

const List<PriceRow> priceBoard = [
  PriceRow(category: MaterialId.pcb, ratePerKg: 320, low: 280, high: 360, trend: [300, 310, 315, 320, 318, 322, 320]),
  PriceRow(category: MaterialId.copper, ratePerKg: 450, low: 420, high: 480, trend: [430, 440, 445, 450, 448, 455, 450]),
  PriceRow(category: MaterialId.aluminium, ratePerKg: 150, low: 130, high: 170, trend: [140, 145, 148, 150, 149, 152, 150]),
  PriceRow(category: MaterialId.plastic, ratePerKg: 25, low: 18, high: 32, trend: [20, 22, 23, 25, 24, 26, 25]),
  PriceRow(category: MaterialId.iron, ratePerKg: 35, low: 28, high: 42, trend: [30, 32, 33, 35, 34, 36, 35]),
  PriceRow(category: MaterialId.mixed, ratePerKg: 40, low: 30, high: 55, trend: [35, 38, 39, 40, 41, 42, 40]),
];

PriceRow rateFor(MaterialId id) {
  return priceBoard.firstWhere((p) => p.category == id, orElse: () => priceBoard.last);
}

const List<Recycler> recyclers = [
  Recycler(
    id: "R1",
    name: "Green Yard Indore",
    km: 2.4,
    authorized: true,
    materials: [MaterialId.copper, MaterialId.aluminium, MaterialId.pcb],
    rateBonus: 8,
  ),
  Recycler(
    id: "R2",
    name: "City Scrap Hub",
    km: 4.1,
    authorized: true,
    materials: [MaterialId.iron, MaterialId.plastic, MaterialId.mixed],
    rateBonus: 5,
  ),
  Recycler(
    id: "R3",
    name: "Local Kabadi Point",
    km: 1.2,
    authorized: false,
    materials: [MaterialId.mixed, MaterialId.iron, MaterialId.plastic],
    rateBonus: 0,
  ),
];
