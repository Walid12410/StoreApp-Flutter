import 'package:flutter/material.dart';
import 'login.dart';

class thankyoupage extends StatefulWidget {
  const thankyoupage({super.key});

  @override
  State<thankyoupage> createState() => _thankyoupageState();
}

class _thankyoupageState extends State<thankyoupage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Our Store',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'thankyou.jpg',
                width: double.infinity,
                height: 250,
              ),
              const SizedBox(height: 20,),
              Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(colors: [
                    Color(0xff1acb4d),
                    Color(0xff184b28),
                  ]),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
