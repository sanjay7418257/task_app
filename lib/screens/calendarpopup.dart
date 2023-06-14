import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class calendar extends StatelessWidget {
  calendar({super.key});
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      backgroundColor: Color(0xff1c1c1e),
      content: Container(
        height: size.height * 0.42,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff1c1c1e),
        ),
        child: TableCalendar(
          rowHeight: 40,
          firstDay: DateTime.now(),
          focusedDay: _selectedDate,
          lastDay: DateTime(2025),
          selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
          headerStyle: const HeaderStyle(
            formatButtonDecoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            leftChevronIcon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            rightChevronIcon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              color: Color(0xffffffff),
            ),
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: const CalendarStyle(
            defaultTextStyle: TextStyle(
              color: Color(0xffffffff),
              fontSize: 14,
            ),
            outsideDaysVisible: false,
            selectedDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff04296E),
            ),
            isTodayHighlighted: false,
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff04296e),
            ),
            tablePadding: EdgeInsets.symmetric(
              horizontal: 1,
              vertical: 2,
            ),
          ),
          headerVisible: true,
          availableGestures: AvailableGestures.all,
          onDaySelected: (selectedDay, focusedDay) {
            Navigator.of(context).pop(selectedDay);
          },
        ),
      ),
    );
  }
}
