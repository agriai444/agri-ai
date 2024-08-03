import 'package:agri_ai/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthSignupController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  RxBool showGenderDropdownMargin = false.obs;

  PageController pageController = PageController();
  RxInt currentStep = 0.obs;

  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  RxString firstNameError = ''.obs;
  RxString lastNameError = ''.obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  SupabaseClient client = supabaseClient!;

  @override
  void onInit() {
    super.onInit();
    firstNameFocus.addListener(() {
      if (!firstNameFocus.hasFocus) validateFirstName();
    });
    lastNameFocus.addListener(() {
      if (!lastNameFocus.hasFocus) validateLastName();
    });
    emailFocus.addListener(() {
      if (!emailFocus.hasFocus) validateEmail();
    });
    passwordFocus.addListener(() {
      if (!passwordFocus.hasFocus) validatePassword();
    });
   confirmPasswordC.addListener(validateConfirmPassword);


    // Add listeners for text changes
    firstNameC.addListener(validateFirstName);
    lastNameC.addListener(validateLastName);
    emailC.addListener(validateEmail);
    passwordC.addListener(validatePassword);
    confirmPasswordC.addListener(validateConfirmPassword);
  }

  void validateFirstName() {
    if (firstNameC.text.isEmpty) {
      firstNameError.value = 'First Name cannot be empty';
    } else {
      firstNameError.value = '';
    }
  }

  void validateLastName() {
    if (lastNameC.text.isEmpty) {
      lastNameError.value = 'Last Name cannot be empty';
    } else {
      lastNameError.value = '';
    }
  }

  void validateEmail() {
    if (!GetUtils.isEmail(emailC.text)) {
      emailError.value = 'Invalid email format';
    } else {
      emailError.value = '';
    }
  }

  void validatePassword() {
    if (passwordC.text.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
    } else {
      passwordError.value = '';
    }
  }

  void validateConfirmPassword() {
    if (passwordC.text != confirmPasswordC.text) {
      confirmPasswordError.value = 'Passwords do not match';
    } else {
      confirmPasswordError.value = '';
    }
  }

  bool canProceed() {
    if (currentStep.value == 0) {
      return firstNameError.value.isEmpty && lastNameError.value.isEmpty;
    } else if (currentStep.value == 1) {
      return genderC.text.isNotEmpty;
    }
    return true;
  }

  bool canSubmit() {
    return emailError.value.isEmpty &&
        passwordError.value.isEmpty &&
        confirmPasswordError.value.isEmpty &&
        !isLoading.value;
  }

  void nextPage() {
    if (currentStep.value < 2) {
      currentStep.value++;
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void previousPage() {
    if (currentStep.value > 0) {
      currentStep.value--;
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  Future<void> signUp() async {
    if (canSubmit()) {
      isLoading.value = true;
      try {
        AuthResponse res = await client.auth.signUp(
          email: emailC.text,
          password: passwordC.text,
          data: {
            'first_name': firstNameC.text,
            'last_name': lastNameC.text,
            'avatar_url': '',
            'state': true,
            'gender': genderC.text,
            'user_type': 'Client',
            'country': countryC.text,
          },
        );
        isLoading.value = false;

        Get.defaultDialog(
          barrierDismissible: false,
          title: "Registration success",
          middleText:
              "Please confirm email: ${res.user!.email} ${res.user?.userMetadata}",
          actions: [
            OutlinedButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text("OK"),
            )
          ],
        );
      } catch (e) {
        isLoading.value = false;
        Get.defaultDialog(
          barrierDismissible: false,
          title: "Registration Failed",
          middleText: e.toString(),
          actions: [
            OutlinedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("OK"),
            )
          ],
        );
      }
    } else {
      Get.snackbar("ERROR", "Please fill all fields correctly");
    }
  }
}

// class AuthSignupController extends GetxController {
//   RxBool isLoading = false.obs;
//   RxBool isHidden = true.obs;
//   RxBool showGenderDropdownMargin = false.obs;

//   PageController pageController = PageController();
//   RxInt currentStep = 0.obs;

//   TextEditingController firstNameC = TextEditingController();
//   TextEditingController lastNameC = TextEditingController();
//   // TextEditingController dateOfBirthC = TextEditingController();
//   TextEditingController countryC = TextEditingController();
//   TextEditingController genderC = TextEditingController();
//   TextEditingController emailC = TextEditingController();
//   TextEditingController passwordC = TextEditingController();
//   TextEditingController confirmPasswordC = TextEditingController();

//   RxString firstNameError = ''.obs;
//   RxString lastNameError = ''.obs;
//   RxString emailError = ''.obs;
//   RxString passwordError = ''.obs;
//   RxString confirmPasswordError = ''.obs;

//   FocusNode firstNameFocus = FocusNode();
//   FocusNode lastNameFocus = FocusNode();
//   FocusNode emailFocus = FocusNode();
//   FocusNode passwordFocus = FocusNode();
//   FocusNode confirmPasswordFocus = FocusNode();

//   // SupabaseClient client = Supabase.instance.client;
//   SupabaseClient client = supabaseClient!;
//   @override
//   void onInit() {
//     super.onInit();
//     firstNameC.addListener(validateFirstName);
//     lastNameC.addListener(validateLastName);
//     emailC.addListener(validateEmail);
//     passwordC.addListener(validatePassword);
//     confirmPasswordC.addListener(validateConfirmPassword);
//     // dateOfBirthC.addListener(validateDateOfBirth);
//   }

//   void validateFirstName() {
//     if (firstNameC.text.isEmpty) {
//       firstNameError.value = 'First Name cannot be empty';
//     } else {
//       firstNameError.value = '';
//     }
//   }

//   void validateLastName() {
//     if (lastNameC.text.isEmpty) {
//       lastNameError.value = 'Last Name cannot be empty';
//     } else {
//       lastNameError.value = '';
//     }
//   }

//   void validateEmail() {
//     if (!GetUtils.isEmail(emailC.text)) {
//       emailError.value = 'Invalid email format';
//     } else {
//       emailError.value = '';
//     }
//   }

//   void validatePassword() {
//     if (passwordC.text.length < 8) {
//       passwordError.value = 'Password must be at least 8 characters';
//     } else {
//       passwordError.value = '';
//     }
//   }

//   void validateConfirmPassword() {
//     if (passwordC.text != confirmPasswordC.text) {
//       confirmPasswordError.value = 'Passwords do not match';
//     } else {
//       confirmPasswordError.value = '';
//     }
//   }

//   bool canProceed() {
//     if (currentStep.value == 0) {
//       return firstNameError.value.isEmpty && lastNameError.value.isEmpty;
//     } else if (currentStep.value == 1) {
//       return genderC.text.isNotEmpty;
//     }
//     return true;
//   }

//   bool canSubmit() {
//     return emailError.value.isEmpty &&
//         passwordError.value.isEmpty &&
//         confirmPasswordError.value.isEmpty &&
//         !isLoading.value;
//   }

//   void nextPage() {
//     if (currentStep.value < 2 && canProceed()) {
//       currentStep.value++;
//       pageController.nextPage(
//           duration: const Duration(milliseconds: 300), curve: Curves.ease);
//     }
//   }

//   void previousPage() {
//     if (currentStep.value > 0) {
//       currentStep.value--;
//       pageController.previousPage(
//           duration: const Duration(milliseconds: 300), curve: Curves.ease);
//     }
//   }

//   Future<void> signUp() async {
//     if (canSubmit()) {
//       isLoading.value = true;
//       try {
//         // String formattedDateOfBirth;

//         // try {
//         //   // Parse the input date
//         //   DateTime parsedDate = DateFormat('MM-dd-yyyy').parse(dateOfBirthC.text);
//         //   // Format the date to the required format
//         //   formattedDateOfBirth = DateFormat('MM-dd-yyyy').format(parsedDate);
//         // } catch (parseError) {
//         //   isLoading.value = false;
//         //   Get.snackbar("ERROR", "Invalid date format. Please use MM-dd-yyyy.");
//         //   return;
//         // }

//         // // Debugging: Print date values
//         // print("Date of Birth (Input): ${dateOfBirthC.text}");
//         // print("Date of Birth (Formatted): $formattedDateOfBirth");

//         AuthResponse res = await client.auth.signUp(
//           email: emailC.text,
//           password: passwordC.text,
//           data: {
//             'first_name': firstNameC.text,
//             'last_name': lastNameC.text,
//             'avatar_url': '',
//             'state': true,
//             'gender': genderC.text,
//             'user_type': 'Client',
//             'country': countryC.text,
//           },
//         );
//         isLoading.value = false;

//         Get.defaultDialog(
//           barrierDismissible: false,
//           title: "Registration success",
//           middleText:
//               "Please confirm email: ${res.user!.email} ${res.user?.userMetadata}",
//           actions: [
//             OutlinedButton(
//               onPressed: () {
//                 Get.back();
//                 Get.back();
//               },
//               child: const Text("OK"),
//             )
//           ],
//         );
//       } catch (e) {
//         isLoading.value = false;
//         Get.defaultDialog(
//           barrierDismissible: false,
//           title: "Registration Failed",
//           middleText: e.toString(),
//           actions: [
//             OutlinedButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: const Text("OK"),
//             )
//           ],
//         );
       
//       }
//     } else {
//       Get.snackbar("ERROR", "Please fill all fields correctly");
//     }
//   }
// }
