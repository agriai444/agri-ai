// more_view.dart
import 'package:agri_ai/app/controllers/auth_controller.dart';
import 'package:agri_ai/app/modules/more/views/widgets/menu_item_widget.dart';
import 'package:agri_ai/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/more_controller.dart';

class MoreView extends GetView<MoreController> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
       final MoreController controller = Get.put(MoreController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const UserProfileWidget(),
              SizedBox(height: 20.h),
              MenuItemWidget(
                icon: Icons.person,
                title: 'Profile'.tr,
                onTap: () {
                  Get.to(Routes.PROFILE);
                },
              ),
              MenuItemWidget(
                icon: Icons.settings,
                title: 'Settings'.tr,
                onTap: () {
                  // Handle settings tap
                },
              ),
              MenuItemWidget(
                icon: Icons.star,
                title: 'Rate our app'.tr,
                onTap: controller.rateApp,
              ),
              MenuItemWidget(
                icon: Icons.share,
                title: 'Share the app'.tr,
                onTap: controller.shareApp,
              ),
              // MenuItemWidget(
              //   icon: Icons.phone,
              //   title: 'Contact us'.tr,
              //   onTap: () {
              //     // Handle contact us tap
              //   },
              // ),

              MenuItemWidget(
                icon: Icons.logout,
                title: 'Logout'.tr,
                onTap: () async {
                  await authController.logout();
                
                },
                textColor: Colors.red,
                iconColor: Colors.red,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.person, size: 50.r, color: Colors.grey[600]),
        ),
        SizedBox(height: 10.h),
        Text(
          'Mohammed Foud',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
