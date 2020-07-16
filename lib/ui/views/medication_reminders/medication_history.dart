import 'package:MedBuzz/core/database/medication_history.dart';
import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    model.getMedicationHistory();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      model.updateAvailableMedicationHistory(model.medicationHistory);
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appThemeLight.backgroundColor,
        title: Text(
          "Medication History",
          style: appThemeLight.textTheme.headline6,
          textScaleFactor: 1.2,
        ),
      ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: model.medicationHistory.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12),
                    decoration: new BoxDecoration(
                      border: new Border(
                        right: new BorderSide(width: 1.0),
                      ),
                    ),
                    child: Icon(Icons.autorenew, color: Colors.white),
                  ),
                  title: Text(
                    model.medicationHistory[index].drugName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(Icons.linear_scale, color: Colors.yellowAccent),
                      Text(model.medicationHistory[index].drugType)
                    ],
                  ),
                ),
              ),
            );
            //I have successsfully downloaded the files, you can now close live share
          },
        ),
      ),
    );
  }

  final makeCard = Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      child: makeListTile,
    ),
  );
}

final makeListTile = ListTile(
  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  leading: Container(
    padding: EdgeInsets.only(right: 12),
    decoration: new BoxDecoration(
      border: new Border(
        right: new BorderSide(width: 1.0),
      ),
    ),
    child: Icon(Icons.autorenew, color: Colors.white),
  ),
  title: Text(
    "Drug Name",
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
  subtitle: Row(
    children: <Widget>[
      Icon(Icons.linear_scale, color: Colors.yellowAccent),
      Text(" Drug Time")
    ],
  ),
);
