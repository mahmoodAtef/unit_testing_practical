import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing_practical/src/core/utils/constants_manager.dart';
import 'package:unit_testing_practical/src/features/get_news/data/models/article.dart';
import 'package:unit_testing_practical/src/features/get_news/data/services/news_services.dart';

import 'get_news_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  MockDio mockDio = MockDio();
  mockDio.options = BaseOptions(
    headers: {"X-Api-Key": ConstantsManager.apiKey},
    baseUrl: ConstantsManager.baseUrl,
  );

  test('test fetching news from api', () async {
    NewsServices newsServices = NewsServices(dio: mockDio);

    when(
      mockDio.get(
        ConstantsManager.everything,
        queryParameters: {
          'country': "us",
          'category': "technology",
          "pageSize": 25
        },
      ),
    ).thenAnswer((_) async =>
        Response(statusCode: 200, requestOptions: RequestOptions(), data: {
          "status": "ok",
          "totalResults": 1,
          "articles": [
            {
              "source": {"id": "newsweek", "name": "Newsweek"},
              "author": "Mandy Taheri",
              "title":
                  "Could Republican plan to give Trump third-term work? Process explained",
              "description":
                  "Representative Andy Ogles proposed a resolution to amend the U.S. Constitution that would allow presidents to serve a third term under certain conditions.",
              "url":
                  "https://www.newsweek.com/andy-ogles-plan-give-trump-third-term-work-process-explained-2020822",
              "urlToImage": "https://d.newsweek.com/en/full/2573496/trump.jpg",
              "publishedAt": "2025-01-25T19:37:36Z",
              "content":
                  "Representative Andy Ogles, a Tennessee Republican, has proposed a resolution to amend the U.S. Constitution that would allow presidents to serve a third term under certain conditions. But how likely … [+4278 chars]"
            },
          ],
        }));

    expect(await newsServices.getNews(), isA<Either<String, List<Article>>>());
  });

  test('test error fetching news from api', () async {
    NewsServices newsServices = NewsServices(dio: mockDio);

    when(
      mockDio.get(
        ConstantsManager.everything,
        queryParameters: {
          'country': "us",
          'category': "technology",
          "pageSize": 25
        },
      ),
    ).thenAnswer(
        (_) async => throw DioException(requestOptions: RequestOptions()));

    expect(await newsServices.getNews(), isA<Either<String, List<Article>>>());
  });
}
