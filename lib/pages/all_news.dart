import 'package:bytenews/models/article_model.dart';
import 'package:bytenews/models/slider_model.dart';
import 'package:bytenews/pages/article_view.dart';
import 'package:bytenews/services/news.dart';
import 'package:bytenews/services/slider_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AllNews extends StatefulWidget {
  final String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    if (widget.news == "Headlines") {
      Sliders sliderService = Sliders();
      await sliderService.getSlider();
      sliders = sliderService.sliders;
    } else {
      News newsClass = News();
      await newsClass.getNews();
      articles = newsClass.news;
    }

    setState(() {
      _loading = false;
    });
  }

  Widget buildShimmerLoader() {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isHeadline = widget.news == "Headlines";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w700,
            fontFamily: 'Pacifico',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? buildShimmerLoader()
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: isHeadline ? sliders.length : articles.length,
        itemBuilder: (context, index) {
          return AllNewsSection(
            image: isHeadline
                ? sliders[index].urlToImage!
                : articles[index].urlToImage!,
            desc: isHeadline
                ? sliders[index].description!
                : articles[index].description!,
            title: isHeadline
                ? sliders[index].title!
                : articles[index].title!,
            url: isHeadline
                ? sliders[index].url!
                : articles[index].url!,
          );
        },
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  final String image, desc, title, url;
  const AllNewsSection({
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
