import 'bookedEvent.dart';

class BookedEvents {
  List<BookedEvent> bookedEvents = new List();

  BookedEvents({this.bookedEvents});

  factory BookedEvents.fromJson(Map<String, dynamic> json) {
    List<BookedEvent> bookedEvents = (json['Data'] as List)
        .map((article) => BookedEvent.fromJson(article))
        .toList();
    return BookedEvents(
      bookedEvents: bookedEvents,
    );
  }
}
