import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_cart_w_getstorage/controller/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  late AuthController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.find<AuthController>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            const Center(
              child: Text("EVIKE.COM",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      fontSize: 40)),
            ),
            const SizedBox(height: 50.0),
            Form(
              key: controller.globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                      filled: true,
                      fillColor: Colors.white24,
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.white),
                      errorStyle: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(
                        color: Colors.white, fontFamily: "poppins"),
                    validator: (String? val) =>
                        val!.trim().isEmpty ? "Please insert name" : null,
                    onSaved: (String? value) {
                      controller.name = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                      filled: true,
                      fillColor: Colors.white24,
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                      errorStyle: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(
                        color: Colors.white, fontFamily: "poppins"),
                    validator: (String? val) =>
                        val!.trim().isEmpty ? "Please insert email" : null,
                    onSaved: (String? value) {
                      controller.email = value!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Obx(
                    () => TextFormField(
                      obscureText: controller.isObsecure.value,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                        filled: true,
                        fillColor: Colors.white24,
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white),
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.toggleObsecure();
                          },
                          child: controller.isObsecure.value
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      style: const TextStyle(
                          color: Colors.white, fontFamily: "poppins"),
                      validator: (String? val) =>
                          val!.trim().isEmpty ? "Please insert password" : null,
                      onSaved: (String? value) {
                        controller.password = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  ElevatedButton(
                    onPressed: () {
                      controller.saveSession();
                    },
                    child: Container(
                      width: double.infinity,
                      child: Center(child: Text("Submit")),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
