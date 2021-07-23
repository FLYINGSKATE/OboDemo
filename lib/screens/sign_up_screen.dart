import 'package:flutter/material.dart';
import 'package:flutter_app/ApiMethods/ApiRepository.dart';
import 'package:flutter_app/widgets/MyTextField.dart';
import 'package:flutter_app/widgets/country_code_picker.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final nameTextController = TextEditingController();
  final oboNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final zipCodeController = TextEditingController();
  final otpTextController = TextEditingController();
  final emailTextController = TextEditingController();
  ApiRepository apiRepo = ApiRepository();


  bool acceptTNCs = false;

  var countryCode = 'IN';

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,10.0,0.0,0.0),
                  child: Text("Create Account",style: TextStyle(color: Colors.yellow,fontSize: 40),),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyTextField(controller: nameTextController, hintText: 'First & Last Name', onSubmit: (String val) {  }, onSuffixClick: (String val) {  }, onChanged: (String val) {  },),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyTextField(controller: oboNameTextController, hintText: 'Obo Name', onSubmit: (String val) {  }, onSuffixClick: (String val) {  }, onChanged: (String val) {  },),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 50,
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: _codePicker,
                                      child: Text(
                                        countryCode,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.purple,
                                            decoration: TextDecoration.underline),
                                      )),
                                  Container(
                                    height: 24,
                                    width: 1,
                                    color: Colors.grey,
                                    margin: const EdgeInsets.only(right: 20),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: phoneNumberTextController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.phone,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Mobile(Optional)',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyTextField(suffixEnable:true,suffixText:'Get OTP',controller: emailTextController, hintText: 'Email', onSubmit: (String val) {  }, onSuffixClick: (String val) {
                            apiRepo.getRegisterOtp(nameTextController.text.trim(),
                                emailTextController.text.trim(),
                                phoneNumberTextController.text.toString().trim());
                          }
                          , onChanged: (String val) {  },),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyTextField(hintText: 'Zip-code(Optional)',
                            suffixEnable: false,
                            onSubmit: (String val){},
                            textInputType: TextInputType.number,
                            maxLength: 6, onSuffixClick: (String val) {  }, onChanged: (String val) {  }, controller: zipCodeController,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                            Checkbox(
                            checkColor: Colors.green,

                            value: acceptTNCs,
                            onChanged: (bool? value) {
                              setState(() {
                                acceptTNCs = value!;
                              });
                            },
                          ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  primary: Colors.black,
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/tnc');
                                },
                                child: const Text('Accept'),
                              ),
                              Text('Terms & Conditions'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                  _register();
                              },
                              child: Text('Sign Up',style: TextStyle(fontSize: 20,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
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

  void _codePicker() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      builder: (ctx) => CountryCodePicker(
        primaryColor: Colors.lightBlueAccent, key: null,
      ),
    );

    if (result != null) {
      countryCode = result['dial_code'];
      setState(() {});
    }
  }

  void _register() {
    _register() async {
      //Loader.instance.showLoader();

      final response = await apiRepo.register(

        //String username,String emailPhone,String oboName,String otp, String mobileNumber, String countryCode, String zipcode
        nameTextController.text.trim(),
        emailTextController.text.trim(),
        oboNameTextController.text,
        otpTextController.text.toString().trim(),
        phoneNumberTextController.text.trim(),
        countryCode,
        zipCodeController.text,
      );
      //Loader.instance.hide();
    }
  }
}
