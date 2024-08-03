import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:agri_ai/app/components/gradient_text.dart';
import 'package:agri_ai/app/components/gradient_underline_text.dart';
import '../controllers/auth_login_controller.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../routes/app_pages.dart';

class AuthLoginView extends GetView<AuthLoginController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 16,
                bottom: 16,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(text: 'Welcome'),
                  GradientText(text: 'Back!'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              margin: const EdgeInsets.all(3), // Border width
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      autocorrect: false,
                      controller: controller.emailC,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() => TextField(
                          autocorrect: false,
                          controller: controller.passwordC,
                          textInputAction: TextInputAction.done,
                          obscureText: controller.isHidden.value,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => controller.isHidden.toggle(),
                              icon: Icon(
                                controller.isHidden.isTrue
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                               
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 243, 33, 173),
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2),
                            ),
                          ),
                        )),
                    const SizedBox(height: 30),
                    Obx(() => ElevatedButton(
                          onPressed: () async {
                            if (controller.isLoading.isFalse) {
                              bool? cekAutoLogout = await controller.login();
                              if (cekAutoLogout != null &&
                                  cekAutoLogout == true) {
                                await authC.logout();
                                Get.offAllNamed(Routes.HOME);
                              }
                            }
                          },
                          child: Text(
                            controller.isLoading.isFalse
                                ? "Login"
                                : "Loading...",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38.0),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                        )),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child:
                              Text("OR", style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.g_mobiledata,
                            ),
                            label:  Text(
                              "Google".tr,
                           
                            ),
                            onPressed: () {
                              // Add Google sign-up logic here
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.white),
                                     
                            ),
                            
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon:
                                const Icon(Icons.facebook, color: Colors.white),
                            label: Text(
                              "Facebook".tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              // Add Facebook sign-up logic here
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.blue[800]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
