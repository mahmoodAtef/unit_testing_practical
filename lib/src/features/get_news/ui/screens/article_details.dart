import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:unit_testing_practical/src/features/get_news/data/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailsScreen({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBreakpoints.of(context).isMobile
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        _buildArticleContent(),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: ResponsiveBreakpoints.of(context).isTablet
              ? MediaQuery.of(context).size.width * 0.8
              : MediaQuery.of(context).size.width * 0.6,
          child: CustomScrollView(
            slivers: [
              _buildAppBar(context),
              _buildArticleContent(),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: article.urlToImage != null
            ? Hero(
                tag: article.url,
                child: Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              )
            : Container(
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Colors.grey,
                  ),
                ),
              ),
      ),
    );
  }

  SliverList _buildArticleContent() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Author and Source
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (article.author != null)
                    Text(
                      'By ${article.author!}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  Text(
                    article.source.name,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Published Date
              Text(
                _formatPublishedDate(article.publishedAt),
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Description
              if (article.description != null)
                Text(
                  article.description!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              const SizedBox(height: 16),

              // Content
              if (article.content != null)
                Text(
                  article.content!,
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 16),

              // Full Article Button
              ElevatedButton(
                onPressed: () => _launchUrl(article.url),
                child: const Text('Read Full Article'),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  String _formatPublishedDate(String publishedAt) {
    DateTime dateTime = DateTime.parse(publishedAt);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
