import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time/helper/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time/Utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time/Screens/LoginScreen.dart';
import 'package:time/Screens/SignUpScreen.dart';
import 'package:country_pickers/country.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';

import 'package:country_pickers/country_pickers.dart';

import 'BottomNavBar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _NameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  Country _selectedDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode('90');

  Country _selectedFilteredDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode('90');

  Country _selectedCupertinoCountry =
  CountryPickerUtils.getCountryByIsoCode('tr');

  Country _selectedFilteredCupertinoCountry =
  CountryPickerUtils.getCountryByIsoCode('DE');

  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 30),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          SystemNavigator.pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        )),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "Assets/Images/logo.png",
                height: 90,
                width: 90,
              ),
              Image.asset(
                "Assets/Images/TIMEVAULT APP.png",
                width: 150,
                height: 60,
              ),
              SizedBox(
                height: 0,
              ),
              Text(
                "Become a partner with us and join us for",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    // decoration: TextDecoration.underline,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "transfering your units to your loved ones",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    // decoration: TextDecoration.underline,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(23)),
                      child: TextFormField(
                        controller: _NameController,
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r"^[a-zA-Z ]+").hasMatch(value)) {
                            return 'Enter a valid name!';
                          } else if (value.length <= 2)
                            return 'More Than 2 words';
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 25, top: 15),
                          border: InputBorder.none,
                          hintText: "Name",
                          // prefixIcon: Icon(
                          //   Icons.person,
                          //   color: Colors.black,
                          // ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(23)),
                      child: TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r"^[a-zA-Z ]+").hasMatch(value)) {
                            return 'Enter a valid UserName!';
                          } else if (value.length <= 2)
                            return 'More Than 2 words';
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 25, top: 15),
                          border: InputBorder.none,
                          hintText: "Username",
                          // prefixIcon: Icon(
                          //   Icons.person,
                          //   color: Colors.black,
                          // ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 54),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(23)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //Text('CountryPickerDropdown (sorted by isoCode)'),
                            ListTile(
                                title: _buildCountryPickerDropdown(
                                    sortedByIsoCode: true)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Container(
                    //   height: 55,
                    //   width: 300,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(width: 1, color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(23)),
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.number,
                    //   //  controller: _emailController,
                    //     validator: (value) {
                    //       if (value.isEmpty ||
                    //           !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                    //               .hasMatch(value)) {
                    //         return 'Enter a valid PhoneNumber!';
                    //       } else if (value.length <= 2)
                    //         return 'More Than 2 words';
                    //       return null;
                    //     },
                    //     decoration: InputDecoration(
                    //       contentPadding: EdgeInsets.only(left: 25, top: 15),
                    //       border: InputBorder.none,
                    //       hintText: "Phone Number",
                    //       // prefixIcon: Icon(
                    //       //   Icons.phone,
                    //       //   color: Colors.black,
                    //       // ),
                    //       hintStyle: TextStyle(
                    //           color: Colors.grey,
                    //           fontSize: 17,
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(23)),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid Email!';
                          } else if (value.length <= 2)
                            return 'More Than 2 words';
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 25, top: 15),
                          border: InputBorder.none,
                          hintText: "Email ID",
                          // prefixIcon: Icon(
                          //   Icons.email,
                          //   color: Colors.black,
                          // ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(23)),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Password';
                          } else if (value.length < 8)
                            return 'Password should be at least 8 characters';

                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 25, top: 15),
                          border: InputBorder.none,
                          hintText: "Password",
                          // prefixIcon: Padding(
                          //   padding: const EdgeInsets.only(top: 0.0),
                          //   child: Icon(
                          //     Icons.remove_red_eye,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(23)),
                      child: TextFormField(
                        obscureText: true,
                        // controller: _emailController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Password';
                          } else if (value.length < 8)
                            return 'Password should be at least 8 characters';
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 25, top: 15),
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                          // prefixIcon: Icon(
                          //   Icons.remove_red_eye,
                          //   color: Colors.black,
                          // ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  print('andar a yar fikar na ka');
                  signupclick();
                },
                child: Container(
                  height: 65,
                  width: 280,
                  child: Card(
                    color: Color(0xff5E17EB),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Text(
                          "SIGN UP",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              // decoration: TextDecoration.underline,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account! ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void createChatRoom(username) {
    List<String> users = [Constants.myName,'admin'];
    String chatRoomId = getChatRoomId(Constants.myName,'admin');
    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };
    databaseMethods.addChatRoom(chatRoom, chatRoomId);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Bottomnavigation(chatRoomId,username)));
  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  Future<void> signupclick() async {
    User user;
    user = (await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)).user;
    if (user == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                'Error Message',style: TextStyle(fontSize: 20,color: Colors.white,),
              ),
              content: Text("Your Current Balance is ", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

            ),
          );
        },
      );
    }
    else{
      Fluttertoast.showToast(
          msg: "Please wait",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Firestore.instance.collection('Users').document(user.uid).setData({
        'email': _emailController.text,
        'username': _usernameController.text,
        'Name': _NameController.text,
        'uid':user.uid,
        'units':1000,
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Bottomnavigation('rfrrf','rfr4fcrfc')));
    }
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return Center(
            child: AlertDialog(
              backgroundColor: Color(0xff8AF3D8),
              title: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text('Error message'),
                        SizedBox(
                          height: 21,
                        ),
                        Text('The email address is already in use by another account'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  _buildCountryPickerDropdownSoloExpanded() {
    return CountryPickerDropdown(
      underline: Container(
        height: 2,
        color: Colors.red,
      ),
      //show'em (the text fields) you're in charge now
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      //if you want your dropdown button's selected item UI to be different
      //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.
      onValuePicked: (Country country) {
        print("${country.name}");
      },
      itemBuilder: (Country country) {
        return Row(
          children: <Widget>[
            SizedBox(width: 8.0),
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(width: 2.0),
            Expanded(child: Text(country.name)),
          ],
        );
      },
      itemHeight: null,
      isExpanded: true,
      //initialValue: 'TR',
      icon: Icon(Icons.arrow_downward),
    );
  }

  //-------------------------------------this one code picker is used ---------------------------------

  _buildCountryPickerDropdown(
      {bool filtered = false,
        bool sortedByIsoCode = false,
        bool hasPriorityList = false,
        bool hasSelectedItemBuilder = false}) {
    double dropdownButtonWidth = MediaQuery.of(context).size.width * 0.4;
    //respect dropdown button icon size
    double dropdownItemWidth = dropdownButtonWidth - 30;
    double dropdownSelectedItemWidth = dropdownButtonWidth - 30;
    return Row(
        children: <Widget>[
        SizedBox(
        // width: 2,
        width: dropdownButtonWidth,
        child: CountryPickerDropdown(
          /* underline: Container(
              height: 2,
              color: Colors.red,
            ),*/
          //show'em (the text fields) you're in charge now
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            //if you have menu items of varying size, itemHeight being null respects
            //that, IntrinsicHeight under the hood ;).
            itemHeight: null,
            //itemHeight being null and isDense being true doesn't play along
            //well together. One is trying to limit size and other is saying
            //limit is the sky, therefore conflicts.
            //false is default but still keep that in mind.
            isDense: false,
            //if you want your dropdown button's selected item UI to be different
            //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.
            selectedItemBuilder: hasSelectedItemBuilder == true
                ? (Country country) => _buildDropdownSelectedItemBuilder(
                country, dropdownSelectedItemWidth)
                : null,
            //initialValue: 'AR',
            itemBuilder: (Country country) => hasSelectedItemBuilder == true
                ? _buildDropdownItemWithLongText(country, dropdownItemWidth)
                : _buildDropdownItem(country, dropdownItemWidth),
            initialValue: 'AR',
            itemFilter: filtered
                ? (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode)
                : null,
            //priorityList is shown at the beginning of list
            priorityList: hasPriorityList
            ? [
            CountryPickerUtils.getCountryByIsoCode('GB'),
            CountryPickerUtils.getCountryByIsoCode('CN'),
            ]
                : null,
            sortComparator: sortedByIsoCode
            ? (Country a, Country b) => a.isoCode.compareTo(b.isoCode)
        : null,
    onValuePicked: (Country country) {
    print("${country.name}");
    },
    ),
    ),
    // SizedBox(
    //   width: 0.0,
    // ),
    Expanded(
    child: TextField(
    decoration: InputDecoration(
    labelText: "Phone",
    isDense: true,
    contentPadding: EdgeInsets.zero,
    ),
    keyboardType: TextInputType.number,
    ),
    )
    ],
    );
  }

  Widget _buildDropdownItem(Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Expanded(child: Text("+${country.phoneCode}(${country.isoCode})")),
          ],
        ),
      );

  Widget _buildDropdownItemWithLongText(
      Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              SizedBox(
                width: 8.0,
              ),
              Expanded(child: Text("${country.name}")),
            ],
          ),
        ),
      );

  Widget _buildDropdownSelectedItemBuilder(
      Country country, double dropdownItemWidth) =>
      SizedBox(
          width: dropdownItemWidth,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  CountryPickerUtils.getDefaultFlagImage(country),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                      child: Text(
                        '${country.name}',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )),
                ],
              )));

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(width: 8.0),
      Text("+${country.phoneCode}"),
      SizedBox(width: 8.0),
      Flexible(child: Text(country.name))
    ],
  );

  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.pink),
      child: CountryPickerDialog(
        titlePadding: EdgeInsets.all(8.0),
        searchCursorColor: Colors.pinkAccent,
        searchInputDecoration: InputDecoration(hintText: 'Search...'),
        isSearchable: true,
        title: Text('Select your phone code'),
        onValuePicked: (Country country) =>
            setState(() => _selectedDialogCountry = country),
        itemBuilder: _buildDialogItem,
        priorityList: [
          CountryPickerUtils.getCountryByIsoCode('TR'),
          CountryPickerUtils.getCountryByIsoCode('US'),
        ],
      ),
    ),
  );

  void _openFilteredCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.pink),
        child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text('Select your phone code'),
            onValuePicked: (Country country) =>
                setState(() => _selectedFilteredDialogCountry = country),
            itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
            itemBuilder: _buildDialogItem)),
  );

  void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          backgroundColor: Colors.black,
          itemBuilder: _buildCupertinoItem,
          pickerSheetHeight: 300.0,
          pickerItemHeight: 75,
          initialCountry: _selectedCupertinoCountry,
          onValuePicked: (Country country) =>
              setState(() => _selectedCupertinoCountry = country),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('TR'),
            CountryPickerUtils.getCountryByIsoCode('US'),
          ],
        );
      });

  void _openFilteredCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          backgroundColor: Colors.white,
          pickerSheetHeight: 200.0,
          initialCountry: _selectedFilteredCupertinoCountry,
          onValuePicked: (Country country) =>
              setState(() => _selectedFilteredCupertinoCountry = country),
          itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
        );
      });

  Widget _buildCupertinoSelectedItem(Country country) {
    return Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 8.0),
        Text("+${country.phoneCode}"),
        SizedBox(width: 8.0),
        Flexible(child: Text(country.name))
      ],
    );
  }

  Widget _buildCupertinoItem(Country country) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.white,
        fontSize: 16.0,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 8.0),
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      ),
    );
  }
}
