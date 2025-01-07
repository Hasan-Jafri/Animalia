import 'package:animalia/components/elevated_button.dart';
import 'package:animalia/components/text_form.dart';
import 'package:animalia/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerWidget {
  SignupPage({super.key});
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: blackOlive,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo or something
              const Icon(
                Icons.lock_open_rounded,
                size: 100,
                color: artichoke,
              ),
              const SizedBox(
                height: 50,
              ),
              TextForm(controller: userController, hintText: "Username"),

              const SizedBox(
                height: 20,
              ),
              TextForm(controller: emailController, hintText: "Email"),

              const SizedBox(
                height: 20,
              ),
              TextForm(
                controller: passController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomElevatedButton(text: "Sign Up", onpressed: () {}),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: artichoke,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: artichoke, fontWeight: FontWeight.bold),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/login'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
