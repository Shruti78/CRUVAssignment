import 'package:flutter/material.dart';
import '../models/seat.dart';
import '../utils/colors.dart';

class SeatWidgetInverted extends StatefulWidget {
  SeatWidgetInverted({super.key, required this.seat});
  Seat seat;

  @override
  State<SeatWidgetInverted> createState() => _SeatWidgetInvertedState();
}

class _SeatWidgetInvertedState extends State<SeatWidgetInverted> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      Container(
        height: MediaQuery.of(context).size.height / 30,
        width: MediaQuery.of(context).size.height / 15,
        decoration: const BoxDecoration(
          color: kAccent2,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.height / 20,
            decoration: BoxDecoration(
                color: widget.seat.highlight
                    ? Color.fromARGB(255, 84, 196, 233)
                    : kAccent1,
                borderRadius: BorderRadius.circular(2.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.seat.number}',
                  style: kTextStyleDefault.copyWith(color: kblue),
                ),
                Text(
                  widget.seat.label,
                  style: kTextStyleDefault.copyWith(
                      color: kblue,
                      fontSize: widget.seat.label.length > 7 ? 6 : 9),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      )
    ]);
  }
}
