import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late Map<DateTime, List<String>> _events;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _events = {
      DateTime.utc(2025, 4, 1): [
        'Statistics Lesson: 2pm-4pm at Room 101 with Dr. Smith',
      ],
      DateTime.utc(2025, 4, 2): [
        'Co-curricular Activity: Basketball Practice 4pm-6pm at Sports Hall',
      ],
      DateTime.utc(2025, 4, 6): [
        'Talk: Technology in Healthcare 6pm at Lecture Hall 3',
      ],
      DateTime.utc(2025, 4, 7): [
        'History Lecture: 1pm-3pm at Room 103 with Dr. Lee',
      ],
      DateTime.utc(2025, 4, 12): [
        'Co-curricular Activity: Coding Bootcamp 3pm-5pm at Lab 1',
      ],
      DateTime.utc(2025, 4, 15): [
        'Talk: Future of Smart Cities 5pm at Conference Room 2',
      ],
      DateTime.utc(2025, 4, 13): [
        'Literature Class: 9am-11am at Room 104 with Ms. Williams',
      ],
      DateTime.utc(2025, 4, 16): [
        'Co-curricular Activity: Dance Practice 4pm-6pm at Dance Studio',
      ],
      DateTime.utc(2025, 4, 19): [
        'Talk: Advances in Renewable Energy 6:30pm at Hall A',
      ],
      DateTime.utc(2025, 4, 21): [
        'Chemistry Class: 9am-11am at Room 108 with Dr. Wright',
      ],
      DateTime.utc(2025, 4, 22): [
        'Co-curricular Activity: Robotics Workshop 2pm-4pm at Lab 2',
      ],
      DateTime.utc(2025, 4, 23): [
        'Talk: Blockchain Technology 7pm at Auditorium',
      ],
      DateTime.utc(2025, 4, 27): [
        'History Exam Review: 1pm-3pm at Room 109 with Dr. Moore',
      ],
      DateTime.utc(2025, 4, 29): [
        'Co-curricular Activity: Coding Challenge 3pm-5pm at Lab 3',
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Schedule & Events'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update focused day
                });
              },
              eventLoader: (day) {
                return _events[day] ?? [];
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Events for ${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTodoList(),
          ],
        ),
      ),
    );
  }

  // Display the to-do list for the selected date
  Widget _buildTodoList() {
    final eventsForSelectedDay = _events[_selectedDay] ?? [];

    if (eventsForSelectedDay.isEmpty) {
      return const Text('No events for today.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: eventsForSelectedDay.map((event) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: _buildEventCard(event),
        );
      }).toList(),
    );
  }

  // Custom event card for each item in the list
  Widget _buildEventCard(String event) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          event,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }
}
