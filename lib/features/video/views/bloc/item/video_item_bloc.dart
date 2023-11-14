import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player_app/features/video/domain/entities/item_entity.dart';
import 'package:video_player_app/features/video/domain/usecases/get_items.dart';

part 'video_item_event.dart';
part 'video_item_state.dart';

class VideoItemBloc extends Bloc<VideoItemEvent, VideoItemState> {
  final GetItemsUseCase _getItemsUseCase;
  VideoItemBloc(this._getItemsUseCase) : super(VideoItemInitial()) {
    on<LoadItems>((event, emit) async {
      emit(ItemLoading());
      final result = await _getItemsUseCase();
      result.fold((failure) {
        emit(ItemError(failure.errorMessage));
      }, (data) {
        emit(ItemSuccess(data));
      });
    });
  }
}
