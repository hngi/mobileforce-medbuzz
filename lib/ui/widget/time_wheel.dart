import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef void StringCallback(String val);

class TimeWheel extends StatefulWidget {
  final StringCallback updateTimeChanged;
  TimeWheel({Key key, this.updateTimeChanged}) : super(key: key);

  @override
  _TimeWheelState createState() => _TimeWheelState();
}

class _TimeWheelState extends State<TimeWheel> {
  // these are individual controllers to control the position for the seconds, hour and minute portions.
  FixedExtentScrollController _timeController;
  FixedExtentScrollController _hourController;
  FixedExtentScrollController _minController;

  //generates 12 integers for 12 hour time format
  List _hours = List<int>.generate(13, (index) => index);
  //generates 00-59(60 integers) for minute portion of the wheel;
  List _mins = List<int>.generate(60, (index) => index);
  List _time = ['AM', 'PM'];

  //initialises the values of the selected hour, min and time of day
  String _selectedHour = '00';
  String _selectedMin = '00';
  String _selectedTimer = 'AM';
  String selectedTime;

  bool is24HourFormat = true;

  //gives values of today; the current hour, min and time of day
  DateTime _now = DateTime.now();
  get initHour => _now.hour;
  get initMin => _now.minute;
  get initTime => DateFormat('a').format(_now);

  @override
  void initState() {
    super.initState();
    //converts to 12 hour format
    int hour = initHour > 12 ? initHour - 12 : initHour;

    //initialise the time to the current time for 'today'
    _selectedHour = hour.toString().padLeft(2, '0');
    _selectedMin = initMin.toString().padLeft(2, '0');
    _selectedTimer = initTime.toString();

    //final output is given in 24 hour format
    //hourValue gets the value of the currently initalised hour to a 24 hour format
    String hourValue = _selectedTimer == 'PM'
        ? (int.parse(_selectedHour) + 12).toString().padLeft(2, '0')
        : _selectedHour;
    //then we give selectedTime the string value of the hourValue and selectedMins
    selectedTime = "$hourValue:$_selectedMin:00";

    //this sends the initialised selected time string to the parent widget
    widget.updateTimeChanged(selectedTime);

    //this scrolls the controllers to their respective currently initialised values
    _hourController = FixedExtentScrollController(initialItem: hour);
    _minController = FixedExtentScrollController(initialItem: initMin);
    _timeController =
        FixedExtentScrollController(initialItem: _time.indexOf(initTime));
  }

  //runs each time hour, min and time of day values are updated on the wheel to send value to the parent widget
  void _getTime() {
    //adds 12 if the selected time of day is PM since we return 24 hour format
    String hourValue = _selectedTimer == 'PM'
        ? (int.parse(_selectedHour) + 12).toString().padLeft(2, '0')
        : _selectedHour;
    //changes the value of selectedTime string
    setState(() {
      selectedTime = "$hourValue:$_selectedMin:00";
    });

    //sends value to parent widget
    widget.updateTimeChanged(selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: Config.xMargin(context, 12),
          height: Config.yMargin(context, 7),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: Config.xMargin(context, 0.5),
          ))),
          child: ListWheelScrollView(
            controller: _hourController,
            itemExtent: Config.xMargin(context, 15),
            overAndUnderCenterOpacity: 0,
            renderChildrenOutsideViewport: false,
            onSelectedItemChanged: (value) => {
              //since we use 12 hour format internally, on PM time of day, 00 can't be PM and 12 can't be AM
              if (value == 0 && _selectedTimer == 'PM')
                {
                  //if the user scrolls to 00 and the time of day is PM, we automatically switch to AM
                  setState(() => {
                        _timeController.jumpToItem(0),
                      })
                }
              else if (value == 12 && _selectedTimer == 'AM')
                {
                  //if the user scrolls to 12 in the hour value and the time of day is AM, we automatically scroll the time of day value to PM
                  setState(() => {
                        _timeController.jumpToItem(1),
                      })
                },
              //depending on whatever the outcome we then set the selectedHour to the selected value, pading it to a 2 digit string using padLeft
              setState(() => {
                    _selectedHour =
                        _hours[_hours.indexOf(value)].toString().padLeft(2, '0')
                  }),
              //then we update the selectedTime value
              _getTime()
              // }
            },
            useMagnifier: true,
            children: _hours
                .map((e) => Container(
                      alignment: Alignment.center,
                      child: Text(
                        _hours[_hours.indexOf(e)].toString().padLeft(2, '0'),
                        style: TextStyle(
                            fontSize: Config.textSize(context, 8),
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ))
                .toList(),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: Config.xMargin(context, 3)),
          child: Text(
            ':',
            style: TextStyle(
                fontSize: Config.textSize(context, 8),
                color: Theme.of(context).primaryColorDark.withOpacity(0.3)),
          ),
        ),
        Container(
          width: Config.xMargin(context, 12),
          height: Config.yMargin(context, 7),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: Config.xMargin(context, 0.5),
          ))),
          child: ListWheelScrollView(
            controller: _minController,
            itemExtent: Config.xMargin(context, 15),
            overAndUnderCenterOpacity: 0,
            renderChildrenOutsideViewport: false,
            onSelectedItemChanged: (value) => {
              setState(() => _selectedMin = value.toString().padLeft(2, '0')),
              _getTime()
            },
            useMagnifier: true,
            children: _mins
                .map((e) => Container(
                      alignment: Alignment.center,
                      child: Text(
                        _mins[_mins.indexOf(e)].toString().padLeft(2, '0'),
                        style: TextStyle(
                            fontSize: Config.textSize(context, 8),
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ))
                .toList(),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: Config.xMargin(context, 3)),
          child: Text(
            ':',
            style: TextStyle(
                fontSize: Config.textSize(context, 8),
                color: Theme.of(context).primaryColorDark.withOpacity(0.3)),
          ),
        ),
        Container(
          width: Config.xMargin(context, 15),
          height: Config.yMargin(context, 7),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: Config.xMargin(context, 0.5),
          ))),
          child: ListWheelScrollView(
            itemExtent: Config.xMargin(context, 15),
            controller: _timeController,
            // squeeze: 0.4,
            overAndUnderCenterOpacity: 0,
            renderChildrenOutsideViewport: false,
            onSelectedItemChanged: (value) => {
              if (_hourController.selectedItem == 0 && _time[value] == 'PM')
                {
                  //just like with the hour portion; if the selected time of day value is PM and the currently selected hour value is 00 we scroll the hour to 01
                  setState(() => {
                        _hourController.jumpToItem(1),
                        _selectedTimer = _time[value - 1]
                      })
                }
              else if (_hourController.selectedItem == 12 &&
                  _time[value] == 'AM')
                {
                  //if the hour is 12 and the selected time of day is AM, we scroll the hour to 00 and the time of day to AM
                  setState(() => {
                        _hourController.jumpToItem(0),
                        _selectedTimer = _time[value + 1]
                      })
                }
              else
                {
                  setState(() => _selectedTimer = _time[value]),
                },
              _getTime()
            },
            useMagnifier: true,
            children: _time
                .map((e) => Container(
                      alignment: Alignment.center,
                      child: Text(
                        _time[_time.indexOf(e)],
                        style: TextStyle(
                            fontSize: Config.textSize(context, 8),
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
