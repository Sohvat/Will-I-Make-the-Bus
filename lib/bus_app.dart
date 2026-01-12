import 'package:flutter/material.dart';
import 'package:will_i_make_the_bus/landing_page.dart';
import 'package:will_i_make_the_bus/main_page.dart';


class BusApp extends StatefulWidget {
  const BusApp({super.key});

  @override
  State<BusApp> createState() => _BusAppState();
}

class _BusAppState extends State<BusApp> {
  bool _isLandingPage = true;
  bool _isMain = false;
  
  @override
  Widget build(BuildContext context) {
    if(_isLandingPage == false && _isMain == true){
      return MainPage();
    }else{
      return  Scaffold(
      backgroundColor: Color(0xFF6c9ed0),
      appBar: AppBar(
        backgroundColor: Color(0xFF6c9ed0),
        title: Text(
          "Hello!",
          style: TextStyle(
            color: Colors.white,
            height: 150,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/logo.png',
              width: 450,
              height: 450,
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {
                setState(() {
                _isMain = true;
                _isLandingPage = false;
                })
              },
              style: ButtonStyle(

              ),
              child: const Text('Click to continue'),
            ),
          ],
        ),
      ),
    );
    }
    
  }
}