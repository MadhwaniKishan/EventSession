import 'package:event_session/model/bookedEventsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import 'package:intl/intl.dart';

class GetCalendarWidget extends StatefulWidget {
  final BookedEvents bookedEvents;

  GetCalendarWidget(this.bookedEvents);

  @override
  _GetCalendarWidgetState createState() => _GetCalendarWidgetState();
}

class _GetCalendarWidgetState extends State<GetCalendarWidget> {
  DateTime _currentDate = DateTime.now();
  static DateTime dateNow = DateTime.now();
  static var formatTitle = DateFormat("MMMM yyyy");
  String _headerTitle = formatTitle.format(dateNow);
  EventList<Event> _markedDateMap = new EventList<Event>();

  @override
  void initState() {
    super.initState();

    for (var record in this.widget.bookedEvents.bookedEvents) {
      DateTime date = DateTime.parse(record.date);
      addMarker(date, record.isCanceled, record.isAvailable,
          record.isClassSessionFull, record.isBooked, record.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            getCalendar(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  getStatusIcon(Colors.blue, "Available"),
                  getStatusIcon(Colors.blue[900], "Booked"),
                  getStatusIcon(Colors.pinkAccent, "Full"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: <Widget>[
                  getStatusIcon(Colors.red, "Canceled"),
                  getStatusIcon(Colors.green, "Attended"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getStatusIcon(color, text) {
    return Row(
      children: <Widget>[
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(1000)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 40),
          child: Text(text),
        ),
      ],
    );
  }

  void addMarker(DateTime startEventDateTime, isCanceled, isAvailable,
      isClassFull, isBooked, date) {
    var eventDateTime = startEventDateTime;
    var markerText = startEventDateTime.day.toString();

    _markedDateMap.add(
        eventDateTime,
        Event(
          date: startEventDateTime,
          icon: getIcon(
              markerText, isCanceled, isAvailable, isClassFull, isBooked, date),
        ));
  }

  Widget getIcon(
      String dateString, isCanceled, isAvailable, isClassFull, isBooked, date) {
    return Container(
      decoration: BoxDecoration(
        color: getColor(isCanceled, isAvailable, isClassFull, isBooked, date),
        borderRadius: BorderRadius.all(Radius.circular(1000)),
      ),
      child: Center(
        child: Text(
          dateString,
          style: TextStyle(
              color: getTextColor(
                  isCanceled, isAvailable, isClassFull, isBooked, date)),
        ),
      ),
    );
  }

  Color getColor(isCanceled, isAvailable, isClassFull, isBooked, date) {
    if (isCanceled == 1) {
      return Colors.red;
    } else if (isBooked == 1) {
      if (DateTime.now().isAfter(DateTime.parse(date)))
        return Colors.green;
      else {
        return Colors.blue[900];
      }
    } else if (isClassFull == 1) {
      return Colors.pinkAccent;
    } else if (isAvailable == 1) {
      return Colors.lightBlue;
    } else {
      return Colors.lightBlue;
    }
  }

  Color getTextColor(isCanceled, isAvailable, isClassFull, isBooked, date) {
    return Colors.white;
  }

  Widget getCalendar() {
    return Container(
      child: CalendarCarousel<Event>(
        headerMargin: EdgeInsets.only(top: 0, bottom: 5),
        onCalendarChanged: (DateTime date) {
          this.setState(() => {_headerTitle = formatTitle.format(date)});
        },
        weekendTextStyle: TextStyle(
          color: Colors.black,
        ),
        isScrollable: false,
        thisMonthDayBorderColor: Colors.grey,
        weekFormat: false,
        height: 400,
        selectedDateTime: _currentDate,
        selectedDayButtonColor: const Color(0xffCCE3F2),
        daysHaveCircularBorder: null,
        headerText: _headerTitle,
        leftButtonIcon: Icon(Icons.chevron_left),
        rightButtonIcon: Icon(Icons.chevron_right),
        headerTextStyle: TextStyle(fontSize: 12, color: Colors.black),
        showOnlyCurrentMonthDate: true,
        markedDateShowIcon: true,
        weekdayTextStyle: TextStyle(fontSize: 10, color: Colors.black),
        weekDayFormat: WeekdayFormat.narrow,
        markedDateIconBuilder: (event) {
          return event.icon;
        },
        todayTextStyle: TextStyle(color: Colors.black),
        todayButtonColor: Colors.transparent,
        markedDatesMap: _markedDateMap,
      ),
    );
  }
}
