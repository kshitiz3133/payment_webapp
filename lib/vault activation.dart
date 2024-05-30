import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'cardpayment.dart';
import 'home.dart';

class Activator extends StatefulWidget {
  const Activator({Key? key}) : super(key: key);

  @override
  State<Activator> createState() => _ActivatorState();
}

class _ActivatorState extends State<Activator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Welcome to your Bank"),
        actions: [IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.logout))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Vault is Not Activated",
                  style: TextStyle(fontSize: 25),
                ),
                ElevatedButton(
                    onPressed: () {
                      _launchURLa();
                    },
                    child: Text("Activate Vault")),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            payment(context),
          ],
        ),
      ),
    );
  }
  void _launchURLa() async {
    const url = 'https://github.com/kshitiz3133';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

Widget payment(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pay",
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: 40,
        ),
        Center(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CardPay()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 0.1,
                                      blurRadius: 2)
                                ]),
                              child: Padding(
                                padding: const EdgeInsets.all(38.0),
                                child: Center(child: Text("Card Payment",style: TextStyle(fontSize: 18,color: Colors.black),)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.1,
                                        blurRadius: 2)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(38.0),
                                child: Center(child: Text("Send Money",style: TextStyle(fontSize: 19,color: Colors.black),)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0.1,
                                blurRadius: 2)
                          ]),
                        child: Padding(
                          padding: const EdgeInsets.all(38.0),
                          child: Center(child: Text("Self Transfer",style: TextStyle(fontSize: 18,color: Colors.black),)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
