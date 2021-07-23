import 'package:flutter/material.dart';
import 'package:flutter_app/ApiMethods/ApiRepository.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailTextController = TextEditingController();
  ApiRepository apiRepo = ApiRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text(''),// You can add title here
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Colors.grey),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.blue.withOpacity(0.0), //You can make this transparent
              elevation: 0.0, //No shadow
            ),),
          Container(
            padding: EdgeInsets.only(top: 80),
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Sign In",style: TextStyle(color: Colors.yellow,fontSize: 40),),
                Container(
                  padding: EdgeInsets.only(top: 80),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextField(
                            controller: emailTextController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Obo Name/Email',
                              suffix:GestureDetector(
                                onTap:(){
                                  if(emailTextController.text.isNotEmpty){
                                    FocusScope.of(context).unfocus();
                                    apiRepo.sendOtp(emailTextController.text.trim());
                                  }
                                },
                                child:Text("Get OTP"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'OTP',
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if(await apiRepo.login()){
                                  Navigator.pushNamed(context, '/homepage');
                                }
                              },
                              child: Text('Sign In',style: TextStyle(fontSize: 20,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
