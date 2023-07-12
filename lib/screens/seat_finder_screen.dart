import 'package:cruv_assignment/provider/selection_provider.dart';
import 'package:cruv_assignment/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/seats.dart';
import '../widgets/down_seats.dart';

class SeatFinderHome extends StatefulWidget {
  SeatFinderHome({super.key});

  @override
  State<SeatFinderHome> createState() => _SeatFinderHomeState();
}

class _SeatFinderHomeState extends State<SeatFinderHome> {
  final TextEditingController seatNumberController = TextEditingController();

  final SearchingBar searchBar = SearchingBar();

  final itemKeys = [GlobalKey(), GlobalKey(), GlobalKey()];

  bool isInit = false;

  getCoach(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<SeatSelectedProvider>(builder: (context, value, child) {
      if (isInit) {
        Scrollable.ensureVisible(
            itemKeys[value.selectedCoachNumber - 1].currentContext!);
      }
      isInit = true;
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.coachMap.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              key: itemKeys[index],
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height / 50,
                ),
                getSection(0, value.coachMap['Coach ${index + 1}']),
                getSection(1, value.coachMap['Coach ${index + 1}']),
                getSection(2, value.coachMap['Coach ${index + 1}']),
                getSection(3, value.coachMap['Coach ${index + 1}']),
                SizedBox(
                  height: height / 60,
                ),
              ],
            );
          });
    });
  }

  getSection(int number, List seats) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SeatWidget(seat: seats[8 * number]),
                SeatWidget(seat: seats[8 * number + 1]),
                SeatWidget(seat: seats[8 * number + 2])
              ],
            ),
            SeatWidget(seat: seats[8 * number + 6])
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SeatWidgetInverted(seat: seats[8 * number + 3]),
                SeatWidgetInverted(seat: seats[8 * number + 4]),
                SeatWidgetInverted(seat: seats[8 * number + 5])
              ],
            ),
            SeatWidgetInverted(seat: seats[8 * number + 7])
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seat Finder',
          style: GoogleFonts.lato(fontSize: 40),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              searchBar,
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              getCoach(context),
            ],
          ),
        ),
      ),
    );
  }
}
