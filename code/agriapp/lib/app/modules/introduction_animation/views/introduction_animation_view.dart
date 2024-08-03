import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../config/translations/strings_enum.dart';
import '../../../components/api_error_widget.dart';
import '../../../components/my_widgets_animator.dart';
import '../controllers/introduction_animation_controller.dart';
import 'introduction_animation_screen.dart';
import 'widgets/data_grid.dart';
import 'widgets/employees_list.dart';
import 'widgets/header.dart';

class IntroductionAnimationView extends GetView<IntroductionAnimationController> {
  const IntroductionAnimationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IntroductionAnimationScreen();
  }
}
