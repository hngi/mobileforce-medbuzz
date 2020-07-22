import 'package:MedBuzz/core/database/medication_history.dart';
import 'package:MedBuzz/core/models/medication_history_model/medication_history.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/route_names.dart';
import '../../../core/database/medication_data.dart';
import '../../size_config/config.dart';

class MedicationHistoryPage extends StatefulWidget {
  final double height;
  final double width;
  final String drugName;
  final String drugType;
  final String time;
  final int dosage;
  MedicationHistoryPage(
      {this.height,
      this.width,
      this.drugName,
      this.drugType,
      this.time,
      this.dosage});
  @override
  _MedicationHistoryPageState createState() => _MedicationHistoryPageState();
}

class _MedicationHistoryPageState extends State<MedicationHistoryPage> {
  @override
  Widget build(BuildContext context) {
    //fetch data from the DB to listen to model
    Provider.of<MedicationHistoryData>(context).getMedicationHistory();
    //set model
    var model = Provider.of<MedicationHistoryData>(context);
    var medModel = Provider.of<MedicationData>(context);
    MedicationHistory medicationHistory;
    model.getMedicationHistory();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model.updateAvailableMedicationHistory(model.medicationHistory);
    });
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          "Medication History",
          style: Theme.of(context).textTheme.headline6,
          textScaleFactor: 1.2,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popAndPushNamed(context, RouteNames.medicationScreen);
            }),
        // actions: [
        //   FlatButton.icon(
        //     onPressed: () {
        //       model.clearHistory();
        //     },
        //     icon: Icon(Icons.delete, color: Colors.red),
        //     label: Text("Clear History"),
        //   )
        // ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        FlatButton.icon(
          onPressed: () {
            //Delete Box
            showDialog(context: context, child: DeleteBox(context: context));
          },
          icon: Icon(Icons.delete, color: Colors.red),
          label: Text("Clear History"),
        ),
        SizedBox(height: Config.yMargin(context, 3)),
        Visibility(
          visible: model.medicationHistory.isEmpty,
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: Config.yMargin(context, 20.0)),
            child: Center(
              child: Container(
                child: Text('History is Empty'),
              ),
            ),
          ),
        ),
        for (var medicationHistory in model.medicationHistory)
          Container(
            height: 100,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Theme.of(context).primaryColorLight,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Image.asset(
                          medModel.images[int.parse(medicationHistory.index)]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(medicationHistory.drugName),
                        Row(
                          children: [
                            Text("Taken "),
                            Text(medicationHistory.frequency)
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Start:"),
                            Text(
                              DateFormat(' HH:mm:a')
                                  .format(medicationHistory.startAt),
                            ),
                            SizedBox(width: 20),
                            Text("End:"),
                            Text(DateFormat(' HH:mm:a')
                                .format(medicationHistory.endAt)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        //I have successsfully downloaded the files, you can now close live share
      ]),
    );
  }
}

class DeleteBox extends StatefulWidget {
  BuildContext context;

  DeleteBox({this.context});

  @override
  _DeleteBoxState createState() => _DeleteBoxState();
}

class _DeleteBoxState extends State<DeleteBox> {
  @override
  Widget build(context) {
    final medModel = Provider.of<MedicationData>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Config.xMargin(context, 4.0)),
      ),
      child: Container(
        height: Config.yMargin(context, 20),
        width: Config.xMargin(context, 150.0),
        //width: Config.xMargin(context, 50),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 23.0, bottom: 20.0),
                child: Text(
                  'Delete All History?',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Config.yMargin(context, 6.0),
                    width: Config.xMargin(context, 30.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      color: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Config.xMargin(context, 2.0)),
                        side: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.4),
                            width: 1.5),
                      ),
                    ),
                  ),
                  Container(
                    height: Config.yMargin(context, 6.0),
                    width: Config.xMargin(context, 30.0),
                    child: FlatButton(
                      onPressed: () {
                        //Delete all History here
                        var model = Provider.of<MedicationHistoryData>(context);
                        model.clearHistory();
                        Navigator.of(context).pop();

                        Flushbar(
                          icon: Icon(
                            Icons.check_circle,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.green,
                          message: "Successfully Cleared all History",
                          duration: Duration(seconds: 3),
                        )..show(context);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      color: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Config.xMargin(context, 2.0)),
                        side: BorderSide(
                            color: Theme.of(context).hintColor.withOpacity(.4),
                            width: 1.5),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
