import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/widget/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Set Widget to use Provider
    return Consumer<MedicationData>(
      builder: (context, medModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: Theme.of(context).backgroundColor,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: Navigator.of(context).pop),
          ),
          body: ListView(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(right: Config.yMargin(context, 2.6)),
                    child: FlatButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            child: DeleteDialog(),
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        label: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        )),
                  ),
                  //SizedBox(height: Config.yMargin(context, 3)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.xMargin(context, 5.33)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: Config.xMargin(context, 44),
                          child: Text(
                            'Chloroquine Injection',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: Config.textSize(context, 5.3),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              right: Config.xMargin(context, 5)),
                          child: Image.asset('images/injection.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Config.yMargin(context, 3)),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: Config.xMargin(context, 5.33),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Description',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: Config.textSize(context, 4.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Config.yMargin(context, 1.0)),
                            child: Text(
                              'Take a shot at st.charles hospital daily and remember to eat before leaving the house',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: Config.textSize(context, 4),
                              ),
                              //\n
                            ),
                          ),
                          SizedBox(height: Config.yMargin(context, 10)),
                          Text(
                            'Frequency',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: Config.textSize(context, 4.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Config.yMargin(context, 1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Once Daily',
                                      style: TextStyle(
                                        fontSize: Config.textSize(context, 4),
                                      ),
                                    ),
                                    Text(
                                      '8:00AM',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Config.textSize(context, 3.6),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Once Daily',
                                      style: TextStyle(
                                        fontSize: Config.textSize(context, 4),
                                      ),
                                    ),
                                    Text(
                                      '8:00AM',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Config.textSize(context, 3.6),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Config.yMargin(context, 10)),
                          Text(
                            'Length',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: Config.textSize(context, 4.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Config.yMargin(context, 1.0)),
                            child: Text(
                              '4 days left out of 30 days',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: Config.textSize(context, 4),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: Config.yMargin(context, 10)),

                  Padding(
                    padding:
                        EdgeInsets.only(bottom: Config.yMargin(context, 2.0)),
                    child: InkWell(
                      onTap: () {
                        medModel.isEditing = true;
                        Navigator.pushNamed(
                            context, RouteNames.addMedicationScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Config.xMargin(context, 3.55)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Config.yMargin(context, 1.28))),
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: Config.xMargin(context, 5.33),
                            right: Config.xMargin(context, 6)), //24,24,27
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.bold,
                            fontSize: Config.textSize(context, 4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
