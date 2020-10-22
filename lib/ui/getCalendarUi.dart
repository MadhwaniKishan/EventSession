import 'package:event_session/api/apiProvider.dart';
import 'package:event_session/model/bookedEventsModel.dart';
import 'package:event_session/ui/calendarWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BookedEvents bookedEvents =
        Provider.of<ApiProvider>(context).getBookedEventsObject;
    return bookedEvents.bookedEvents != null
        ? GetCalendarWidget(bookedEvents)
        : Center(child: CircularProgressIndicator());
  }
}
