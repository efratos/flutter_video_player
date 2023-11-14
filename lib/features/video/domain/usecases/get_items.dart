import 'package:dartz/dartz.dart';
import 'package:video_player_app/core/errors/failure.dart';
import 'package:video_player_app/features/video/domain/entities/item_entity.dart';
import 'package:video_player_app/features/video/domain/repositories/item_repository.dart';

class GetItemsUseCase {
  final ItemRepository itemRepository;

  GetItemsUseCase(this.itemRepository);

  Future<Either<Failure, ItemEntity>> call() {
    return itemRepository.getItems();
  }
}
