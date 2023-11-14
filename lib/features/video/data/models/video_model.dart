import 'package:video_player_app/features/video/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  const VideoModel(
      {required super.videoTitle,
      required super.videoThumbnail,
      required super.videoUrl,
      required super.videoDescription});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videoTitle: json['videoTitle'],
      videoThumbnail: json['videoThumbnail'],
      videoUrl: json['videoUrl'],
      videoDescription: json['videoDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoTitle'] = videoTitle;
    data['videoThumbnail'] = videoThumbnail;
    data['videoUrl'] = videoUrl;
    data['videoDescription'] = videoDescription;
    return data;
  }
}
