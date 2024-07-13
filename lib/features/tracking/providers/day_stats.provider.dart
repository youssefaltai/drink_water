import 'package:drink_water/features/tracking/models/date.model.dart';
import 'package:drink_water/features/tracking/models/drink_log.model.dart';
import 'package:drink_water/shared/providers/dio.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/day_stats.model.dart';

part 'day_stats.provider.g.dart';

@riverpod
class DayStats extends _$DayStats {
  @override
  Future<DayStatsModel> build({DateModel? date}) async {
    final date_ = date ?? DateModel.now();
    final api = ref.read(apiProvider);
    final response = await api.get('/', queryParameters: {
      'day': date_.day,
      'month': date_.month,
      'year': date_.year,
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to load day stats');
    }

    return DayStatsModel.fromJson(response.data);
  }

  Future<void> addRecord(DrinkLog log) async {
    final api = ref.read(apiProvider);
    final response = await api.post('/', data: log.toJson());

    if (response.statusCode != 201) {
      throw Exception('Failed to add record');
    }

    ref.invalidateSelf();

    await future;
  }
}
