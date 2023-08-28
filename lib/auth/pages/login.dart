import 'package:codroid_hub/auth/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_controller.dart';

class CustomAlertBox extends ConsumerStatefulWidget {
  const CustomAlertBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomAlertBoxState();
}

class _CustomAlertBoxState extends ConsumerState<CustomAlertBox> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authControllerProvider.notifier);
    final isLoadingState = ref.watch(authControllerProvider);

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 140),
      title: const Center(child: Text("Login to CodroidHUb")),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text("Username")),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(Icons.email_outlined)),
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 400,
                      child: TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (value.isValidEmail == false) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            hintText: 'Email'),
                      )),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text("Password")),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(Icons.password)),
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 400,
                      child: TextFormField(
                        controller: pass,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length > 8) {
                              return "Please enter 8 digit password";
                            }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: 'Enter your password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {}, child: const Text("Forgot Password ?"))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Success"),
                              content:
                                  const Text("Form Submitted Successfully"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"))
                              ],
                            );
                          });
                    }
                  },
                  child: const Text("Login")),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("NEW USER?"),
                TextButton(
                    onPressed: () {},
                    child: TextButton(
                        onPressed: () => showDialogSignUp(context),
                        child: Text('Sign up',
                            style: TextStyle(color: Colors.blue))))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showDialogLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertBox();
    },
  );
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }
}
