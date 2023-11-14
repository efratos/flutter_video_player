import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player_app/core/connection/network_info.dart';
import 'package:video_player_app/features/video/data/data_sources/local/items_local_data_source.dart';
import 'package:video_player_app/features/video/data/data_sources/remote/items_remote_data_source.dart';
import 'package:video_player_app/features/video/data/repositories/item_repository_impl.dart';
import 'package:video_player_app/features/video/domain/repositories/item_repository.dart';
import 'package:video_player_app/features/video/domain/usecases/get_items.dart';
import 'package:video_player_app/features/video/views/bloc/item/video_item_bloc.dart';

final serviceLocator = GetIt.instance;
Future<void> setUpServiceLocator() async {
  // bloc
  serviceLocator.registerFactory(() => VideoItemBloc(serviceLocator()));

  // usecase
  serviceLocator.registerLazySingleton(() => GetItemsUseCase(serviceLocator()));

  // repository
  serviceLocator.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(
      itemsLocalDataResource: serviceLocator(),
      itemsRemoteDataResource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // data source
  serviceLocator.registerLazySingleton<ItemsRemoteDataResource>(
    () => ItemsRemoteDataResourceImpl(),
  );

  serviceLocator.registerLazySingleton<ItemsLocalDataSource>(
    () => ItemsLocalDataSourceImpl(),
  );

  // internet cheker
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(DataConnectionChecker()),
  );

  serviceLocator.registerLazySingleton<Dio>(
    () => Dio(),
  );
}
