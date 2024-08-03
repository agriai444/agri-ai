// welcome_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeChat extends StatelessWidget {
  const WelcomeChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image logo
        Image.asset(
          'assets/logo.png', 
          width: 100.w,
          height: 100.h,
        ),
        SizedBox(height: 20.h),
        // Bold welcome message
        Text(
          'Welcome',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        // Description text
        Text(
          'You can chat and get help for your plants.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
