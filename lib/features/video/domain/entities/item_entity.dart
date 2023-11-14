import 'package:equatable/equatable.dart';
import 'package:video_player_app/features/video/domain/entities/video_entity.dart';

class ItemEntity extends Equatable {
  final String appBackgroundHexColor;
  final List<VideoEntity> videos;

  const ItemEntity({
    required this.appBackgroundHexColor,
    required this.videos,
  });

  @override
  List<Object?> get props => [appBackgroundHexColor, videos];
}
