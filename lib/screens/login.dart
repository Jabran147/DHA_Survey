import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/user_record.dart';
import './homepage.dart';

class LoginScreen extends StatefulWidget {
  UserRecord loginRecord = UserRecord();
  // LoginScreen({super.key, this.loginRecord});
  static const namedRoute = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    Hive.box<UserRecord>('userRecord');
    // widget.loginRecord?.dha_number = '1234';
    // widget.loginRecord?.password = 'admin';
    super.initState();
    // TODO: implement initState
  }

  void validate() {
    if (widget.loginRecord.dha_number != dha_number.text ||
        widget.loginRecord.password != password_controller.text) {
      print(widget.loginRecord.dha_number);
      _showMyDialog1();
    } else {
      Navigator.of(context).pushReplacementNamed(HomePage.namedRoute);
    }
  }

  Future<void> _showMyDialog1() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Enter the correct credentials'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool showText = true;
  TextEditingController dha_number = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0A38),
        centerTitle: true,
        title: const Text('DHA Maintenance'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/img/dha_lahore_logo.png',
                  width: 150,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Enter DHA number',
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: dha_number,
                  cursorColor: const Color(0xFF0F0A38),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter number',
                    labelStyle: TextStyle(
                      color: Color(0xFFC3C3C3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC3C3C3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0F0A38),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Enter your password',
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: password_controller,
                  obscureText: showText,
                  cursorColor: const Color(0xFF0F0A38),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: showText
                          ? const Icon(
                              Icons.visibility_outlined,
                              color: Color(0xFF0F0A38),
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                              color: Color(0xFF0F0A38),
                            ),
                      onPressed: () {
                        setState(() {
                          showText = !showText;
                        });
                      },
                    ),
                    labelText: 'Enter password',
                    labelStyle: const TextStyle(
                      color: Color(0xFFC3C3C3),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC3C3C3),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0F0A38),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F0A38),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 0),
                    ),
                    onPressed: () {
                      validate();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                Image.asset(
                  'assets/img/pitb_logo.png',
                  width: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Powered By PITB'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
