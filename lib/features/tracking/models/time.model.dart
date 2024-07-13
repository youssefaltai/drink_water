import 'package:json_annotation/json_annotation.dart';

part 'time.model.g.dart';

enum AMPM {
  @JsonValue("AM")
  am("AM"),
  @JsonValue("PM")
  pm("PM");

  final String value;
  const AMPM(this.value);
}

@JsonSerializable()
class TimeModel {
  final int hours;
  final int minutes;
  final AMPM ampm;

  TimeModel({
    required this.hours,
    required this.minutes,
    required this.ampm,
  });

  get h => (hours == 0 ? 12 : hours % 12).toString();
  get m => minutes.toString().padLeft(2, "0");
  get a => ampm.value;

  @override
  String toString() {
    return "$h:$m $a";
  }

  factory TimeModel.fromJson(Map<String, dynamic> json) =>
      _$TimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeModelToJson(this);

  factory TimeModel.now() {
    final now = DateTime.now();
    final hours = now.hour == 0 ? 12 : now.hour % 12;
    final minutes = now.minute;
    final ampm = now.hour < 12 ? AMPM.am : AMPM.pm;
    return TimeModel(hours: hours, minutes: minutes, ampm: ampm);
  }
}
