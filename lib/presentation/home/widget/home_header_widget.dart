import 'package:flutter/material.dart';
import 'package:novi_test/infrastructure/app_controller.dart';
import 'package:novi_test/utils/colors.dart';
import 'package:novi_test/utils/image_strings.dart';
import 'package:novi_test/utils/text_strings.dart';
import 'package:provider/provider.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({super.key});

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(builder: (context, appConsumer, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextStrings.helloMaria,
                style: TextStyle(
                  color: KColorConstants.whiteColor,
                ),
              ),
              CircleAvatar(
                backgroundImage: AssetImage(ImageStrings.circleAvatarImage),
              ),
            ],
          ),
          const Text(
            TextStrings.welcomeBackToSection,
            style: TextStyle(color: KColorConstants.loremColor),
          ),
          const SizedBox(height: 20),

          /// Categories List
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: appConsumer.categoryList.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xffC70000).withOpacity(0.40)
                              : const Color(0xffE2E2E2),
                        ),
                        color: isSelected
                            ? const Color(0xffC70000).withOpacity(0.40)
                            : const Color(0xff161616),
                      ),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          appConsumer.categoryList[index].title ?? "Unknown",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
