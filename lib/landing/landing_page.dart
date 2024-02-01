import 'package:easy_khata/home/home_page.dart';
import 'package:easy_khata/util/myshared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final customerName = TextEditingController();
    final customerPhoneNumber = TextEditingController();
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        padding: EdgeInsets.all(screenSize.width * 0.05),
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 200,
                    width: screenSize.width,
                    child: Image.asset('assets/app_logo.png')),
                SizedBox(
                  width: screenSize.width,
                  child: Center(
                    child: Text(
                      "Easy Khata Book",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * .05,
                ),
                const Text(
                  "Your Name/Business Name",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 25,
                  controller: customerName,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your Name/Business Name',
                  ),
                ),
                const Text("Your Phone Number",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 15,
                  controller: customerPhoneNumber,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Your Phone Number',
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                SizedBox(
                  width: screenSize.width,
                  child: ElevatedButton(
                      onPressed: () {
                        if (customerName.value.text.isNotEmpty &&
                            customerPhoneNumber.value.text.isNotEmpty) {
                          MySharedPreference.setUserName(
                              customerName.value.text);
                          MySharedPreference.setPhoneNumber(
                              customerPhoneNumber.value.text);
                          MySharedPreference.setUserLogin(true);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const HomePage(title: "Easy Khata"),
                              ),
                              ModalRoute.withName("/Home"));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please fill details")));
                        }
                      },
                      child: const Text("Create Account")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
