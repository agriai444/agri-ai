import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthLoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<bool?> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await client.auth
            .signInWithPassword(email: emailC.text, password: passwordC.text);
        isLoading.value = false;
       
        return true;
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("ERROR", e.toString());
      }
    } else {
      Get.snackbar("ERROR", "Email and password are required");
    }
    return null;
  }
}
