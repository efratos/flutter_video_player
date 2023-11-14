import 'package:dartz/dartz.dart';
import 'package:video_player_app/core/connection/network_info.dart';
import 'package:video_player_app/core/errors/exceptions.dart';
import 'package:video_player_app/core/errors/failure.dart';
import 'package:video_player_app/features/video/data/data_sources/local/items_local_data_source.dart';
import 'package:video_player_app/features/video/data/data_sources/remote/items_remote_data_source.dart';
import 'package:video_player_app/features/video/data/models/item_model.dart';
import 'package:video_player_app/features/video/domain/entities/item_entity.dart';
import 'package:video_player_app/features/video/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemsRemoteDataResource itemsRemoteDataResource;
  final ItemsLocalDataSource itemsLocalDataResource;
  final NetworkInfo networkInfo;

  ItemRepositoryImpl({
    required this.itemsRemoteDataResource,
    required this.itemsLocalDataResource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ItemEntity>> getItems() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteItems = await itemsRemoteDataResource.getItems();
        itemsLocalDataResource.cacheItems(remoteItems);
        return Right(remoteItems);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        final localItems = await itemsLocalDataResource.getCachedItems();
        return Right(localItems);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'No local data found'));
      }
    }
  }
}
