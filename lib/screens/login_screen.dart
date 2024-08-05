import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:online_store_fl_app/controller/auth_controller.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.network(
                      "https://img.freepik.com/free-vector/social-media-marketing-mobile-phone-concept_23-2148431747.jpg?w=1060&t=st=1722688715~exp=1722689315~hmac=09c10f22d5ac8607b9c8bfb004b19682461693799fa46041224a52590461fd3e"),
                ),
                InkWell(
                  onTap: () {
                    controller.signInWithGoogle();
                    
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey),
                    child: Center(
                        child: Text(
                      "Login with Googl",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
