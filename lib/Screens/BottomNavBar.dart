import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:time/Screens/AccountScreen.dart';

import 'package:time/Screens/MessagesScreen.dart';
import 'package:time/Screens/SettingsScreen.dart';
import 'package:time/Screens/TransactionsScreen.dart';

import 'HomeScreen1.dart';



class Bottomnavigation extends StatefulWidget {
  String chatRoomId;
  String username;
  Bottomnavigation(this.chatRoomId, this.username);


  get menuScreenContext => null;

  @override
  _BottomnavigationState createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
   PersistentTabController _controller;
  bool _hideNavBar;
   void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
        MessagesScreen(
          chatRoomId:widget.chatRoomId,
        username:widget.username,
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      TransactionScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      HomeScreen1(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      SettingScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      AccountScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
    ];
  }


    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
             PersistentBottomNavBarItem(
               //change bottom naviagtion  icon here if you want
        icon: Icon(Icons.message),
        title: "Messages",
        activeColorPrimary: Color(0xff5E17EB),
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.history),
        title: ("History"),
        activeColorPrimary: Color(0xff5E17EB),
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            // '/first': (context) => LoginPage(),
            // '/second': (context) => LoginPage(),
          },
        ),
      ),
    PersistentBottomNavBarItem(
        icon: Icon(Icons.home,color: Colors.white,),
        title: ("Home"),
        activeColorPrimary: Color(0xff5E17EB),
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            // '/first': (context) => LoginPage(),
            // '/second': (context) => LoginPage(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          height: 30,
          width: 30,
          child: Icon(Icons.settings),
        ),
        title: ("Settings"),
        activeColorPrimary: Color(0xff5E17EB),
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            // '/first': (context) => MainScreen2(),
            // '/second': (context) => MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Account"),
        activeColorPrimary: Color(0xff5E17EB),
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            // '/first': (context) => MainScreen2(),
            // '/second': (context) => MainScreen3(),
          },
        ),
      ),
        ];
    }
  @override
  Widget build(BuildContext context) {
     PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);
    return Stack(
      children: [
      PersistentTabView(
        
         context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
         
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
           // boxShadow: Colors.black,
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.black,
            
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style16, // 
        
      ),
      ],
    );
        
   
    
        
        
        
  }
  }