import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styret_app/domain/subTask.dart';
import 'package:flutter_styret_app/generated/l10n.dart';
import 'package:flutter_styret_app/utilites/awesomeIcons.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';
import 'package:image_picker/image_picker.dart';

//Input filed for short text, long text and numbers
Widget shortLongText(
    {BuildContext context,
    SubTask subTask,
    int maxLength = 100,
    TextEditingController controller}) {
  bool numbersOnly = false;
  if (subTask.type == 'number') numbersOnly = true;
  return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subTask.title,
            style: kSubTaskTitleTextStyle,
          ),
          Container(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: kSubTaskHintTextStyle,
                  textAlignVertical: TextAlignVertical.bottom,
                  maxLines: null,
                  controller: controller,
                  maxLength: maxLength,
                  keyboardType:
                      numbersOnly ? TextInputType.number : TextInputType.text,
                  inputFormatters: numbersOnly
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ]
                      : null,
                  decoration: InputDecoration(
                      counterText: '',
                      isCollapsed: true,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kAccentColor)),
                      hintText: subTask.standard != ''
                          ? subTask.standard
                          : subTask.title,
                      hintStyle: kSubTaskHintTextStyle),
                ),
              ),
              subTask.required
                  ? Text('*', style: kSubTaskTitleTextStyle)
                  : Container()
            ],
          ),
          Container(height: 5),
          Text(
            subTask.desc,
            style: kSubTaskHintTextStyle,
          )
        ],
      ));
}

//Date picker
class DatePicker extends StatefulWidget {
  final SubTask subTask;
  DatePicker(this.subTask);
  @override
  _DatePickerState createState() => _DatePickerState(subTask);
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  final SubTask subTask;

  _DatePickerState(this.subTask) : assert(subTask != null);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget dateWindow(DateTime date) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: kInactiveColor, width: 1),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.all(5),
      child: Text("${date.toLocal()}".split(' ')[0],
          style: kSubTaskTitleTextStyle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subTask.title + (subTask.required ? ' *' : ''),
              style: kSubTaskTitleTextStyle),
          Container(height: 5),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _selectDate(context);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AwesomeIcon(
                    icon: AwesomeIcons.calendarIcon,
                    color: kAccentColor,
                    fontFamily: 'fa-solid'),
                Container(width: 10),
                dateWindow(selectedDate)
              ],
            ),
          ),
          Container(height: 5),
          Text(subTask.desc, style: kSubTaskHintTextStyle)
        ],
      ),
    );
  }
}

//Yes/no question checkbox
class YesNoCheckBox extends StatefulWidget {
  final SubTask subTask;
  YesNoCheckBox(this.subTask);
  @override
  _YesNoCheckBoxState createState() => _YesNoCheckBoxState(subTask);
}

class _YesNoCheckBoxState extends State<YesNoCheckBox> {
  bool checked = false;
  final SubTask subTask;
  _YesNoCheckBoxState(this.subTask) : assert(subTask != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subTask.title + (subTask.required ? ' *' : ''),
                    style: kSubTaskTitleTextStyle),
                Text(subTask.desc, style: kSubTaskHintTextStyle)
              ],
            ),
          ),
          Checkbox(
              activeColor: kActiveColor,
              value: checked,
              onChanged: (val) {
                setState(() {
                  checked = val;
                });
              })
        ],
      ),
    );
  }
}

//Yes/no/don'tKnow picker
class TriplePicker extends StatefulWidget {
  final SubTask subTask;
  TriplePicker(this.subTask);
  @override
  _TriplePickerState createState() => _TriplePickerState(subTask);
}

class _TriplePickerState extends State<TriplePicker> {
  final SubTask subTask;
  List<String> items = ['Yes', 'No', "Don't know"];
  String value = "Don't know";
  _TriplePickerState(this.subTask) : assert(subTask != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(subTask.title + (subTask.required ? ' *' : ''),
                    style: kSubTaskTitleTextStyle),
              ),
              DropdownButton(
                value: value,
                onChanged: (String newValue) {
                  setState(() {
                    value = newValue;
                  });
                },
                iconSize: 0,
                style: kSubTaskTitleTextStyle,
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
          Text(subTask.desc, style: kSubTaskHintTextStyle)
        ],
      ),
    );
  }
}

//Multiple choise picker
class MultiChoise extends StatefulWidget {
  final SubTask subTask;
  MultiChoise(this.subTask);
  @override
  _MultiChoiseState createState() => _MultiChoiseState(subTask);
}

class _MultiChoiseState extends State<MultiChoise> {
  final SubTask subTask;
  String value = '';
  _MultiChoiseState(this.subTask) : assert(subTask != null) {
    value = subTask.options[0];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subTask.title + (subTask.required ? ' *' : ''),
              style: kSubTaskTitleTextStyle),
          DropdownButton(
            value: value,
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                value = newValue;
              });
            },
            icon: AwesomeIcon(
                icon: AwesomeIcons.dropDownIcon, color: kAccentColor),
            style: kSubTaskTitleTextStyle,
            items:
                subTask.options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Text(subTask.desc, style: kSubTaskHintTextStyle)
        ],
      ),
    );
  }
}

//Image picker
class ImagePickerBlock extends StatefulWidget {
  final SubTask subTask;
  ImagePickerBlock(this.subTask);
  @override
  _ImagePickerBlockState createState() => _ImagePickerBlockState(subTask);
}

class _ImagePickerBlockState extends State<ImagePickerBlock> {
  File _image;
  ImagePicker picker = ImagePicker();
  SubTask subTask;

  _ImagePickerBlockState(this.subTask) : assert(subTask != null);

  Future<void> _imgFromCamera() async {
    PickedFile pickedFile;

    switch (await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(S.of(context).kPictureDialogTitle),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
                child: Text(S.of(context).kTakePicture),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
                child: Text(S.of(context).kUseGallery),
              ),
            ],
          );
        })) {
      case ImageSource.camera:
        {
          pickedFile = await picker.getImage(source: ImageSource.camera);
        }
        break;
      case ImageSource.gallery:
        {
          pickedFile = await picker.getImage(source: ImageSource.gallery);
        }
        break;
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(subTask.title + (subTask.required ? ' *' : ''),
                    style: kSubTaskTitleTextStyle),
              ),
              GestureDetector(
                onTap: () {
                  _imgFromCamera();
                },
                behavior: HitTestBehavior.translucent,
                child: AwesomeIcon(
                    icon: AwesomeIcons.pictureIcon, color: kAccentColor),
              )
            ],
          ),
          Text(subTask.desc, style: kSubTaskHintTextStyle),
          _image == null ? Text('No image') : Image.file(_image, height: 150)
        ],
      ),
    );
  }
}
