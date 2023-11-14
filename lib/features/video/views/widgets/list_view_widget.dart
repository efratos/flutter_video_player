import 'package:flutter/material.dart';
import 'package:video_player_app/features/video/domain/entities/video_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player_app/utils/size_utils.dart';

class ListViewWidget extends StatelessWidget {
  final List<VideoEntity> videos;
  final Function(int) callback;
  const ListViewWidget(
      {super.key, required this.videos, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: videos.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            callback(index);
          },
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.v,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.v),
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                      imageUrl: videos[index].videoThumbnail!,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(videos[index].videoTitle!,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w700,
                                fontSize: 14)),
                        Text(
                          videos[index].videoDescription ?? "",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 5.v,
        );
      },
    );
  }
}
