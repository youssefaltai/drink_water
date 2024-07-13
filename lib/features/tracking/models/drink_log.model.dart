import 'package:drink_water/features/tracking/models/time.model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'date.model.dart';

part 'drink_log.model.g.dart';

@JsonSerializable()
class DrinkLog {
  final String id;
  final int amount;
  final DateModel date;
  final TimeModel time;

  DrinkLog({
    required this.id,
    required this.amount,
    required this.date,
    required this.time,
  });

  factory DrinkLog.create({
    required int amount,
    required DateModel date,
    required TimeModel time,
  }) =>
      DrinkLog(
        id: "",
        amount: amount,
        date: date,
        time: time,
      );

  factory DrinkLog.fromJson(Map<String, dynamic> json) =>
      _$DrinkLogFromJson(json);
  Map<String, dynamic> toJson() => _$DrinkLogToJson(this);
}
