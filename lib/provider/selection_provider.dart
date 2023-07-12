import 'package:cruv_assignment/models/seat.dart';
import 'package:flutter/cupertino.dart';

class SeatSelectedProvider with ChangeNotifier {
  final Map<String, List<Seat>> _coachMap = getMap(1);

  int selectedSeatNumber = 1;

  Map get coachMap => _coachMap;
  setSeatAsSelected(int coachNumber, int seatNumber) {
   
    _coachMap['Coach $coachNumber']![seatNumber].highlight = true;
    selectedSeatNumber = seatNumber;
    notifyListeners();
  }
}
