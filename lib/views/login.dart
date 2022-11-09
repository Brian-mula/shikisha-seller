import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  String verificationId = '';
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(color: Colors.deepPurpleAccent),
    borderRadius: BorderRadius.circular(15.0),
  );
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController firstName = TextEditingController();
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final _formKey = GlobalKey<FormState>();

  String? code;

  @override
  Widget build(BuildContext context) {
    void signInWithPhoneAuthCredential(
        PhoneAuthCredential phoneAuthCredential) async {
      setState(() {
        isLoading = true;
      });
      try {
        final authCredential = await FirebaseAuth.instance.signInWithCredential(
          phoneAuthCredential,
        );
        if (authCredential.user != null) {}
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${e.message}'),
          ),
        );
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onPressed: () async {
            _formKey.currentState?.validate();
            var doc = await _userCollection.doc(code! + phoneNumber.text).get();
            if (doc.exists) {
              await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: code! + phoneNumber.text,
                  verificationCompleted: (PhoneAuthCredential credential) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'error: ${e.message}',
                      style: Theme.of(context).textTheme.bodyText1,
                    )));
                  },
                  codeSent: (String verificationId, int? resendToken) {
                    setState(() {
                      isLoading = false;
                      currentState =
                          MobileVerificationState.SHOW_OTP_FORM_STATE;
                      this.verificationId = verificationId;
                    });
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: _pinPutController.text,
                    );
                    signInWithPhoneAuthCredential(phoneAuthCredential);
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {});
              // if (_formKey.currentState!.validate()) {
              //   print("retrieving data");
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('Authenticating...')),
              //   );
              //   setState(() {
              //     isLoading = true;
              //   });
              //   print("retrieving data");
              //   await FirebaseAuth.instance.verifyPhoneNumber(
              //     phoneNumber: code! + phoneNumber.text,
              //     verificationCompleted:
              //         (PhoneAuthCredential credential) async {
              // setState(() {
              //   isLoading = false;
              // });
              //     },
              //     verificationFailed: (FirebaseAuthException e) async {
              // setState(() {
              //   isLoading = false;
              // });
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text(
              //   'error: ${e.message}',
              //   style: Theme.of(context).textTheme.bodyText1,
              // )));
              //     },
              //     codeSent: (String verificationId, int? resendToken) async {
              // setState(() {
              //   isLoading = false;
              //   currentState =
              //       MobileVerificationState.SHOW_OTP_FORM_STATE;
              //   this.verificationId = verificationId;
              // });
              //     },
              //     codeAutoRetrievalTimeout: (String verificationId) async {},
              //   );
              // }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User not found Contact admin'),
                ),
              );
            }
          }),
      appBar: AppBar(
        title: Text(
          'Employee Login',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: IntlPhoneField(
                            controller: phoneNumber,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            initialCountryCode: 'KE',
                            onChanged: (phone) {
                              code = phone.countryCode;
                              print(phone.completeNumber);
                            },
                          )),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter confirmation OTP for ${phoneNumber.text}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      // PinPut(
                      //   fieldsCount: 6,
                      //   eachFieldHeight: 40.0,
                      //   withCursor: true,
                      //   // onSubmit: (String pin) => _showSnackBar(pin),
                      //   onSubmit: (String pin) async {
                      //     PhoneAuthCredential phoneAuthCredential =
                      //         PhoneAuthProvider.credential(
                      //       verificationId: verificationId,
                      //       smsCode: _pinPutController.text,
                      //     );
                      //     signInWithPhoneAuthCredential(phoneAuthCredential);
                      //   },
                      //   focusNode: _pinPutFocusNode,
                      //   controller: _pinPutController,
                      //   submittedFieldDecoration: pinPutDecoration.copyWith(
                      //     borderRadius: BorderRadius.circular(20.0),
                      //   ),
                      //   selectedFieldDecoration: pinPutDecoration,
                      //   followingFieldDecoration: pinPutDecoration.copyWith(
                      //     borderRadius: BorderRadius.circular(5.0),
                      //     border: Border.all(
                      //       color: Colors.deepPurpleAccent.withOpacity(.5),
                      //     ),
                      //   ),
                      // ),
                      Pinput(
                        length: 6,
                        onSubmitted: (String pin) async {
                          PhoneAuthCredential phoneAuthCredential =
                              PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: _pinPutController.text,
                          );
                          signInWithPhoneAuthCredential(phoneAuthCredential);
                        },
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                      )
                    ],
                  ),
                ),
    );
  }

  // void getPhoneNumber(String phoneNumber) async {
  //   setState(() {
  //     number = number;
  //   });
  //   print(number);
  // }
}
