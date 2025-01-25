import 'package:dartz/dartz.dart';
import 'package:unit_testing_practical/src/core/services/dep_injection.dart';
import 'package:unit_testing_practical/src/features/get_news/data/models/article.dart';
import 'package:unit_testing_practical/src/features/get_news/data/services/news_services.dart';

class NewsRepository {
  NewsServices _newsServices = NewsServices(dio: sl());
  Future<Either<String, List<Article>>> getNews() async {
    return _newsServices.getNews();
  }
}
