part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class GetNewsLoading extends NewsState {}

final class GetNewsSuccess extends NewsState {
  final List<Article> news;
  GetNewsSuccess(this.news);
}

final class GetNewsError extends NewsState {
  final String message;
  GetNewsError(this.message);
}
