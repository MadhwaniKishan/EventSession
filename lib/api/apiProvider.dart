import 'dart:convert';
import 'dart:io';

import 'package:event_session/model/bookedEventsModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier {
  BookedEvents bookedEvents = new BookedEvents();

  Future<Null> getData() async {
    var responseJson;
    try {
      final response = await http.get(
        "http://developer.kuwaiterp.com/ERPMobileAPI/api/event/GetBookedEventSessionList/17/64474/10192",
      );
      responseJson = _response(response);
    } on SocketException {
      throw new Exception('No Internet Connection');
    }
    bookedEvents = BookedEvents.fromJson(responseJson);
    notifyListeners();
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw new Exception('Bad request');
      case 401:
      case 403:
      case 500:

      default:
        throw new Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  BookedEvents get getBookedEventsObject => bookedEvents;
}
