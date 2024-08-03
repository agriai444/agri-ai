import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:agri_ai/utils/awesome_notifications_helper.dart';
import 'app/data/local/my_hive.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/data/models/user_model.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';
import 'config/translations/localization_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../app/controllers/auth_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';  

SupabaseClient? supabaseClient;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize local db (hive) and register our custom adapters
  await MyHive.init(
    registerAdapters: (hive) {
      hive.registerAdapter(UserAdapter());
    }
  );

  // init shared preference
  await MySharedPref.init();

  
  await dotenv.load(); 

  String supaUri = dotenv.get('SUPABASE_URL'); 
  String supaAnon = dotenv.get('SUPABASE_ANONKEY');

  await Supabase.initialize(
    url: supaUri,
    anonKey: supaAnon,
  );
  supabaseClient = SupabaseClient(supaUri, supaAnon);

  final authC = Get.put(AuthController(), permanent: true);

  // Hide the keyboard if it's showing
  SystemChannels.textInput.invokeMethod('TextInput.hide');

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          title: "Agricultural Expert",
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            bool themeIsLight = MySharedPref.getThemeIsLight();
            return Theme(
              data: MyTheme.getThemeData(isLight: themeIsLight),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              ),
            );
          },
          initialRoute: Routes.SPLASH_PAGE,
          getPages: AppPages.routes, 
          locale: MySharedPref.getCurrentLocal(),
          translations: LocalizationService.getInstance(),
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
        );
      },
    ),
  );
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
