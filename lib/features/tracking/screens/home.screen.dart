import 'package:drink_water/features/tracking/models/date.model.dart';
import 'package:drink_water/features/tracking/models/time.model.dart';
import 'package:drink_water/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/widgets/custom_bottom_sheet.widget.dart';
import '../../../shared/widgets/time_picker.widget.dart';
import '../models/drink_log.model.dart';
import '../providers/day_stats.provider.dart';

class HomeScreen extends HookConsumerWidget {
  static String get route => '/home';

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildBody(ref)),
          CustomBottomSheet(
            child: _buildAddRecordButton(ref),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildAddRecordButton(WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: ref.context,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const AddRecordModalBottomSheet(),
          ),
        );
      },
      child: const Text("Drink"),
    );
  }

  Widget _buildBody(WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24).copyWith(top: 48),
          decoration: BoxDecoration(
            color: Theme.of(ref.context).primaryColor,
          ),
          child: Column(
            children: [
              _buildDayPicker(ref),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: _buildStat(ref),
              ),
              _buildProgressBar(ref),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _buildLogs(ref),
        )),
      ],
    );
  }

  Widget _buildLogs(WidgetRef ref) {
    final dayStats = ref.watch(dayStatsProvider());
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

  Widget _buildLog(WidgetRef ref, DrinkLog drinkLog) {
    return ListTile(
      onTap: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      title: Text(
        "${drinkLog.amount}ml",
        style: Theme.of(ref.context).textTheme.bodyLarge,
      ),
      trailing: Text(
        drinkLog.time.toString(),
        style: Theme.of(ref.context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(ref.context).disabledColor,
            ),
      ),
    );
  }

  Widget _buildDayPicker(WidgetRef ref) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {},
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(child: Text("Today")),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(WidgetRef ref) {
    final dayStats = ref.watch(dayStatsProvider());
    return switch (dayStats) {
      AsyncData(value: final daysStats) => InkWell(
          onTap: () {},
          child: Column(
            children: [
              Text(
                "${daysStats.current}ml",
                style: Theme.of(ref.context).textTheme.displayLarge,
              ),
              Text(
                "/ ${daysStats.goal}ml",
                style: Theme.of(ref.context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: Theme.of(ref.context).disabledColor),
              ),
            ],
          ),
        ),
      _ => const CircularProgressIndicator(),
    };
  }

  Widget _buildProgressBar(WidgetRef ref) {
    final dayStats = ref.watch(dayStatsProvider());
    return LinearProgressIndicator(
      borderRadius: BorderRadius.circular(16),
      value: switch (dayStats) {
        AsyncData(value: final daysStats) => daysStats.current / daysStats.goal,
        _ => 0,
      },
    );
  }
}

class AddRecordModalBottomSheet extends HookConsumerWidget {
  const AddRecordModalBottomSheet({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amount = useState(0);
    final time = useState(TimeModel.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            "Add Record",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        _buildAmountInput(ref, amount),
        const SizedBox(height: 16),
        _buildTimePicker(ref, time),
        _buildSubmitButton(ref, amount.value, time.value),
      ],
    );
  }

  Widget _buildAmountInput(WidgetRef ref, ValueNotifier<int> amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        initialValue: amount.value.toString(),
        onChanged: (value) => amount.value = int.tryParse(value) ?? 0,
        textAlign: TextAlign.center,
        cursorColor: accentColor,
        decoration: InputDecoration(
          hintText: "Amount",
          suffix: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              "ml",
              style: TextStyle(
                color: onPrimaryColor,
              ),
            ),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildTimePicker(WidgetRef ref, ValueNotifier<TimeModel> time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TimePicker(
        time: time.value,
        onTimeChanged: (newTime) => time.value = newTime,
      ),
    );
  }

  Widget _buildSubmitButton(WidgetRef ref, int amount, TimeModel time) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ElevatedButton(
        onPressed: () async {
          final date = DateModel.now();
          await ref.read(dayStatsProvider().notifier).addRecord(
                DrinkLog.create(
                  amount: amount,
                  date: date,
                  time: time,
                ),
              );

          if (ref.context.mounted) {
            ref.context.pop();
          }
        },
        child: const Text("Submit"),
      ),
    );
  }
}
