import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryCalendar extends StatefulWidget {
  DateTime focusedDay;
  DateTime? selectedDay;

  HistoryCalendar(
      {super.key, required this.focusedDay, required this.selectedDay});

  @override
  State<HistoryCalendar> createState() => _HistoryCalendarState();
}

class _HistoryCalendarState extends State<HistoryCalendar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.focusedDay.year}년 ${widget.focusedDay.month}월",
                style:
                    HourStyles.body2.copyWith(color: HourColors.staticWhite),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      width: 24,
                      height: 24,
                      "assets/images/ic_left.png",
                      color: HourColors.primary300,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.focusedDay = DateTime(
                          widget.focusedDay.year,
                          widget.focusedDay.month - 1,
                        );
                      });
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      width: 24,
                      height: 24,
                      "assets/images/ic_right.png",
                      color: HourColors.primary300,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.focusedDay = DateTime(
                          widget.focusedDay.year,
                          widget.focusedDay.month + 1,
                        );
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['일', '월', '화', '수', '목', '금', '토'].map((day) {
              return Text(
                  day,
                  style: TextStyle(
                      color: Colors.white
                  )
              );
            }).toList(),
          ),
          TableCalendar(
            formatAnimationDuration: Duration.zero,
            rowHeight: 60,
            daysOfWeekVisible: false,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: widget.focusedDay,
            selectedDayPredicate: (day) => isSameDay(
                widget.selectedDay, day
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                widget.selectedDay = selectedDay;
                widget.focusedDay = focusedDay;
              });
            },
            headerVisible: false,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              isTodayHighlighted: false,
              selectedDecoration: BoxDecoration(
                color: HourColors.orange500,
                shape: BoxShape.circle,
              ),
              todayTextStyle: HourStyles.body1.copyWith(
                  color: HourColors.gray500
              ),
              defaultTextStyle: HourStyles.body1.copyWith(
                  color: HourColors.gray500
              ),
              weekendTextStyle: HourStyles.body1.copyWith(
                  color: HourColors.gray500
              ),
              outsideTextStyle: HourStyles.body1.copyWith(
                  color: HourColors.gray500
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.white),
              weekendStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
