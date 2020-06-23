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
  FixedExtentScrollController _timeController;
  FixedExtentScrollController _hourController;
  FixedExtentScrollController _minController;

  List _hours = List<int>.generate(13, (index) => index);
  List _mins = List<int>.generate(60, (index) => index);
  List _time = ['AM', 'PM'];

  String _selectedHour = '00';
  String _selectedMin = '00';
  String _selectedTimer = 'AM';
  String selectedTime;

  bool is24HourFormat = true;
  DateTime _now = DateTime.now();
  get initHour => _now.hour;
  get initMin => _now.minute;
  get initTime => DateFormat('a').format(_now);

  @override
  void initState() {
    super.initState();
    int hour = initHour > 12 ? initHour - 12 : initHour;
    _selectedHour = hour.toString().padLeft(2, '0');
    _selectedMin = initMin.toString().padLeft(2, '0');
    _selectedTimer = initTime.toString();
    String hourValue = _selectedTimer == 'PM'
        ? (int.parse(_selectedHour) + 12).toString().padLeft(2, '0')
        : _selectedHour;
    selectedTime = "$hourValue:$_selectedMin:00";
    widget.updateTimeChanged(selectedTime);

    _hourController = FixedExtentScrollController(initialItem: hour);
    _minController = FixedExtentScrollController(initialItem: initMin);
    _timeController =
        FixedExtentScrollController(initialItem: _time.indexOf(initTime));
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   widget.updateTimeChanged(selectedTime);
  // }

  void _getTime() {
    String hourValue = _selectedTimer == 'PM'
        ? (int.parse(_selectedHour) + 12).toString().padLeft(2, '0')
        : _selectedHour;
    setState(() {
      selectedTime = "$hourValue:$_selectedMin:00";
    });
    widget.updateTimeChanged(selectedTime);
    // print(selectedTime);
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
              if (value == 0 && _selectedTimer == 'PM')
                {
                  setState(() => {
                        _timeController.jumpToItem(0),
                      })
                }
              else if (value == 12 && _selectedTimer == 'AM')
                {
                  setState(() => {
                        _timeController.jumpToItem(1),
                      })
                },
              setState(() => {
                    _selectedHour =
                        _hours[_hours.indexOf(value)].toString().padLeft(2, '0')
                  }),
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
                  setState(() => {
                        _hourController.jumpToItem(1),
                        _selectedTimer = _time[value - 1]
                      })
                }
              else if (_hourController.selectedItem == 12 &&
                  _time[value] == 'AM')
                {
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
