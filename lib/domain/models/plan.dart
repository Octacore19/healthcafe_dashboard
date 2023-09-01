import 'package:equatable/equatable.dart';
import 'package:healthcafe_dashboard/data/local/model/plan/plan.dart';

class Plan extends Equatable {
  const Plan._({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.totalOrders,
    required this.isActive,
  });

  final String id;
  final String name;
  final String price;
  final String description;
  final String totalOrders;
  final bool isActive;

  factory Plan.fromHive(HivePlan value) {
    return Plan._(
      id: value.id ?? '',
      name: value.name ?? '',
      price: value.price ?? '',
      description: value.description ?? '',
      totalOrders: value.totalOrders ?? '0',
      isActive: value.isActive ?? false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        description,
        totalOrders,
        isActive,
      ];
}
