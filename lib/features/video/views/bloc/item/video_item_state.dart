part of 'video_item_bloc.dart';

sealed class VideoItemState extends Equatable {
  const VideoItemState();

  @override
  List<Object> get props => [];
}

final class VideoItemInitial extends VideoItemState {}

final class ItemLoading extends VideoItemState {}

final class ItemSuccess extends VideoItemState {
  final ItemEntity items;
  const ItemSuccess(this.items);
}

final class ItemError extends VideoItemState {
  final String errorMessage;
  const ItemError(this.errorMessage);
}
