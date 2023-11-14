part of 'video_item_bloc.dart';

sealed class VideoItemEvent extends Equatable {
  const VideoItemEvent();

  @override
  List<Object> get props => [];
}

final class LoadItems extends VideoItemEvent {}
