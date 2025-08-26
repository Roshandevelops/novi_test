import 'package:flutter/material.dart';
import 'package:novi_test/infrastructure/app_controller.dart';
import 'package:novi_test/presentation/home/widget/video_player_widget.dart';
import 'package:novi_test/utils/image_strings.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedWidget extends StatelessWidget {
  const FeedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, appConsumer, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: appConsumer.feedList.length,
            itemBuilder: (context, index) {
              final feed = appConsumer.feedList[index];
              final hasVideo = feed.video != null && feed.video!.isNotEmpty;
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              feed.image ?? ImageStrings.feedImage,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feed.user?.name ?? "Unknown name",
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                feed.createdAt != null
                                    ? timeago.format(feed.createdAt!)
                                    : "Unknown Date",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
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
                              feed.image ?? ImageStrings.feedImage,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: 10),

                    /// Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
        );
      },
    );
  }
}
