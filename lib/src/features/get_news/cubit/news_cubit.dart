import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unit_testing_practical/src/features/get_news/data/models/article.dart';
import 'package:unit_testing_practical/src/features/get_news/data/repositories/news_repository.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  Future<void> getNews() async {
    emit(GetNewsLoading());
    var result = await NewsRepository().getNews();
    result.fold((l) => emit(GetNewsError(l)), (r) => emit(GetNewsSuccess(r)));
  }
}
