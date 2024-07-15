import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/widgets/custom_bottom_sheet.widget.dart';
import '../../../shared/widgets/time_picker.widget.dart';
import '../../../theme.dart';
import "../models/date.model.dart";
import '../models/drink_log.model.dart';
import '../models/time.model.dart';
import '../providers/day_stats.provider.dart';

class RecordDetailsModalBottomSheet extends HookConsumerWidget {
  final DrinkLog? drinkLog;
  const RecordDetailsModalBottomSheet({
    super.key,
    this.drinkLog,
  });

  static Future<void> show(BuildContext context, {DrinkLog? drinkLog}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: RecordDetailsModalBottomSheet(drinkLog: drinkLog),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amount = useState(drinkLog?.amount ?? 0);
    final time = useState(drinkLog?.time ?? TimeModel.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            drinkLog == null ? "Add Record" : "Edit Record",
            style: Theme.of(ref.context).textTheme.headlineLarge,
          ),
        ),
        _buildAmountInput(
          ref,
          amountNotifier: amount,
        ),
        const SizedBox(height: 16),
        _buildTimePicker(
          ref,
          timeNotifier: time,
        ),
        _buildSubmitButton(
          ref,
          amount: amount.value,
          time: time.value,
        ),
      ],
    );
  }

  Widget _buildAmountInput(
    WidgetRef ref, {
    required ValueNotifier<int> amountNotifier,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        initialValue: amountNotifier.value.toString(),
        onChanged: (value) => amountNotifier.value = int.tryParse(value) ?? 0,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: "Amount",
          suffix: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              "ml",
              style: Theme.of(ref.context).textTheme.bodyMedium,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildSubmitButton(
    WidgetRef ref, {
    required int amount,
    required TimeModel time,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ElevatedButton(
        onPressed: () async {
          if (drinkLog != null) {
            await ref.read(dayStatsProvider().notifier).updateRecord(drinkLog!);
          }
          final date = DateModel.now();
          await ref.read(dayStatsProvider().notifier).addRecord(
                DrinkLog.create(
                  amount: amount,
                  date: date,
                  time: time,
                ),
              );
          if (ref.context.mounted) ref.context.pop();
        },
        child: const Text("Submit"),
      ),
    );
  }

  Widget _buildTimePicker(
    WidgetRef ref, {
    required ValueNotifier<TimeModel> timeNotifier,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TimePicker(
        time: timeNotifier.value,
        onTimeChanged: (newTime) => timeNotifier.value = newTime,
      ),
    );
  }
}

class HomeScreen extends HookConsumerWidget {
  static String get route => '/home';

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = useState(DateModel.now());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildBody(ref, dateNotifier: selectedDay)),
          CustomBottomSheet(
            child: _buildAddRecordButton(ref),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildAddRecordButton(WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => RecordDetailsModalBottomSheet.show(ref.context),
      child: const Text("Drink"),
    );
  }

  Widget _buildBody(
    WidgetRef ref, {
    required ValueNotifier<DateModel> dateNotifier,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24).copyWith(top: 48),
          child: Column(
            children: [
              _buildDayPicker(ref, dateNotifier: dateNotifier),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _buildStat(ref, date: dateNotifier.value),
              ),
              _buildProgressBar(ref, date: dateNotifier.value),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _buildLogs(ref, date: dateNotifier.value),
          ),
        ),
      ],
    );
  }

  Widget _buildDayPicker(
    WidgetRef ref, {
    required ValueNotifier<DateModel> dateNotifier,
  }) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: () async {
          final newDate = await showDatePicker(
            context: ref.context,
            initialDate: dateNotifier.value.toDateTime(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );
          if (newDate != null) {
            dateNotifier.value = DateModel.fromDateTime(newDate);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () =>
                    dateNotifier.value = dateNotifier.value.yesterday(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Text(
                    dateNotifier.value.isToday
                        ? "Today"
                        : DateFormat.yMMMMd()
                            .format(dateNotifier.value.toDateTime()),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: dateNotifier.value.isToday
                    ? null
                    : () => dateNotifier.value = dateNotifier.value.tomorrow(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLog(WidgetRef ref, DrinkLog drinkLog) {
    return ListTile(
      onTap: () => RecordDetailsModalBottomSheet.show(
        ref.context,
        drinkLog: drinkLog,
      ),
      title: Text(
        "${drinkLog.amount}ml",
        style: Theme.of(ref.context).textTheme.bodyLarge,
      ),
      trailing: Text(
        drinkLog.time.toString(),
        style: Theme.of(ref.context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildLogs(WidgetRef ref, {required DateModel date}) {
    final dayStats = ref.watch(dayStatsProvider(date: date));
    return switch (dayStats) {
      AsyncData(value: final daysStats) => ListView.builder(
          itemCount: daysStats.logs.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              bottom: index == 14 ? 24 : 8,
              top: index == 0 ? 24 : 0,
            ),
            child: _buildLog(ref, daysStats.logs[index]),
          ),
        ),
      AsyncError(error: final error) => Center(child: Text(error.toString())),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Widget _buildProgressBar(
    WidgetRef ref, {
    required DateModel date,
  }) {
    final dayStats = ref.watch(dayStatsProvider(date: date));
    return LinearProgressIndicator(
      borderRadius: BorderRadius.circular(16),
      value: switch (dayStats) {
        AsyncData(value: final daysStats) => daysStats.current / daysStats.goal,
        _ => 0,
      },
    );
  }

  Widget _buildStat(
    WidgetRef ref, {
    required DateModel date,
  }) {
    final dayStats = ref.watch(dayStatsProvider(date: date));
    return switch (dayStats) {
      AsyncData(value: final daysStats) => InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(kBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "${daysStats.current}ml",
                  style: Theme.of(ref.context).textTheme.displayLarge,
                ),
                Text(
                  "/ ${daysStats.goal}ml",
                  style: Theme.of(ref.context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
        ),
      _ => const CircularProgressIndicator(),
    };
  }
}
