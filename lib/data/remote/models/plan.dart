import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcafe_dashboard/data/local/model/plan/plan.dart';

class PlanResponse {
  PlanResponse._({
    this.id,
    this.description,
    this.price,
    this.name,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.totalOrders,
    this.isActive,
  });

  final String? id;
  final String? name;
  final String? price;
  final String? description;
  final String? totalOrders;
  final Timestamp? createdAt;
  final String? createdBy;
  final String? updatedBy;
  final Timestamp? updatedAt;
  final bool? isActive;

  factory PlanResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data();
    return PlanResponse._(
      id: snapshot.id,
      name: json?['name'],
      price: json?['price'],
      createdAt: json?['created_at'],
      description: json?['description'],
      createdBy: json?['created_by'],
      updatedAt: json?['updated_at'],
      updatedBy: json?['updated_by'],
      totalOrders: json?['total_orders'],
      isActive: json?['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'created_by': createdBy,
      'created_at': createdAt?.toDate().toIso8601String(),
      'updated_by': updatedBy,
      'updated_at': updatedAt?.toDate().toIso8601String(),
      'total_orders': totalOrders,
      'description': description,
    };
  }

  HivePlan get toHive {
    return HivePlan()
      ..name = name
      ..description = description
      ..totalOrders = totalOrders
      ..updatedBy = updatedBy
      ..createdBy = createdBy
      ..createdAt = createdAt?.toDate().toIso8601String()
      ..description = description
      ..isActive = isActive
      ..price = price
      ..id = id
      ..updatedAt = updatedAt?.toDate().toIso8601String();
  }

  @override
  String toString() => jsonEncode(toJson());
}
