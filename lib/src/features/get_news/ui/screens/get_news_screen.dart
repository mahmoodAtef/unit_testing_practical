import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:unit_testing_practical/src/features/get_news/cubit/news_cubit.dart';
import 'package:unit_testing_practical/src/features/get_news/ui/widgets/components.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News'),
      ),
      body: BlocProvider(
        create: (context) => NewsCubit()..getNews(),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            return ResponsiveBreakpoints.of(context).isMobile
                ? _buildMobileLayout(state)
                : _buildDesktopLayout(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout(NewsState state) {
    return _buildNewsContent(state, 1); // Single column for mobile
  }

  Widget _buildDesktopLayout(BuildContext context, NewsState state) {
    return _buildNewsContent(
      state,
      ResponsiveBreakpoints.of(context).isTablet
          ? 2
          : 3, // 2 columns for tablet, 3 for desktop
    );
  }

  Widget _buildNewsContent(NewsState state, int crossAxisCount) {
    if (state is GetNewsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is GetNewsError) {
      return Center(
        child: Text(
          'Error: ${state.message}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (state is GetNewsSuccess) {
      return state.news.isEmpty
          ? const Center(child: Text('No news available'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
                padding: const EdgeInsets.all(8),
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  return ArticleCard(article: state.news[index]);
                },
              ),
            );
    }

    return const SizedBox.shrink();
  }
}
