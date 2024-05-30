import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:payment_webapp/vault%20activation.dart';

import 'Util/baseurl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool a = true;
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(decoration: InputDecoration(labelText: "Phone Number"),),
                  TextField(decoration: InputDecoration(labelText: "Password"),),
                  SizedBox(height: 50,),
                  ElevatedButton(onPressed: (){
                    login();
                  }, child: Text("Login"))
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Future<void> login()async{
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacement(context,  PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const /*VaultHome()*/ Activator()));
    });
  }

  Future<void> sendotp() async {
    var url = Uri.parse('${BaseUrl.baseUrl}/auth/sendotp');
    var body = json.encode({"mobileNumber": "+91${_phoneController.text}"});

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print('Response status: ${response.statusCode}');
      if (response.body == "An OTP has been sent to your mobile number") {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showModalBottomSheet(
            context: context,
            builder: (context) => const SizedBox(
              height: 100,
              child: Center(child: Text("OTP Sent!")),
            ),
          );
        });
        setState(() {
          a = false;
        });
        print('Error: ${response.body}');
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showModalBottomSheet(
            context: context,
            builder: (context) => const SizedBox(
              height: 100,
              child: Center(child: Text("Please Enter a Valid Number")),
            ),
          );
        });
      }
    } catch (e) {
      print("Error sending OTP: $e");
    }
  }

  Future<void> verify() async {
    var url = Uri.parse('${BaseUrl.baseUrl}/auth/verifyotp');
    var body = json.encode({
      "mobileNumber": "+91${_phoneController.text}",
      "otp": "${_otpController.text}"
    });

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        setState(() {
          check = true;
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showModalBottomSheet(
            context: context,
            builder: (context) => const SizedBox(
              height: 100,
              child: Center(child: Text("Enter Correct OTP")),
            ),
          );
        });
      }
    } catch (e) {
      print("Error verifying OTP: $e");
    }
  }

  Future<void> enterNumber() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await sendotp();
    Navigator.of(context).pop();
  }

  Future<void> enterOtp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await verify();
    Navigator.of(context).pop();
    check?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Activator())):print("error");

  }
}
