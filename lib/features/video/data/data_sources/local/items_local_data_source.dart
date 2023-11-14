import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player_app/core/errors/exceptions.dart';
import 'package:video_player_app/features/video/data/models/item_model.dart';

abstract class ItemsLocalDataSource {
  Future<void>? cacheItems(ItemModel? itemsToCache);

  Future<ItemModel> getCachedItems();
}

const cachedVideoItems = 'CACHED_VIDEO_ITEMS';

class ItemsLocalDataSourceImpl implements ItemsLocalDataSource {
  late SharedPreferences sharedPreferences;
  ItemsLocalDataSourceImpl();

  @override
  Future<ItemModel> getCachedItems() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString(cachedVideoItems);

    if (jsonString != null) {
      return Future.value(ItemModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheItems(ItemModel? itemsToCache) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (itemsToCache != null) {
      sharedPreferences.setString(
        cachedVideoItems,
        json.encode(
          itemsToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
    return null;
  }
}
