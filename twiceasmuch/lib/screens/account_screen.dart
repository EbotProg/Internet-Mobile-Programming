import 'package:flutter/material.dart';
import 'package:twiceasmuch/auth/user_auth.dart';
import 'package:twiceasmuch/db/user_db_methods.dart';
import 'package:twiceasmuch/global.dart';
import 'package:twiceasmuch/screens/auth_start_screen.dart';
import 'package:twiceasmuch/utilities/pick_image.dart';
import 'package:twiceasmuch/widgets/dialog.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isUploadingImage = false;
  final imagePicker = PickImage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        backgroundColor: const Color(0xff292E2A),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile Picture',
                    style: TextStyle(fontSize: 18),
                  ),
                  if (globalUser!.picture != null)
                    GestureDetector(
                      onTap: () async {
                        await UserDBMethods().updateUser(
                          globalUser!..picture = null,
                        );
                      },
                      child: const SizedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                            Text(
                              'Remove',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
              const Divider(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: isUploadingImage
                    ? () {}
                    : () {
                        showModalBottomSheet(
                            isDismissible: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 100,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              globalUser?.imageFile =
                                                  await imagePicker
                                                      .pickImageFromCamera();

                                              if (globalUser?.imageFile !=
                                                  null) {
                                                setState(() {
                                                  isUploadingImage = true;
                                                });
                                                await UserDBMethods()
                                                    .updateUser(globalUser!);
                                                setState(() {
                                                  isUploadingImage = false;
                                                });
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.camera,
                                              color: Color(0xff292E2A),
                                              size: 30,
                                            )),
                                        const Text(
                                          "Camera",
                                          style: TextStyle(
                                            fontFamily: 'DmSans',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              globalUser?.imageFile =
                                                  await imagePicker
                                                      .pickImageFromGallery();
                                              if (globalUser?.imageFile !=
                                                  null) {
                                                setState(() {
                                                  isUploadingImage = true;
                                                });
                                                await UserDBMethods()
                                                    .updateUser(globalUser!);
                                                setState(() {
                                                  isUploadingImage = false;
                                                });
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.photo,
                                              color: Color(0xff292E2A),
                                              size: 30,
                                            )),
                                        const Text(
                                          "Gallery",
                                          style: TextStyle(
                                            fontFamily: 'DmSans',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  clipBehavior: Clip.hardEdge,
                  height: 200,
                  width: 200,
                  child: isUploadingImage
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : AspectRatio(
                          aspectRatio: 3 / 4,
                          child: globalUser?.picture != null
                              ? Image.network(
                                  globalUser!.picture!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/profile.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Account Info',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.blueAccent,
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Divider(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Username",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(globalUser!.username ?? ''),
                        ],
                      ),
                      if (globalUser?.location != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Location ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(globalUser!.location ?? '')
                          ],
                        ),
                      if (globalUser?.phoneNumber != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Phone Number",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(globalUser!.phoneNumber ?? '')
                          ],
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(globalUser!.email ?? ''),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () async {
              final result = await showDialog(
                  context: context,
                  builder: (c) {
                    return MyDialog(
                      title: 'Logout',
                      description: 'Are you sure you want to logout?',
                      onContinue: () async {
                        await UserAuthentication().signOut();
                      },
                      continueText: 'Logout',
                      continueColor: Colors.red,
                    );
                  });
              if (result == true) {
                Navigator.of(context)
                  ..popUntil((route) => false)
                  ..push(MaterialPageRoute(
                    builder: (c) => const AuthStartScreen(),
                  ));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
