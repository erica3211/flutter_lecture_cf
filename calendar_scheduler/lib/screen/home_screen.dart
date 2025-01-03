import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/schedule.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Map<DateTime, List<ScheduleTable>> schedules = {
    DateTime.utc(2024, 12, 28): [
      // ScheduleTable(
      //   id: 1,
      //   startTime: 11,
      //   endTime: 12,
      //   content: '플러터 공부하기',
      //   date: DateTime.utc(2024, 12, 28),
      //   color: categoryColors[0],
      //   createdAt: DateTime.now().toUtc(),
      // ),
      // ScheduleTable(
      //   id: 2,
      //   startTime: 14,
      //   endTime: 16,
      //   content: 'NestJS 공부하기',
      //   date: DateTime.utc(2024, 12, 28),
      //   color: categoryColors[3],
      //   createdAt: DateTime.now().toUtc(),
      // ),
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final schedule = await showModalBottomSheet<ScheduleTable>(
            context: context,
            builder: (_) {
              return ScheduleBottomSheet(
                selectedDay: selectedDay,
              );
            },
          );
          if (schedule == null) {
            return;
          }
          // 방법 1
          // setState(() {
          //   schedules = {
          //     ...schedules,
          //     schedule.date: [
          //       if (schedules.containsKey(schedule.date))
          //         ...schedules[schedule.date]!,
          //       schedule,
          //     ]
          //   };
          // });

          // 방법 2
          // final dataExists = schedules.containsKey(schedule.date);
          // final List<Schedule> existingSchedules = dataExists ? schedules[schedule.date]! :[];
          //
          // setState(() {
          //   /// [Schedule1, Schedule2]
          //   /// [Schedule2]
          //   existingSchedules!.add(schedule);
          //   schedules = {
          //     ...schedules,
          //     schedule.date: existingSchedules,
          //
          //   };
          // });

        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              focusedDay: DateTime(2024, 12, 1),
              onDaySelected: onDayselected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              taskCount: 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: ListView.separated(
                  itemCount: schedules.containsKey(selectedDay)
                      ? schedules[selectedDay]!.length
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    // 선택된 날짜에 해당되는 일정 리스트로 저장
                    // List<Schedule>
                    final selectedSchedules = schedules[selectedDay]!;
                    final scheduleModel = selectedSchedules[index];
                    return ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content:'아무거나 넣기',
                      color: Color(
                        int.parse(
                          'FF${scheduleModel.color}',
                          radix: 16,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 8.0,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDayselected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime date) {
    if (selectedDay == null) {
      return false;
    }
    return date.isAtSameMomentAs(selectedDay!);
  }
}
