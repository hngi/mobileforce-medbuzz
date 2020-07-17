import 'package:MedBuzz/core/database/medication_history.dart';
import 'package:MedBuzz/core/models/medication_history_model/medication_history.dart';
import 'package:MedBuzz/ui/app_theme/app_theme.dart';
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
            model.clearHistory();
          },
          icon: Icon(Icons.delete, color: Colors.red),
          label: Text("Clear History"),
        ),
        SizedBox(height: Config.yMargin(context, 3)),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: model.medicationHistory.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 100,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Theme.of(context).primaryColorLight,
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        height: 80,
                        width: 80,
                        child: Image.asset(medModel.images[
                            int.parse(model.medicationHistory[index].index)]),
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
                          Text(model.medicationHistory[index].drugName),
                          Row(
                            children: [
                              Text("Taken "),
                              Text(model.medicationHistory[index].frequency)
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Start:"),
                              Text(
                                DateFormat(' HH:mm:a').format(
                                    model.medicationHistory[index].startAt),
                              ),
                              SizedBox(width: 20),
                              Text("End:"),
                              Text(DateFormat(' HH:mm:a').format(
                                  model.medicationHistory[index].endAt)),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
            //I have successsfully downloaded the files, you can now close live share
          },
        ),
      ]),
    );
  }
}
