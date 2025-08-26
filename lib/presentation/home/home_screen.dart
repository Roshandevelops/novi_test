import 'package:flutter/material.dart';
import 'package:novi_test/infrastructure/app_controller.dart';
import 'package:novi_test/presentation/add_screen/add_screen.dart';
import 'package:novi_test/presentation/home/widget/feed_widget.dart';
import 'package:novi_test/presentation/home/widget/home_header_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await Provider.of<AppController>(context, listen: false)
            .fetchCategories();
        if (mounted) {
          await Provider.of<AppController>(context, listen: false)
              .fetchHomeFeedData();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, appConsumer, child) {
        return Scaffold(
          backgroundColor: const Color(0xff161616),
          body: appConsumer.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SafeArea(
                  child: Column(
                    children: [
                      /// Header
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: HomeHeaderWidget(),
                      ),

                      /// Feed List
                      FeedWidget()
                    ],
                  ),
                ),

          /// Floating Button
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xffC70000),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const AddFeedsScreen();
                  },
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              size: 30,
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
