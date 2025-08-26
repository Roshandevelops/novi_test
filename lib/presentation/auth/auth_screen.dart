import 'package:flutter/material.dart';
import 'package:novi_test/infrastructure/app_controller.dart';
import 'package:novi_test/presentation/auth/widget/auth_header_widget.dart';
import 'package:novi_test/presentation/auth/widget/continue_button_widget.dart';
import 'package:novi_test/presentation/auth/widget/country_code_number_widget.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AppController authProvider;
  final TextEditingController countryCodeController =
      TextEditingController(text: "+91");
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
                const AuthHeaderWidget(),
                CountryCodeNumberWidget(
                  countryCodeController: countryCodeController,
                  phoneController: phoneController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 2,
                ),
                ContinueButtonWidget(
                  onTap: () {
                    login(context);
                  },
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
