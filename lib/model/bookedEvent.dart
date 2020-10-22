class BookedEvent {
  String date, endDate;

  int sessionId, isAvailable, isBooked, isCanceled, isClassSessionFull;

  BookedEvent(
      {this.date,
      this.endDate,
      this.sessionId,
      this.isBooked,
      this.isCanceled,
      this.isClassSessionFull,
      this.isAvailable});

  factory BookedEvent.fromJson(Map<String, dynamic> json) {
    return BookedEvent(
      date: json['EventSessionDate'],
      endDate: json['EndDateTime'],
      sessionId: json['EventSessionId'],
      isAvailable: json['IsAvailable'],
      isBooked: json['IsBooked'],
      isCanceled: json['IsCanceled'],
      isClassSessionFull: json['IsClassSessionFull'],
    );
  }
}
