import 'package:animalia/API/apiService.dart';
import 'package:animalia/components/elevated_button.dart';
import 'package:animalia/components/loader.dart';
import 'package:animalia/components/text_form.dart';
import 'package:animalia/globals/globals.dart';
import 'package:animalia/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isLoading = false;
  Future<void> loginUser(String email, String password, WidgetRef ref) async {
    await postAPI(
        url: 'users/login',
        body: {
          "email": email,
          'password': password,
        },
        onSuccess: (res) {
          user.email = res['email']; // Use map key access
          user.token = res['token'];
          user.userID = res['userId'];
          user.username = res['username'];
          user.loggedIn = true;
        },
        onFailure: () {
          print("Failed");
        });
    await Future.delayed(Duration(seconds: 5));
    ref.read(loaderProvider.notifier).hideLoader();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loaderProvider);
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
              CustomElevatedButton(
                  text: "Sign In",
                  onpressed: () {
                    // ref.read(loaderProvider.notifier).showLoader();
                    // loginUser(emailController.text, passController.text, ref);

                    // if (user.loggedIn) {
                    //   Navigator.pushNamed(context, '/home');
                    // }
                    Navigator.pushNamed(context, '/home');
                  }),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Dont't have an account?",
                    style: TextStyle(
                      color: artichoke,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                          color: artichoke, fontWeight: FontWeight.bold),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                  )
                ],
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(), // Loader
                ),
            ],
          ),
        ),
      ),
    );
  }
}
