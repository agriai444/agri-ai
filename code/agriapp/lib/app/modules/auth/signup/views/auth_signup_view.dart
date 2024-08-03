import 'package:agri_ai/app/components/gradient_text.dart';
import 'package:agri_ai/app/components/gradient_underline_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../controllers/auth_signup_controller.dart';
class AuthSignupView extends GetView<AuthSignupController> {
  const AuthSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0.h),
                  child: Row(
                    children: [
                      Obx(() => Visibility(
                        visible: controller.currentStep.value > 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: controller.currentStep.value > 0 ? controller.previousPage : null,
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(text: 'Create'),
                    GradientText(text: 'Account'),
                  ],
                ),
                SizedBox(height: 30.h),
                
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 160.h, 
                  ),
                  child: PageView(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      StepOne(controller: controller),
                      StepTwo(controller: controller),
                      StepThree(controller: controller),
                    ],
                  ),
                ),

              
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StepOne extends StatelessWidget {
  final AuthSignupController controller;
  const StepOne({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        children: [
          Obx(() => TextField(
            controller: controller.firstNameC,
            focusNode: controller.firstNameFocus,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'First Name',
              prefixIcon: const Icon(Icons.person),
              errorText: controller.firstNameError.value.isEmpty ? null : controller.firstNameError.value,
            ),
          )),
          SizedBox(height: 16.h),
          Obx(() => TextField(
            controller: controller.lastNameC,
            focusNode: controller.lastNameFocus,
            decoration: InputDecoration(
              labelText: 'Last Name',
              prefixIcon: const Icon(Icons.person),
              errorText: controller.lastNameError.value.isEmpty ? null : controller.lastNameError.value,
            ),
          )),
          SizedBox(height: 20.h),
          Obx(() => ElevatedButton(
            onPressed: controller.canProceed() ? controller.nextPage : null,
            child: Text("Next"),
          )),

   SizedBox(height: 20.h),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Colors.grey,
                   
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/login'), 
                    child: GradientUnderlineText(
                      text: 'Login',
                      style: TextStyle(
                  
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}

class StepTwo extends StatelessWidget {
  final AuthSignupController controller;
  const StepTwo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        children: [
          // TextField(
          //   controller: controller.dateOfBirthC,
          //   decoration:  const InputDecoration(
          //     labelText: 'Date of Birth',
          //     prefixIcon: Icon(Icons.calendar_today),
          //   ),
          //   readOnly: true,
          //   onTap: () async {
          //     DateTime? pickedDate = await showDatePicker(
          //       context: context,
          //       initialDate: DateTime.now(),
          //       firstDate: DateTime(1900),
          //       lastDate: DateTime.now(),
          //     );
          //     if (pickedDate != null) {
          //       String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
          //       controller.dateOfBirthC.text = formattedDate;
          //     }
          //   },
          // ),
          // SizedBox(height: 16.h),
          TextField(
            controller: controller.countryC,
            decoration: const InputDecoration(
              labelText: 'Country',
              prefixIcon: Icon(Icons.public),
            ),
            readOnly: true,
            onTap: () {
              showCountryPicker(
                context: context,
                onSelect: (Country country) {
                  controller.countryC.text = country.name;
                },
              );
            },
          ),
          SizedBox(height: 16.h),
          Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: controller.showGenderDropdownMargin.value ? EdgeInsets.only(bottom: 20.h) : EdgeInsets.zero,
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Gender',
                prefixIcon: Icon(Icons.person_outline),
              ),
              value: controller.genderC.text.isEmpty ? 'Male' : controller.genderC.text,
              items: ['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                controller.genderC.text = newValue ?? '';
                controller.showGenderDropdownMargin.value = newValue != null && newValue.isNotEmpty;
              },
            ),
          )),
          SizedBox(height: 20.h),
          Obx(() => ElevatedButton(
            onPressed: controller.canProceed() ? controller.nextPage : null,
            child: Text("Next"),
          )),
        ],
      ),
    );
  }
}

class StepThree extends StatelessWidget {
  final AuthSignupController controller;
  const StepThree({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        children: [
          Obx(() => TextField(
            controller: controller.emailC,
            focusNode: controller.emailFocus,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email),
              errorText: controller.emailError.value.isEmpty ? null : controller.emailError.value,
            ),
          )),
          SizedBox(height: 16.h),
          Obx(() => TextField(
            controller: controller.passwordC,
            focusNode: controller.passwordFocus,
            obscureText: controller.isHidden.value,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isHidden.value ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => controller.isHidden.toggle(),
              ),
              errorText: controller.passwordError.value.isEmpty ? null : controller.passwordError.value,
            ),
          )),
          SizedBox(height: 16.h),
          Obx(() => TextField(
            controller: controller.confirmPasswordC,
            focusNode: controller.confirmPasswordFocus,
            obscureText: controller.isHidden.value,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock),
              errorText: controller.confirmPasswordError.value.isEmpty ? null : controller.confirmPasswordError.value,
            ),
          )),
          SizedBox(height: 20.h),
          Obx(() => ElevatedButton(
            onPressed: controller.canSubmit() ? controller.signUp : null,
            child: Text(controller.isLoading.isFalse ? 'REGISTER' : 'Loading...'),
          )),
        ],
      ),
    );
  }
}
