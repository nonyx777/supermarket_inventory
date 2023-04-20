import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket_inventory/color/color.dart';

File? imgFile;
String? imgPath;

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: height * 0.15,
          width: width * 0.3,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              if (imgPath != null)
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Image.file(
                    File(imgPath!),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: height * 0.05,
                  width: width * 0.1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: pureWhite),
                      ),
                      backgroundColor: pureWhite,
                    ),
                    onPressed: () async {
                      selectImage();
                      setState(() {});
                    },
                    child: Image.asset("images/edit.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(user.email!),
        ElevatedButton(
          onPressed: () {
            deleteData();
          },
          child: Text("Delete image"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(dangerRed),
          ),
        )
      ],
    );
  }

// Select Image
  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            getImgFromGallery();
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/gallery.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            getImgFromCamera();
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void getImgFromGallery() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      saveData(pickedImage.path.toString()); // path cache
      setState(() {
        imgFile = File(pickedImage.path);
      });
    }
  }

  void getImgFromCamera() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      saveData(pickedImage.path.toString()); // path cache
      setState(() {
        imgFile = File(pickedImage.path);
      });
    }
  }

  void saveData(String val) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('path', val);
    getData();
  }

  void getData() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      imgPath = sharedPref.getString('path');
    });
  }

  void deleteData() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove('path');
    getData();
  }
}
