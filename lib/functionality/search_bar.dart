import 'package:cruv_assignment/provider/selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

class SearchingBar extends StatelessWidget {
  SearchingBar({Key? key}) : super(key: key);
  final TextEditingController _seatNumberController = TextEditingController();
  final ValueNotifier<String> _selectedOption =
      ValueNotifier<String>('1');
  final ValueNotifier<bool> _errorVisible = ValueNotifier<bool>(false);
  final List<String> _options = ['1','2','3'];
  double borderRadius = 50;
  String getCoach() {
    return _selectedOption.value;
  }

  String getSeatNumber() {
    return _seatNumberController.text;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SeatSelectedProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kAccent1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: kAccent1,
                    ),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: ValueListenableBuilder(
                      valueListenable: _selectedOption,
                      builder: (context, value, child) {
                        return DropdownButton(
                          iconEnabledColor: kAccent1,
                          iconDisabledColor: kAccent1,
                          value: _selectedOption.value,
                          onChanged: (newValue) {
                            //TODO: add set state
                            _selectedOption.value = newValue.toString();
                          },
                          items: _options.map((option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(
                                option,
                                style:
                                    kTextStyleDefault.copyWith(color: kAccent2),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ),

              ),
              
              Expanded(
                child: TextField(
                  controller: _seatNumberController,
                  style: kTextStyleDefault,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter Seat Number...',
                    border: InputBorder.none,
                    hintStyle: kTextStyleDefault,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
              Material(
                color: kAccent1,
                child: InkWell(
                  onTap: () {
                    if (_seatNumberController.text.isEmpty ||
                        int.parse(_seatNumberController.text) < 1 ||
                        int.parse(_seatNumberController.text) > 32) {
                      _errorVisible.value = true;
                    } else {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _errorVisible.value = false;
                      provider.setSeatAsSelected(
                          int.parse(_selectedOption
                              .value[_selectedOption.value.length - 1]),
                          int.parse(_seatNumberController.text) - 1);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: Text('FIND'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
            valueListenable: _errorVisible,
            builder: (context, value, child) {
              return Visibility(
                  visible: _errorVisible.value,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Please enter a valid number between 1 and 32!',
                      style: kTextStyleDefault,
                    ),
                  ));
            })
      ],
    );
  }
}
