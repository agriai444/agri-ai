import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agri_ai/app/components/gradient_text.dart';
import 'package:agri_ai/config/translations/localization_service.dart';
import 'package:agri_ai/config/theme/my_theme.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final currentLocale = LocalizationService.getCurrentLocal();
    final List<Locale> supportedLocales =
        LocalizationService.supportedLanguages.values.toList();
    final theme = Theme.of(context);

    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   child:
              //   Image.asset(
              //     'assets/introduction_animation/introduction_image.png',
              //     fit: BoxFit.cover,
              //   ),
              // ),

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
                    GradientText(text: 'Select'),
                    GradientText(text: 'Language'),
                  ],
                ),
              ),

              const SizedBox(
                height: 150,
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 64, right: 64),
                      child: Container(
                        height: 50,
                        width: 230,
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 16,
                          bottom: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: theme.cardColor,
                        ),
                        child: DropdownButton<Locale>(
                          value: currentLocale,
                          icon: Icon(Icons.language,
                              color: theme.iconTheme.color),
                          iconSize: 24,
                          elevation: 16,
                          style: theme.textTheme.bodyLarge,
                          onChanged: (Locale? newLocale) {
                            if (newLocale != null) {
                              LocalizationService.updateLanguage(
                                  newLocale.languageCode);
                            }
                          },
                          items: supportedLocales
                              .map<DropdownMenuItem<Locale>>((Locale locale) {
                            return DropdownMenuItem<Locale>(
                              value: locale,
                              child: Text(
                                locale.languageCode == 'en'
                                    ? 'English'
                                    : 'Arabic',
                                style: theme.textTheme.bodyLarge,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom + 16),
                      child: InkWell(
                        onTap: () {
                          widget.animationController.animateTo(0.2);
                        },
                        child: Container(
                          height: 58,
                          padding: const EdgeInsets.only(
                            left: 56.0,
                            right: 56.0,
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38.0),
                            color: const Color(0xff132137),
                          ),
                          child: Text(
                            "Let's begin",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
