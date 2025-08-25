import 'package:flutter/material.dart';
import 'package:novi_test/infrastructure/app_controller.dart';
import 'package:novi_test/presentation/add_screen/add_screen.dart';
import 'package:novi_test/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

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
        backgroundColor: const Color(0xff161616),
        body: appConsumer.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  children: [
                    /// Header + Categories
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Hello Maria",
                                style: TextStyle(
                                  color: KColorConstants.whiteColor,
                                ),
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/profile.jpg"),
                              ),
                            ],
                          ),
                          const Text(
                            "Welcome back to Section",
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
                                              ? const Color(0xffC70000)
                                                  .withOpacity(0.40)
                                              : const Color(0xffE2E2E2),
                                        ),
                                        color: isSelected
                                            ? const Color(0xffC70000)
                                                .withOpacity(0.40)
                                            : const Color(0xff161616),
                                      ),
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          appConsumer
                                                  .categoryList[index].title ??
                                              "Unknown",
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
                      ),
                    ),

                    /// Feed List
                    Expanded(
                      child: ListView.builder(
                        itemCount: appConsumer.feedList.length,
                        itemBuilder: (context, index) {
                          final feed = appConsumer.feedList[index];
                          final hasVideo =
                              feed.video != null && feed.video!.isNotEmpty;

                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              // color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// User info row
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          feed.image ??
                                              "https://st4.depositphotos.com/14953852/24787/v/1600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg",
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            feed.user?.name ?? "Unknown name",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          Text(
                                            feed.createdAt != null
                                                ? timeago
                                                    .format(feed.createdAt!)
                                                : "Unknown Date",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),

                                /// Image or Video
                                SizedBox(
                                  width: double.infinity,
                                  height: 250,
                                  child: hasVideo
                                      ? VideoPlayerWidget(url: feed.video!)
                                      : Image.network(
                                          feed.image ??
                                              "https://st4.depositphotos.com/14953852/24787/v/1600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                const SizedBox(height: 10),

                                /// Description
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    feed.description ?? "Unknown Description",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffC70000),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddFeedsScreen();
                },
              ),
            );
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: const Icon(
            size: 30,
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}

/// Separate reusable video player widget
class VideoPlayerWidget extends StatefulWidget {
  final String url;
  const VideoPlayerWidget({super.key, required this.url});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              GestureDetector(
                onTap: _togglePlayPause,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
