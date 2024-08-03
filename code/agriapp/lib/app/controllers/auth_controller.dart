import 'package:get/get.dart';
import 'package:agri_ai/app/routes/app_pages.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  SupabaseClient client = Supabase.instance.client;
  Rx<User?> user = Rx<User?>(Supabase.instance.client.auth.currentUser);

  @override
  void onInit() {
    super.onInit();
    // _listenAuthState();
  }

  void _listenAuthState() {
    client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      user.value = session?.user;

      if (event == AuthChangeEvent.signedIn) {
        // Handle signIn event
        Get.offAllNamed(
            Routes.HOME); // Navigate to home screen or desired screen
      } else if (event == AuthChangeEvent.signedOut) {
        // Handle signOut event
        Get.offAllNamed(Routes.AUTH_LOGIN);
      }
    });
  }

  Future<void> logout() async {
    await client.auth.signOut();
      Get.offAllNamed(Routes.AUTH_LOGIN);
  }

  bool isLogin() {
    print(client.auth.currentUser);
    return client.auth.currentUser != null;

  }

  Future<bool> isAgriculturalExpert() async {
    if (user.value != null) {
      final response = await client
          .from('profiles')
          .select('is_agricultural_expert')
          .eq('id', user.value!.id)
          .single();
         

      if (response != null) {
        return response['is_agricultural_expert'] == true;
      } else {
        // Handle error or return false if the user is not found or not an expert
        return false;
      }
    }
    return false;
  }
}
