import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:agri_ai/app/components/gradient_text.dart';
import 'package:agri_ai/app/modules/plans/views/widgets/features_list.dart';
import 'package:agri_ai/app/modules/plans/views/widgets/no_credit_card.dart';
import 'package:agri_ai/app/modules/plans/views/widgets/pricing_option.dart';

import '../controllers/plans_controller.dart';

class PlansView extends GetView<PlansController> {
  const PlansView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                
                Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 16,
                  bottom: 16,
                ),
                child: const Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(text: 'Try For Free'),
                  
                  ],
                ),
              ),
            const  SizedBox(height: 20),
              Center(
                child:FeaturesListWidget() ,
              ),
          
              const SizedBox(height: 20),
             const PricingOptionsWidget(),
              const SizedBox(height: 20),
              const NoCreditCardWidget(),
             const SizedBox(height: 20),
            const  TryForFreeButton(),
            //  const Spacer(),
            const  TermsAndPolicyWidget(),
            ],
          ),
        ),
      ),
    );
}

}