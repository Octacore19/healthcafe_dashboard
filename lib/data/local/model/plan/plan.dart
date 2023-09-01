import 'dart:convert';

import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/base_model.dart';
import 'package:hive/hive.dart';

part 'plan.g.dart';

@HiveType(typeId: planId, adapterName: 'PlanAdapter')
class HivePlan extends HiveObject with BaseModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? price;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? totalOrders;

  @HiveField(5)
  String? createdAt;

  @HiveField(6)
  String? createdBy;

  @HiveField(7)
  String? updatedBy;

  @HiveField(8)
  String? updatedAt;

  @HiveField(9)
  bool? isActive;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'total_orders': totalOrders,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'is_active': isActive,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
