import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/providers/dio.provider.dart';
import '../models/date.model.dart';
import '../models/day_stats.model.dart';
import '../models/drink_log.model.dart';

part 'day_stats.provider.g.dart';

@riverpod
class DayStats extends _$DayStats {
  Future<void> addRecord(DrinkLog log) async {
    final api = ref.read(apiProvider);
    final response = await api.post('/', data: log.toJson());

    if (response.statusCode != 201) {
      throw Exception('Failed to add record');
    }

    ref.invalidateSelf();

    await future;
  }

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

  Future<void> updateRecord(DrinkLog drinkLog) async {
    final api = ref.read(apiProvider);
    final response = await api.put('/${drinkLog.id}', data: drinkLog.toJson());

    if (response.statusCode != 200) {
      throw Exception('Failed to update record');
    }

    ref.invalidateSelf();

    await future;
  }
}
