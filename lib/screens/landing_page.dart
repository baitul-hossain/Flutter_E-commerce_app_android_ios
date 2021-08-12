import 'package:a_commerce/constants.dart';
import 'package:a_commerce/screens/home_page.dart';
import 'package:a_commerce/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        // If snapshot has error
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        // If connection is successfull
        if(snapshot.connectionState == ConnectionState.done){
          // Stream builder can check the login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamsnapshot){

              if(streamsnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${streamsnapshot.error}'),
                  ),
                );
              }

              // ConnectionState.active checks the user login state

              if(streamsnapshot.connectionState == ConnectionState.active) {
                 User _user = streamsnapshot.data;
                 if(_user == null){
                   return Center(
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Center(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: LoginPage(),
                         ),
                       ),
                     ),
                   );
                 }
                 else{
                   return HomePage();
                 }
              }

              // Firebase auth check status loading..
              return Scaffold(
                body: Center(
                  child: Text('Checking authentication...'),
                ),
              );

            },
          );
        }

        // Firebase connection initialize loading..
        return Scaffold(
          body: Center(
            child: Text('Initializing...'),
          ),
        );
      },

    );
  }
}