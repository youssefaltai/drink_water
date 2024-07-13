import 'package:json_annotation/json_annotation.dart';

part 'date.model.g.dart';

@JsonSerializable()
class DateModel {
  final int day;
  final int month;
  final int year;

  DateModel({
    required this.day,
    required this.month,
    required this.year,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) =>
      _$DateModelFromJson(json);

  Map<String, dynamic> toJson() => _$DateModelToJson(this);

  @override
  toString() => '$year-$month-$day';

  factory DateModel.now() {
    final now = DateTime.now();
    return DateModel(
      day: now.day,
      month: now.month,
      year: now.year,
    );
  }
}
