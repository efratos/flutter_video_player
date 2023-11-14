import 'dart:convert';

import 'package:video_player_app/core/errors/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:video_player_app/features/video/data/models/item_model.dart';
import 'package:video_player_app/features/video/domain/entities/item_entity.dart';

abstract class ItemsRemoteDataResource {
  Future<ItemModel> getItems();
}

class ItemsRemoteDataResourceImpl implements ItemsRemoteDataResource {
  ItemsRemoteDataResourceImpl();
  @override
  Future<ItemModel> getItems() async {
    final dio = Dio();

    try {
      final response = await dio.get(
          'https://raw.githubusercontent.com/efratos/jsonurl/main/listjson.json');

      if (response.statusCode == 200) {
        return ItemModel.fromJson(json.decode(response.data));
        // Process the data
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
