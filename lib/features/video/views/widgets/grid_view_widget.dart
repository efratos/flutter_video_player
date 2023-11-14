import 'package:flutter/material.dart';
import 'package:video_player_app/features/video/domain/entities/video_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player_app/utils/size_utils.dart';

class GridViewWidget extends StatelessWidget {
  final List<VideoEntity> videos;
  final Function(int) callback;
  const GridViewWidget(
      {super.key, required this.videos, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: InkWell(
            onTap: () => callback(index),
            child: SizedBox(
              height: 260.h,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(5.v),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.v),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            imageUrl: videos[index].videoThumbnail!,
                          ),
                        ),
                        Text(
                          videos[index].videoTitle!,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w700,
                              fontSize: 11.fSize),
                        ),
                        Text(
                          videos[index].videoDescription ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 10.fSize),
                        )
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
