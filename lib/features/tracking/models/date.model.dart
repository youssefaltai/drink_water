import 'package:freezed_annotation/freezed_annotation.dart';

part 'date.model.freezed.dart';
part 'date.model.g.dart';

@freezed
class DateModel with _$DateModel {
  const DateModel._();

  const factory DateModel({
    required int year,
    required int month,
    required int day,
  }) = _DateModel;

  factory DateModel.now() {
    final now = DateTime.now();
    return DateModel(
      year: now.year,
      month: now.month,
      day: now.day,
    );
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  factory DateModel.fromJson(Map<String, dynamic> json) =>
      _$DateModelFromJson(json);

  factory DateModel.fromDateTime(DateTime dateTime) => DateModel(
        year: dateTime.year,
        month: dateTime.month,
        day: dateTime.day,
      );

  DateTime toDateTime() => DateTime(year, month, day);

  DateModel yesterday() => copyWith(day: day - 1);
  DateModel tomorrow() => copyWith(day: day + 1);
}
