import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:unit_testing_practical/src/core/utils/constants_manager.dart';
import 'package:unit_testing_practical/src/features/get_news/data/models/article.dart';

class NewsServices {
  late Dio _dio;
  NewsServices({required Dio dio}) {
    _dio = dio;
  }

  Future<Either<String, List<Article>>> getNews() async {
    try {
      var response = await _dio.get(
        ConstantsManager.everything,
        queryParameters: {
          'country': "us",
          'category': "technology",
          "pageSize": 25
        },
      );

      return right((response.data['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList());
    } on DioException catch (e) {
      debugPrint("***********************************************");
      debugPrint(e.response.toString());
      debugPrint("***********************************************");

      return left(e.response?.statusMessage ?? 'Error occured');
    }
  }
}
