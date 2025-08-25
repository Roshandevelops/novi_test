import 'package:flutter/material.dart';
import 'package:novi_test/infrastructure/app_controller.dart';
import 'package:novi_test/utils/colors.dart';
import 'package:novi_test/utils/text_strings.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AppController authProvider;
  final TextEditingController countryCodeController =
      TextEditingController(text: '+91');
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    authProvider = Provider.of<AppController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const  Text(
                  TextStrings.enterYour,
                  style: TextStyle(
                    fontSize: 20,
                    color: KColorConstants.whiteColor,
                  ),
                ),
             const   Text(
                  TextStrings.mobileNumber,
                  style: TextStyle(
                    fontSize: 20,
                    color: KColorConstants.whiteColor,
                  ),
                ),
           const     SizedBox(
                  height: 20,
                ),
            const    Text(
                  TextStrings.loremText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: KColorConstants.loremColor,
                  ),
                ),
           const     SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: TextFormField(
                        controller: countryCodeController,
                        decoration:const InputDecoration(
                          hintText: "+91",
                          hintStyle:
                              TextStyle(color: KColorConstants.loremColor),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                 const   SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: phoneController,
                        decoration:const InputDecoration(
                          hintText: TextStrings.enterYourNumber,
                          hintStyle:
                              TextStyle(color: KColorConstants.loremColor),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 2,
                ),
                InkWell(
                  onTap: () {
                    login(context);
                  },
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: KColorConstants.borderColor,
                        ),
                      ),
                      width: 130,
                      height: 55,
                      child:const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            TextStrings.continueText,
                            style: TextStyle(
                              color: KColorConstants.whiteColor,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: KColorConstants.continueIconColor,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    await authProvider.login(
      countryCodeController.text,
      phoneController.text,
      context,
    );
  }
}
