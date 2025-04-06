import 'package:bytenews/models/article_model.dart';
import 'package:bytenews/models/slider_model.dart';
import 'package:bytenews/pages/article_view.dart';
import 'package:bytenews/services/news.dart';
import 'package:bytenews/services/slider_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount:
        widget.news == "Headlines" ? sliders.length : articles.length,
        itemBuilder: (context, index) {
          return AllNewsSection(
            image: widget.news == "Headlines"
                ? sliders[index].urlToImage!
                : articles[index].urlToImage!,
            desc: widget.news == "Headlines"
                ? sliders[index].description!
                : articles[index].description!,
            title: widget.news == "Headlines"
                ? sliders[index].title!
                : articles[index].title!,
            url: widget.news == "Headlines"
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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
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
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
