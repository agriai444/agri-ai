import 'package:get/get.dart';

import '../modules/auth/login/bindings/auth_login_binding.dart';
import '../modules/auth/login/views/auth_login_view.dart';
import '../modules/auth/otp/bindings/auth_otp_binding.dart';
import '../modules/auth/otp/views/auth_otp_view.dart';
import '../modules/auth/signup/bindings/auth_signup_binding.dart';
import '../modules/auth/signup/views/auth_signup_view.dart';
import '../modules/chat/agri_chat/bindings/chat_agri_chat_binding.dart';
import '../modules/chat/agri_chat/views/chat_agri_chat_view.dart';
import '../modules/chat/ai_chat/bindings/chat_ai_chat_binding.dart';
import '../modules/chat/ai_chat/views/chat_ai_chat_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction_animation/bindings/introduction_animation_binding.dart';
import '../modules/introduction_animation/views/introduction_animation_view.dart';
import '../modules/more/bindings/more_binding.dart';
import '../modules/more/views/more_view.dart';
import '../modules/plans/bindings/plans_binding.dart';
import '../modules/plans/views/plans_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash_page/bindings/splash_page_binding.dart';
import '../modules/splash_page/views/splash_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const IntroductionAnimation = Routes.IntroductionAnimation;
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.IntroductionAnimation,
      page: () => const IntroductionAnimationView(),
      binding: IntroductionAnimationBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_LOGIN,
      page: () => AuthLoginView(),
      binding: AuthLoginBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_SIGNUP,
      page: () =>  AuthSignupView(),
      binding: AuthSignupBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_OTP,
      page: () => const AuthOtpView(),
      binding: AuthOtpBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_PAGE,
      page: () => SplashPageView(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_AI_CHAT,
          page: () {
       
        return ChatAiChatView();
      },

      binding:ChatAiChatBinding()  ,
    ),
    GetPage(
      name: _Paths.CHAT_AGRI_CHAT,
      page: () => const ChatAgriChatView(),
      binding: ChatAgriChatBinding(),
    ),
    GetPage(
      name: _Paths.PLANS,
      page: () => const PlansView(),
      binding: PlansBinding(),
    ),
    GetPage(
      name: _Paths.MORE,
      page: () =>  MoreView(),
      binding: MoreBinding(),
    ),
  ];
}
