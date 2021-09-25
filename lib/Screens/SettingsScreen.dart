import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'HomeScreen1.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({ Key key, menuScreenContext, bool hideStatus, Null Function() onScreenHideButtonPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
               Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("Assets/Images/1.png")),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: Row(
                        children: [
                           IconButton( 
                                      onPressed: (){
                                        Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => HomeScreen1()));
                                      },
                                   icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
                          SizedBox(
                            width: 120,
                          ),
                            Text("Settings",style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        // decoration: TextDecoration.underline,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    height: 58,
                    width: 360,
                    decoration: BoxDecoration(
                       
                     // color: Color(0xffF3F3F3),
                     color: Colors.black12,
                      borderRadius: BorderRadius.circular(14)
                    ),
                    
                    child: TextFormField(
                      
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search,color: Colors.grey,),
                        contentPadding: EdgeInsets.only(left: 25, top: 20),
                         border: InputBorder.none,
                        hintText: "Search",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      leading: Image.asset("Assets/Images/pericon.png",height: 40,width: 40,),
                      title: Text("Account",style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),),
                                          subtitle: Text("View Your Account",style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),),
                                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      leading: Image.asset("Assets/Images/Layer 18.png",height: 40,width: 40,),
                      title: Text("Transaction Changes",style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),),
                                          subtitle: Text("Make Changes",style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),),
                                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height:5,
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      leading: Image.asset("Assets/Images/Layer 10.png",height: 40,width: 40,),
                      title: Text("Privacy Policy",style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),),
                                          subtitle: Text("View Your Privacy Policy",style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),),
                                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 80,

                      decoration: BoxDecoration(
                         color: Color(0xff5E17EB),
                         borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Image.asset("Assets/Images/terms.png",height: 40,width: 40,color: Colors.white,),
                          title: Text("Terms and Conditions",style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              // decoration: TextDecoration.underline,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),),
                                              subtitle: Text("View Your Terms and Condition",style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              // decoration: TextDecoration.underline,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),),
                                              trailing: Icon(Icons.arrow_forward_ios,color: Colors.white),
                        ),
                      ),

                    ),
                  ),

                     SizedBox(
                    height: 15,
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      leading: Image.asset("Assets/Images/share.png",height: 40,width: 40,),
                      title: Text("Share",style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),),
                                          subtitle: Text("Share on SocialMedia",style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),),
                                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey),
                    ),
                  ),


                     SizedBox(
                    height: 5,
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      leading: Image.asset("Assets/Images/Layer 17.png",height: 40,width: 40,),
                      title: Text("Reviews",style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),),
                                          subtitle: Text("View Your Reviews",style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),),
                                          trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
            ],
          ),
        ),
      ),
      
    );
  }
}


