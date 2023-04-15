// // ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:share_plus/share_plus.dart';
// import '../../Cbackgroung.dart';
// import '../../utils/color.dart';
// import '../../utils/globalText.dart';
// import 'General/forbidden_words.dart';

// class AddYoureOwn extends StatefulWidget {
//   const AddYoureOwn({super.key});

//   @override
//   State<AddYoureOwn> createState() => _AddYoureOwnState();
// }

// class Forbin {
//   String? name;
//   Forbin({required this.name});
// }

// class _AddYoureOwnState extends State<AddYoureOwn> {
//   List<bool> isLike = [false, false];

//   List<Forbin> words = List.empty(growable: true);
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return CommonBackground(
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             dialog();
//           },
//           backgroundColor: AppColors.black,
//           child: Icon(
//             Icons.add,
//             size: 40,
//           ),
//         ),
//         backgroundColor: AppColors.transparent,
//         body: Padding(
//           padding: EdgeInsets.only(
//             left: size.width * 0.045,
//             right: size.width * 0.045,
//           ),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: size.height * 0.08),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Icon(
//                         Icons.arrow_back_ios,
//                         color: AppColors.black,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: size.width * 0.05),
//                       child: GlobalText(
//                         'Added'.tr,
//                         color: AppColors.black,
//                         fontSize: 29,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     words.isNotEmpty
//                         ? Icon(
//                             Icons.search,
//                             size: size.height * 0.038,
//                           )
//                         : SizedBox(
//                             width: size.width * 0.1,
//                           ),
//                   ],
//                 ),
//               ),
//               words.isNotEmpty
//                   ? Column(
//                       children: [
//                         Container(
//                           height: size.height * 0.85,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: words.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: EdgeInsets.only(
//                                   bottom: size.height * 0.01,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     GlobalText(
//                                       "Fri, 18 November 2022".tr,
//                                       fontSize: 15,
//                                     ),
//                                     SizedBox(
//                                       height: size.height * 0.02,
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                         left: size.width * 0.035,
//                                       ),
//                                       child: Container(
//                                         height: size.height * 0.06,
//                                         decoration: BoxDecoration(
//                                           color: AppColors.whiteB,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                               color: Colors.grey,
//                                               blurRadius: 10.0,
//                                             ),
//                                           ],
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                             left: size.width * 0.02,
//                                             right: size.width * 0.02,
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 words[index].name.toString(),
//                                                 style: TextStyle(
//                                                   fontSize: size.height * 0.02,
//                                                   color: AppColors.black,
//                                                 ),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   GestureDetector(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         isLike[index] =
//                                                             !isLike[index];
//                                                       });
//                                                     },
//                                                     child: Icon(
//                                                       !isLike[index]
//                                                           ? Icons
//                                                               .favorite_border
//                                                           : Icons.favorite,
//                                                       color: !isLike[index]
//                                                           ? AppColors.black
//                                                           : AppColors.red,
//                                                       size: 30,
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: size.width * 0.02,
//                                                   ),
//                                                   Icon(
//                                                     Icons.bookmark_border,
//                                                     size: 30,
//                                                   ),
//                                                   SizedBox(
//                                                     width: size.width * 0.02,
//                                                   ),
//                                                   GestureDetector(
//                                                     onTap: () {
//                                                       Share.share(
//                                                           'Helloo Hru?');
//                                                     },
//                                                     child: Icon(
//                                                       Icons.ios_share,
//                                                       size: 30,
//                                                     ),
//                                                   ),
//                                                   PopupMenuButton(
//                                                     icon: Icon(
//                                                       Icons.more_vert,
//                                                       size: 30,
//                                                     ),
//                                                     padding: EdgeInsets.zero,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               10),
//                                                     ),
//                                                     itemBuilder: (context) => [
//                                                       PopupMenuItem(
//                                                         onTap: () {
//                                                           // dialog();
//                                                           // print("object");
//                                                         },
//                                                         child: Row(
//                                                           children: [
//                                                             Icon(
//                                                               Icons
//                                                                   .border_color,
//                                                             ),
//                                                             SizedBox(
//                                                               width: 10,
//                                                             ),
//                                                             Text(
//                                                               "Edit".tr,
//                                                               style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontSize: 15,
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       PopupMenuItem(
//                                                         child: Row(
//                                                           children: [
//                                                             Icon(
//                                                               Icons.delete,
//                                                             ),
//                                                             SizedBox(
//                                                               width: 10,
//                                                             ),
//                                                             Text(
//                                                               "Remove".tr,
//                                                               style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontSize: 15,
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: size.height * 0.045,
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   : Padding(
//                       padding: EdgeInsets.only(top: size.height * 0.32),
//                       child: Column(
//                         // mainAxisAlignment: MainAxisAlignment.center,

//                         children: [
//                           GlobalText(
//                             "You haven't added".tr,
//                             color: AppColors.black,
//                             fontSize: 29,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           GlobalText(
//                             "anything yet.".tr,
//                             color: AppColors.black,
//                             fontSize: 29,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ],
//                       ),
//                     ),
//               // SizedBox(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future dialog() {
//     final height = MediaQuery.of(context).size.height;
//     final Width = MediaQuery.of(context).size.width;
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         icon: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Center(
//               child: Container(
//                 height: 70,
//                 width: 70,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(
//                       "Affirmation_assets/pen.png",
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         title: Column(
//           children: [
//             Center(
//               child: Text(
//                 "Add a new affirmation".tr,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.black,
//                   fontFamily: 'Walsheim',
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             Column(
//               // ignore: prefer_const_literals_to_create_immutables
//               children: [
//                 Text(
//                   "Write and share your own".tr,
//                   style: TextStyle(
//                     color: AppColors.black,
//                     fontFamily: 'Walsheim',
//                     fontSize: 22,
//                   ),
//                 ),
//                 Text(
//                   "affirmations. These will only".tr,
//                   style: TextStyle(
//                     color: AppColors.black,
//                     fontFamily: 'Walsheim',
//                     fontSize: 22,
//                   ),
//                 ),
//                 Text(
//                   "be visible to you.".tr,
//                   style: TextStyle(
//                     color: AppColors.black,
//                     fontFamily: 'Walsheim',
//                     fontSize: 22,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         // content:
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 50,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: AppColors.gray,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: Width * 0.03,
//                 ),
//                 child: TextField(
//                   controller: forbidWord,
//                   cursorHeight: 20,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.black,
//                     fontFamily: 'Walsheim',
//                   ),
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'I am strong.'.tr,
//                     hintStyle: TextStyle(
//                       fontFamily: 'Walsheim',
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: height * 0.01,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: GestureDetector(
//               onTap: () {
//                 String firbidEords = forbidWord.text.trim();
//                 if (firbidEords.isNotEmpty) {
//                   setState(() {
//                     forbidWord.text = '';
//                     words.add(
//                       Forbin(name: firbidEords),
//                     );
//                   });
//                 }
//                 Navigator.pop(context, forbidWord.text);
//               },
//               child: Container(
//                 height: 50,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   gradient: LinearGradient(
//                     // ignore: prefer_const_literals_to_create_immutables
//                     colors: [
//                       AppColors.dailoggary,
//                       AppColors.dailogblack,
//                     ],
//                     stops: const [
//                       0.0,
//                       1.0,
//                     ],
//                     begin: FractionalOffset.topLeft,
//                     end: FractionalOffset.bottomRight,
//                     tileMode: TileMode.repeated,
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Save".tr,
//                     style: TextStyle(
//                       color: AppColors.whiteB,
//                       fontSize: height * 0.02,
//                       fontFamily: 'Walsheim',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
