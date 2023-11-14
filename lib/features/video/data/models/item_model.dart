import 'package:video_player_app/features/video/data/models/video_model.dart';
import 'package:video_player_app/features/video/domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  const ItemModel(
      {required super.appBackgroundHexColor, required super.videos});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      appBackgroundHexColor: json['appBackgroundHexColor'],
      videos: (json['videos'] as List<dynamic>)
          .map((v) => VideoModel.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appBackgroundHexColor'] = appBackgroundHexColor;
    data['videos'] = videos;
    return data;
  }
}
