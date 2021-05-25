import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/event.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/models/taskModel.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';
import 'package:flutter_styret_app/widgets/popupMenu.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/subTasksWidgets.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;
  final Property property;

  EventDetailsPage(this.property, this.event);

  @override
  _EventDetailsPageState createState() =>
      _EventDetailsPageState(property, event);
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final Event event;
  final Property property;

  _EventDetailsPageState(this.property, this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: kAccentColor,
        title: Text(property.name + " " + property.address,
            style: kAppBarTitleTextStyle),
        actions: [
          popUpMenu(context, () {
            setState(() {});
          }),
          Container(width: 20)
        ],
      ),
      body: ScopedModel<TaskModel>(
        model: taskModel,
        child: ScopedModelDescendant<TaskModel>(
          builder: (context, child, model) {
            return FutureBuilder(
              future: taskModel.api.getEvent(event),
              builder: (context, snapshot) {
                Widget content;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  content = Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kAccentColor),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  content = SingleChildScrollView(
                    child: Column(
                      children: [
                        shortLongText(
                            context: context, subTask: event.subTasks[0]),
                        shortLongText(
                            context: context, subTask: event.subTasks[1]),
                        shortLongText(
                            context: context, subTask: event.subTasks[2]),
                        DatePicker(event.subTasks[3]),
                        YesNoCheckBox(event.subTasks[4]),
                        TriplePicker(event.subTasks[5]),
                        MultiChoise(event.subTasks[6]),
                        ImagePickerBlock(event.subTasks[7]),
                        Container(height: 50)
                      ],
                    ),
                  );
                }
                return content;
              },
            );
          },
        ),
      ),
    );
  }
}
