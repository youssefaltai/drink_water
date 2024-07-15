import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/tracking/models/time.model.dart';

class TimePicker extends HookConsumerWidget {
  final TimeModel time;
  final void Function(TimeModel) onTimeChanged;
  const TimePicker({
    super.key,
    required this.time,
    required this.onTimeChanged,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: () async {
            final result = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                hour: time.hours + (time.ampm == AMPM.pm ? 12 : 0),
                minute: time.minutes,
              ),
            );
            if (result != null) {
              onTimeChanged(
                TimeModel(
                  hours: result.hour == 0 ? 12 : result.hour % 12,
                  minutes: result.minute,
                  ampm: result.period == DayPeriod.am ? AMPM.am : AMPM.pm,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$time",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
