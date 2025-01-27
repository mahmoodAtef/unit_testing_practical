import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_testing_practical/src/features/get_news/cubit/news_cubit.dart';
import 'package:unit_testing_practical/src/features/get_news/data/models/article.dart';
import 'package:unit_testing_practical/src/features/get_news/data/services/news_services.dart';

final class MockNewsCubit extends MockCubit<NewsState> implements NewsCubit {}

final class MockNewsServices extends Mock implements NewsServices {}

void main() {
  group("testing news cubit", () {
    late NewsCubit newsCubit;
    late NewsServices newsServices;

    setUp(() {
      newsCubit = MockNewsCubit();
      newsServices = MockNewsServices();
    });

    testBloc(
        build: () {
          when(
            () => newsCubit.getNews(),
          ).thenAnswer((_) async => Response(
                  statusCode: 200,
                  requestOptions: RequestOptions(),
                  data: {
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
                        "urlToImage":
                            "https://d.newsweek.com/en/full/2573496/trump.jpg",
                        "publishedAt": "2025-01-25T19:37:36Z",
                        "content":
                            "Representative Andy Ogles, a Tennessee Republican, has proposed a resolution to amend the U.S. Constitution that would allow presidents to serve a third term under certain conditions. But how likely … [+4278 chars]"
                      },
                    ],
                  }));
          return newsCubit;
        },
        act: (newsCubit) {
          newsCubit.getNews();
        },
        expect: () => [
              GetNewsLoading(),
              GetNewsSuccess([
                Article.fromJson(
                  {
                    "source": {"id": "newsweek", "name": "Newsweek"},
                    "author": "Mandy Taheri",
                    "title":
                        "Could Republican plan to give Trump third-term work? Process explained",
                    "description":
                        "Representative Andy Ogles proposed a resolution to amend the U.S. Constitution that would allow presidents to serve a third term under certain conditions.",
                    "url":
                        "https://www.newsweek.com/andy-ogles-plan-give-trump-third-term-work-process-explained-2020822",
                    "urlToImage":
                        "https://d.newsweek.com/en/full/2573496/trump.jpg",
                    "publishedAt": "2025-01-25T19:37:36Z",
                    "content":
                        "Representative Andy Ogles, a Tennessee Republican, has proposed a resolution to amend the U.S. Constitution that would allow presidents to serve a third term under certain conditions. But how likely … [+4278 chars]"
                  },
                )
              ])
            ]);

    testBloc(
        build: () {
          when(
            () => newsCubit.getNews(),
          ).thenAnswer((_) async => throw DioException(
              response: Response(
                  requestOptions: RequestOptions(), statusMessage: "error"),
              requestOptions: RequestOptions()));
          return newsCubit;
        },
        act: (newsCubit) {
          newsCubit.getNews();
        },
        expect: () => [GetNewsLoading(), GetNewsError("error")]);
  });
}
