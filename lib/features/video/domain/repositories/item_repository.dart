import 'package:dartz/dartz.dart';
import 'package:video_player_app/core/errors/failure.dart';
import 'package:video_player_app/features/video/domain/entities/item_entity.dart';

abstract class ItemRepository {
  Future<Either<Failure, ItemEntity>> getItems();
}
