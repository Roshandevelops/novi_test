import 'package:flutter/material.dart';
import 'package:novi_test/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161616),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hello Maria",
                        style: TextStyle(color: KColorConstants.whiteColor),
                      ),
                      CircleAvatar(),
                    ],
                  ),
                  Text(
                    "Welcome back to Section",
                    style: TextStyle(color: KColorConstants.loremColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
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
                                          ? Color(0xffC70000).withOpacity(0.40)
                                          : Color(0xffE2E2E2)),
                                  color: isSelected
                                      ? Color(0xffC70000).withOpacity(0.40)
                                      : Color(0xff161616)),
                              child: Center(
                                child: Text(
                                  "Unknown",
                                  style: TextStyle(
                                    fontSize: 16,
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
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Title Name"),
                                        Text("Sub Tile Name"),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 1 / 2,
                          color: Colors.amber,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
