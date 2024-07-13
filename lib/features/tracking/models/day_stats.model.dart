import 'package:drink_water/features/tracking/models/drink_log.model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'date.model.dart';

part 'day_stats.model.g.dart';

@JsonSerializable()
class DayStatsModel {
  final DateModel date;
  final int goal;
  final int current;
  final int remaining;
  final List<DrinkLog> logs;

  DayStatsModel({
    required this.date,
    required this.goal,
    required this.current,
    required this.remaining,
    required this.logs,
  });

  factory DayStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DayStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DayStatsModelToJson(this);
}
