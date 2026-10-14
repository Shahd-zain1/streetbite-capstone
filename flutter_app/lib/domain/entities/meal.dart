import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  const Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
  });

  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;

  double get price => (40 + ((int.tryParse(id) ?? 0) % 10) * 10).toDouble();

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    area,
    instructions,
    thumbnail,
  ];
}
