
import 'package:a_commerce/constants.dart';
import 'package:a_commerce/screens/login_page.dart';
import 'package:a_commerce/widgets/custom_btn.dart';
import 'package:a_commerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Build an alert dialog to display some errors
  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Close dialog'),
              )
            ],
          );
        }
    );
  }

  // Create a new user account
  Future<String> _createAccount() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail,
          password: _registerPassword
      );
      return null;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Submit form
  void _submitForm() async {
    // Set the button to loading state
    setState(() {
      _registerFormLoading = true;
    });
    // Run the create account method
    String _createAccountFeedback = await _createAccount();
    if(_createAccountFeedback != null){
      _alertDialogBuilder(_createAccountFeedback);
      setState(() {
        _registerFormLoading = false;
      });
    }
    else{
      Navigator.pop(context);
    }
  }

  // Default form loading state
  bool _registerFormLoading = false;

  // Form input values
  String _registerEmail = '';
  String _registerPassword = '';

  // FocusNode for input fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(
                      top: 24.0,
                    ),
                    child: Text('Create a new account', textAlign: TextAlign.center, style: Constants.boldHeading,)
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: 'Email..',
                      onChanged: (value){
                        _registerEmail = value;
                      },
                      onSubmitted: (value){
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: 'Password..',
                      onChanged: (value){
                        _registerPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value){
                        _submitForm();
                      },
                    ),
                    CustomBtn(
                      text: 'Register',
                      onPressed: (){
                        //_alertDialogBuilder();
                        // setState(() {
                        //   _registerFormLoading = true;
                        // });
                        _submitForm();
                      },
                      outlineBtn: false,
                      isLoading: _registerFormLoading,
                    )
                  ],
                ),
                CustomBtn(
                  text: 'Back to login',
                  onPressed: (){
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => LoginPage()
                    //   )
                    // );
                    Navigator.pop(context);
                  },
                  outlineBtn: true,
                )
              ],
            ),
          )
      ),
    );
  }
}
