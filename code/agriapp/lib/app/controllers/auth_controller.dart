import 'package:agri_ai/app/data/local/my_hive.dart';
import 'package:agri_ai/app/data/providers/app_setting_provider.dart';
import 'package:agri_ai/app/modules/chat/controllers/chat_ai_chat_controller.dart';
import 'package:agri_ai/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agri_ai/app/routes/app_pages.dart';
import 'package:restart_app/restart_app.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agri_ai/app/data/models/user_model.dart' as local_user;
class AuthController extends GetxController {
   SupabaseClient client = Supabase.instance.client;
 Rx<local_user.User?> user = Rx<local_user.User?>(MyHive.getCurrentUser());


  // void _listenAuthState() {
  //   supabase.auth.onAuthStateChange.listen((data) {
  //     final AuthChangeEvent event = data.event;
  //     final Session? session = data.session;

  //     user.value = session?.user;

  //     if (event == AuthChangeEvent.signedIn) {
  //       Get.offAllNamed(Routes.HOME);
  //     } else if (event == AuthChangeEvent.signedOut) {
  //       Get.offAllNamed(Routes.AUTH_LOGIN);
  //     }
  //   });
  // }

String getCurrentUserId()  {
    return user.value?.id ?? '';
  }


Future<void> logout() async {
  await supabase.auth.signOut();         
  await MyHive.deleteCurrentUser();   
  // Get.delete<ChatAiChatController>(force: true);    
    // Get.deleteAll(force: true);
    // Get.reset();
//  Restart.restartApp();
             // Restart the app
  Get.offAllNamed(Routes.AUTH_LOGIN);
}

  Future<bool> isLogin() async {
    return user.value != null;
  }


 Future<String?> getAvatarUser(String userId) async {
   
      final response = await supabase
          .from('users')
          .select('avatar_url')
          .eq('id', userId)
          .single();

      return response['avatar_url'];
   
  }
  
  Future<String?> getUserType() async {
    if (user.value != null) {
      final response = await supabase
          .from('users')
          .select('user_type')
          .eq('id', user.value?.id ?? '')
          .single();

      return response['user_type'];
        }
    return null;
  }

  bool isUserAgri() {
    
    if (user.value != null) {
      
      return user.value!.userType == 'Agri-Expert';
    }
    return false;
  }

  bool isUserClient() {
    
    if (user.value != null) {
      
      return user.value!.userType == 'Client';
    }
    return false;
  }
   
       
   
    
   

  Future<bool> isAgriculturalExpert() async {
    final userType = await getUserType();
    return userType == 'Agri-Expert';
  }

  Future<bool> isAdmin() async {
    final userType = await getUserType();
    return userType == 'Admin';
  }

  Future<bool> isClient() async {
    final userType = await getUserType();
    return userType == 'Client';
  }



 /// Refresh user data from Supabase or Hive
  Future<void> refreshUser() async {
    final currentUser = MyHive.getCurrentUser();
    if (currentUser != null) {
      final response = await client
          .from('users')
          .select()
          .eq('id', user.value?.id ?? '')
          .single();
      
      // Assuming response contains the user data in a suitable format
      local_user.User updatedUser = local_user.User(
        id: response['id'],
        firstName: response['first_name'],
        lastName: response['last_name'],
        gender: response['gender'],
        userType: response['user_type'],
        country: response['country'],
        createdAt: response['created_at'],
        updatedAt: response['updated_at'],
      );

      user.value = updatedUser;

      // Optionally save to Hive for persistence
      await MyHive.saveUserToHive(updatedUser);
        }
  }
}
