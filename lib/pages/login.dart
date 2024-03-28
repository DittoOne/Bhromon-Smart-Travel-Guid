import 'package:animate_do/animate_do.dart';
import 'package:bhromon/helpers/AuthCheck.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bhromon/helpers/const.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController=TextEditingController();
  final passController=TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void passReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim(),);
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            alignment: Alignment.center,
            title: Text("Password Reset Email Sent", style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18
            ),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    }on FirebaseAuthException catch(e){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(e.message.toString(), style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18
            ),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    }
  }
  void loggedin() async{
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
    );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
      );
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthCheck()));
    }on FirebaseAuthException catch (e){
      print(e);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(e.message.toString(), style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18
                ),
              textAlign: TextAlign.center,
              ),
            );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Login", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),)),
                      SizedBox(height: 20,),
                      FadeInUp(duration: Duration(milliseconds: 1200), child: Text("Login to your account", style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700]
                      ),)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(duration: Duration(milliseconds: 1200), child: makeInput(label: "Email",fieldcontroller: emailController)),
                        FadeInUp(duration: Duration(milliseconds: 1300), child: makeInput(label: "Password",fieldcontroller: passController, obscureText: true)),
                      ],
                    ),
                  ),
                  FadeInUp(duration: Duration(milliseconds: 1400), child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      //padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          loggedin();
                          //Navigator.pop(context);
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                        },
                        color: ColorSys.secoundryLight,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text("Login", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                        ),),
                      ),
                    ),
                  )),
                  FadeInUp(duration: Duration(milliseconds: 1500), child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: passReset,
                        child: Text("Forgot Password?", style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18
                        ),),
                      ),
                    ],
                  ))
                ],
              ),
            ),
            FadeInUp(duration: Duration(milliseconds: 1200), child: Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover
                )
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget makeInput({label,fieldcontroller, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          obscureText: obscureText,
          controller: fieldcontroller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}