// import 'dart:developer';

// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   double _percentage = 50.0;
//   double _amount = 1000.0;
//   int _numberOfClients = 5;
//   List<double> _clientAmounts = [];
//   List<double> _new = [];

//   @override
//   void initState() {
//     super.initState();
//     _distributeAmount();
//   }

//   void _distributeAmount() {
//     double totalPercentage = _percentage * _numberOfClients;
//     double amountPerPercentage = _amount / 100;
//     double amountPerClient =
//         (totalPercentage * amountPerPercentage) / _numberOfClients;
//     double newAmount = (_amount - amountPerClient);
//     log(newAmount.toString());
//     double newClient=();
//     _clientAmounts =
//         List.generate(_numberOfClients, (index) => amountPerClient);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Slider Example"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Percentage: ${_percentage.toStringAsFixed(1)}%",
//               style: TextStyle(fontSize: 20.0),
//             ),
//             Slider(
//               value: _percentage,
//               min: 0.0,
//               max: 100.0,
//               divisions: 100,
//               label: _percentage.round().toString(),
//               onChanged: (value) {
//                 setState(() {
//                   _percentage = value;
//                   _distributeAmount();
//                 });
//               },
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               "Amount: ${_amount.toStringAsFixed(2)}",
//               style: TextStyle(fontSize: 20.0),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               "Number of Clients: $_numberOfClients",
//               style: TextStyle(fontSize: 20.0),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               "Amount per Client: ${(_amount / _numberOfClients).toStringAsFixed(2)}",
//               style: TextStyle(fontSize: 20.0),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               "Client Amounts:",
//               style: TextStyle(fontSize: 20.0),
//             ),
//             Column(
//               children: _clientAmounts.map((amount) {
//                 return Text(amount.toStringAsFixed(2));
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
