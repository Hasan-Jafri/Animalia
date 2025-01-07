import 'dart:io';

import 'package:animalia/components/elevated_button.dart';
import 'package:animalia/globals/globals.dart';
import 'package:animalia/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    double SCREEN_WIDTH = MediaQuery.of(context).size.width;
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
          backgroundColor: camoGreen,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                selectedImage == null
                    ? Image.asset(
                        'assets/lottie/home_page.gif',
                        height: SCREEN_WIDTH * 0.4,
                        width: SCREEN_WIDTH * 0.4,
                      )
                    : Stack(
                        children: [
                          Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  oliveDrabCamo,
                                  artichoke,
                                  oliveDrabCamo
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(
                              height: 250,
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  selectedImage!,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fill,
                                ),
                              )),
                          Positioned.fill(
                            child: Opacity(
                              opacity: 0.9, // Adjust for subtlety
                              child: Image.asset(
                                'assets/images/jungle_texture.png',
                                height: 250,
                                width:
                                    250, // Use a subtle jungle-themed texture
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                    onpressed: () {
                      _pickImageFromGallery();
                    },
                    backgroundColor: blackOlive,
                    height: SCREEN_WIDTH * 0.15,
                    width: SCREEN_WIDTH * 0.75,
                    textColor: blackOlive,
                    borderRadius: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          selectedImage == null
                              ? const Text(
                                  "Get to know something new",
                                  style:
                                      TextStyle(color: artichoke, fontSize: 20),
                                )
                              : const Text(
                                  "Take another shot",
                                  style:
                                      TextStyle(color: artichoke, fontSize: 20),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            'assets/images/gallery.png',
                            height: 30,
                          )
                        ],
                      ),
                    )),
                // const Spacer(),
                selectedImage == null
                    ? const SizedBox()
                    : Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(top: 50),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: SCREEN_WIDTH * 0.35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: const DecorationImage(
                                      opacity: 0.9,
                                      image: AssetImage(
                                          'assets/images/button_background.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                            CustomElevatedButton(
                              width: SCREEN_WIDTH * 0.35,
                              height: 25,
                              borderRadius: 50,
                              backgroundColor: Colors.transparent,
                              onpressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Lets Find Out",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                    Image.asset(
                                      'assets/lottie/right_arrow.gif',
                                      height: 30,
                                      width: 40,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          )),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      setState(() {
        selectedImage = File(returnedImage.path);
      });
    }
  }
}
