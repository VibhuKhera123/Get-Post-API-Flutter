import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loginapi/list_data.dart';
import 'package:loginapi/url_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController name;
  late final TextEditingController job;

  @override
  void initState() {
    name = TextEditingController();
    job = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    job.dispose();
    super.dispose();
  }

  Future addYourName() async {
    final response = await http.post(Uri.parse(adduser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name.text,
          'job': job.text,
        }));
    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: "Name added successfuly");
      debugPrint(response.body);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.5,
              width: screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login.png"),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add your Self",
                    style: GoogleFonts.lato(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 92, 9, 201),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      hintText: "Enter your name",
                      labelText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: job,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      hintText: 'Enter your job',
                      labelText: 'Job',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      try {
                        addYourName();
                        Get.to(
                          () => const UserListScreen(),
                          transition: Transition.leftToRight,
                          duration: const Duration(milliseconds: 1500)
                        );
                      } catch (e) {
                        Fluttertoast.showToast(msg: "e");
                      }
                    },
                    child: Container(
                      height: 40,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: const Center(
                          child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
