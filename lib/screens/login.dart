import 'package:dha_cleaning_app/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../model/login_request.dart';
import '../model/user_record.dart';
import '../utils/api_service.dart';
import './homepage.dart';

class LoginScreen extends StatefulWidget {
  UserRecord loginRecord = UserRecord();
  // LoginScreen({super.key, this.loginRecord});
  // static const namedRoute = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isApiCallProcess = false;
  bool showText = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? dhaNumber;
  String? password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F0A38),
          centerTitle: true,
          title: const Text('DHA Maintenance'),
        ),
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
        ));
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/img/dha_lahore_logo.png',
                    fit: BoxFit.contain,
                    width: 120,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0xFF0F0A38),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "DHA Number",
              "DHA Number",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'DHA Number can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                dhaNumber = onSavedVal,
              },
              initialValue: "",
              obscureText: false,
              borderFocusColor: const Color(0xFF0F0A38),
              borderColor: const Color(0xFF0F0A38),
              textColor: const Color(0xFF0F0A38),
              hintColor: const Color(0xFF0F0A38).withOpacity(0.7),
              borderRadius: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "Password",
              "Password",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Password can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                password = onSavedVal,
              },
              initialValue: "",
              obscureText: showText,
              borderFocusColor: const Color(0xFF0F0A38),
              borderColor: const Color(0xFF0F0A38),
              textColor: const Color(0xFF0F0A38),
              hintColor: const Color(0xFF0F0A38).withOpacity(0.7),
              borderRadius: 5,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    showText = !showText;
                  });
                },
                color: const Color(0xFF0F0A38).withOpacity(0.7),
                icon: Icon(
                  showText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  LoginRequest model = LoginRequest(
                    username: dhaNumber!,
                    password: password!,
                    isMobile: 1,
                  );

                  ApiService.login(model).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          ApiConstants.appName,
                          "Invalid Username/Password !!",
                          "OK",
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  );
                }
              },
              btnColor: HexColor("0F0A38"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(height: 80),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/img/pitb_logo.png',
              width: 40,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Align(
              alignment: Alignment.center, child: Text('Powered By PITB')),
        ],
      ),
    );
  }

  // body: SingleChildScrollView(
  //   child: SizedBox(
  //     width: double.infinity,
  //     child: Padding(
  //       padding: const EdgeInsets.all(24.0),
  //       child: Column(
  //         children: [
  //           const SizedBox(
  //             height: 30,
  //           ),
  //           Image.asset(
  //             'assets/img/dha_lahore_logo.png',
  //             width: 150,
  //           ),
  //           const SizedBox(height: 30),
  //           const Text(
  //             'Login',
  //             style: TextStyle(fontSize: 24),
  //           ),
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           const SizedBox(
  //             width: double.infinity,
  //             child: Text(
  //               'Enter DHA number',
  //               textAlign: TextAlign.start,
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 8,
  //           ),
  //           TextFormField(
  //             controller: dha_number,
  //             cursorColor: const Color(0xFF0F0A38),
  //             keyboardType: TextInputType.number,
  //             decoration: const InputDecoration(
  //               labelText: 'Enter number',
  //               labelStyle: TextStyle(
  //                 color: Color(0xFFC3C3C3),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                   color: Color(0xFFC3C3C3),
  //                 ),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                   color: Color(0xFF0F0A38),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 20,
  //           ),
  //           const SizedBox(
  //             width: double.infinity,
  //             child: Text(
  //               'Enter your password',
  //               textAlign: TextAlign.start,
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 8,
  //           ),
  //           TextFormField(
  //             controller: password_controller,
  //             obscureText: showText,
  //             cursorColor: const Color(0xFF0F0A38),
  //             decoration: InputDecoration(
  //               suffixIcon: IconButton(
  //                 icon: showText
  //                     ? const Icon(
  //                         Icons.visibility_outlined,
  //                         color: Color(0xFF0F0A38),
  //                       )
  //                     : const Icon(
  //                         Icons.visibility_off_outlined,
  //                         color: Color(0xFF0F0A38),
  //                       ),
  //                 onPressed: () {
  //                   setState(() {
  //                     showText = !showText;
  //                   });
  //                 },
  //               ),
  //               labelText: 'Enter password',
  //               labelStyle: const TextStyle(
  //                 color: Color(0xFFC3C3C3),
  //               ),
  //               enabledBorder: const OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                   color: Color(0xFFC3C3C3),
  //                 ),
  //               ),
  //               focusedBorder: const OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                   color: Color(0xFF0F0A38),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 80,
  //           ),
  //           SizedBox(
  //             width: double.infinity,
  //             child: ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: const Color(0xFF0F0A38),
  //                 padding: const EdgeInsets.symmetric(
  //                     vertical: 18, horizontal: 0),
  //               ),
  //               onPressed: () {
  //                 validate();
  //               },
  //               child: const Text(
  //                 'Login',
  //                 style: TextStyle(fontSize: 20),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 80),
  //           Image.asset(
  //             'assets/img/pitb_logo.png',
  //             width: 40,
  //           ),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           const Text('Powered By PITB'),
  //         ],
  //       ),
  //     ),
  //   ),
  // ),
//     );
//   }
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
