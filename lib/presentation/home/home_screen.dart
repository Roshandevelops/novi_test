import 'package:flutter/material.dart';
import 'package:novi_test/infrastructure/app_controller.dart';
import 'package:novi_test/utils/colors.dart';
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
        await Provider.of<AppController>(context, listen: false)
            .fetchHomeFeedData();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(builder: (context, appConsumer, child) {
      return Scaffold(
        backgroundColor: Color(0xff161616),
        body: appConsumer.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
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
                                "Title",
                                style: TextStyle(
                                    color: KColorConstants.whiteColor),
                              ),
                              CircleAvatar(),
                            ],
                          ),
                          Text(
                            "Sub Title",
                            style: TextStyle(color: KColorConstants.loremColor),
                          ),
                          SizedBox(
                            height: 20,
                          ),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: isSelected
                                                  ? Color(0xffC70000)
                                                      .withOpacity(0.40)
                                                  : Color(0xffE2E2E2)),
                                          color: isSelected
                                              ? Color(0xffC70000)
                                                  .withOpacity(0.40)
                                              : Color(0xff161616)),
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          appConsumer
                                                  .categoryList[index].title ??
                                              "Unknown",
                                          style: TextStyle(
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
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: appConsumer.feedList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      2,
                                  // color: Colors.amber,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              child: Image.network(
                                                appConsumer.feedList[index]
                                                        .image ??
                                                    "https://st4.depositphotos.com/14953852/24787/v/1600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(appConsumer.feedList[index]
                                                        .user!.name ??
                                                    "Unknown name"),
                                                Text(
                                                  appConsumer
                                                      .feedList[index].createdAt
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                3,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                        ),
                                        child: Image.network(
                                          appConsumer.feedList[index].image ??
                                              "https://st4.depositphotos.com/14953852/24787/v/1600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(appConsumer
                                              .feedList[index].description ??
                                          "Unknown Description"),
                                    ],
                                  ),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffC70000),
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Icon(
            size: 30,
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
