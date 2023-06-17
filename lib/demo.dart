import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? datePicked;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Column(children: [
              const Text("open picker dialog"),
              Text(datePicked?.month.toString() ?? "MN"),
            ]),
            onPressed: () async {
              datePicked = await DatePicker.showSimpleDatePicker(
                context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1960),
                lastDate: DateTime(2023),
                dateFormat: "dd-MMMM-yyyy",
                locale: DateTimePickerLocale.en_us,
                looping: true,
              );
              setState(() {});
              final snackBar = SnackBar(
                  content: Text(
                "Date Picked $datePicked",
                style: const TextStyle(color: Colors.red),
              ));
              if (!mounted) {
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          // ElevatedButton(
          //   child: Text("Show picker widget"),
          //   onPressed: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (_) => WidgetPage()));
          //   },
          // ),
        ],
      ),
    );
  }
}

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.grey[900]!,
              Colors.black,
            ],
            stops: const [0.7, 1.0],
          )),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DatePickerWidget(
                    looping: false, // default is not looping
                    firstDate: DateTime.now(), //DateTime(1960),
                    //  lastDate: DateTime(2002, 1, 1),
//              initialDate: DateTime.now(),// DateTime(1994),
                    dateFormat:
                        // "MM-dd(E)",
                        "dd/MMMM/yyyy",
                    // locale: DatePicker.localeFromString('th'),
                    onChange: (DateTime newDate, _) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                      debugPrint(_selectedDate.toString());
                    },
                    pickerTheme: const DateTimePickerTheme(
                      backgroundColor: Colors.transparent,
                      itemTextStyle:
                          TextStyle(color: Colors.white, fontSize: 19),
                      dividerColor: Colors.white,
                    ),
                  ),
                ),
                Text("${_selectedDate ?? ''}"),
              ],
            ),
          ),
        ),
      ),
    );
    //var locale = "zh";
    // return SafeArea(
    //   child: Scaffold(
    //     body: Center(
    //       child: DatePickerWidget(
    //         locale: //locale == 'zh'
    //             DateTimePickerLocale.zh_cn
    //             //  DateTimePickerLocale.en_us
    //         ,
    //         lastDate: DateTime.now(),
    //         // dateFormat: "yyyy : MMM : dd",
    //         // dateFormat: 'yyyy MMMM dd',
    //         onChange: (DateTime newDate, _) {
    //           setState(() {
    //             var dob = newDate.toString();
    //             print(dob);
    //           });
    //         },
    //         pickerTheme: DateTimePickerTheme(
    //           backgroundColor: Colors.transparent,
    //           dividerColor: const Color(0xffe3e3e3),
    //           itemTextStyle: TextStyle(
    //             fontFamily: 'NotoSansTC',
    //             fontSize: 18,
    //             fontWeight: FontWeight.w500,
    //             color: Theme.of(context).primaryColor,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
