// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:timevault/Screens/AccountScreen.dart';
// import 'package:timevault/Screens/HomeScreen.dart';
// import 'package:timevault/Screens/MessagesScreen.dart';
// import 'package:timevault/Screens/SettingsScreen.dart';
// import 'package:timevault/Screens/TransactionsScreen.dart';

// class BottomNavBar extends StatefulWidget {
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _page = 0;
//   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CurvedNavigationBar(
//           key: _bottomNavigationKey,
//         backgroundColor: Colors.white,
//         color: Color(0xff5E17EB),
//         animationDuration: Duration(milliseconds: 300),
//         index: 2,
//         items: <Widget>[
//           Icon(
//             Icons.add,
//             size: 30,
//             color: Colors.white,
//           ),
//           Icon(
//             Icons.add,
//             size: 30,
//             color: Colors.white,
//           ),
//           Icon(
//             Icons.add,
//             size: 30,
//             color: Colors.white,
//           ),
//           Icon(
//             Icons.add,
//             size: 30,
//             color: Colors.white,
//           ),
//           Icon(
//             Icons.add,
//             size: 30,
//             color: Colors.white,
//           ),
//         ],
//           onTap: (index) {
//             setState(() {
//               _page = index;
//             });
//           },
//           letIndexChange: (index) => true,
//         // onTap: (index) {
//         //   MessagesScreen();
//         //   TransactionScreen();
//         //   HomeScreen();
//         //   SettingScreen();
//         //   AccountScreen();
//         //   //Handle button tap
//         // },
//       ),
//        body: Container(
//           color: Colors.blueAccent,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(_page.toString(), textScaleFactor: 10.0),
//                 ElevatedButton(
//                   child: Text('Go To Page of index 1'),
//                   onPressed: () {
//                     final CurvedNavigationBarState navBarState =
//                         _bottomNavigationKey.currentState;
//                     navBarState?.setPage(1);
//                   },
//                 )
//               ],
//             ),
//           ),
//         )
//     );
//   }
// }
