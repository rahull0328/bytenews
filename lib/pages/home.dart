import 'package:bytenews/models/article_model.dart';
import 'package:bytenews/models/category_model.dart';
import 'package:bytenews/models/slider_model.dart';
import 'package:bytenews/pages/all_news.dart';
import 'package:bytenews/pages/article_view.dart';
import 'package:bytenews/pages/category_news.dart';
import 'package:bytenews/services/data.dart';
import 'package:bytenews/services/news.dart';
import 'package:bytenews/services/slider_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //import the list of sliders and categories
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];

  //getting the articles from the use of API
  List<ArticleModel> articles = [];
  bool _loading = true;

  int activeIndex = 0;
  @override
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();
    super.initState();
  }

  //function for fetching news below the latest trends section
  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  //api data for the carousel
  getSlider() async {
    Sliders sliderService = Sliders();
    await sliderService.getSlider();
    sliders = sliderService.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("byte"),
            Text(
              "News",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w700,
                fontFamily: 'Pacifico',
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body:
          _loading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16, left: 10, right: 10),
                        height: 70,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              image: categories[index].image,
                              categoryName: categories[index].categoryName,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Top Headlines!",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 24.0,
                                fontFamily: 'Pacifico',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> AllNews(news: "Headlines")));
                              },
                              child: Text(
                                "View all",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      CarouselSlider.builder(
                        itemCount: 5,
                        itemBuilder: (context, index, realIndex) {
                          String? res = sliders[index].urlToImage;
                          String? res1 = sliders[index].title;
                          return buildImage(res!, index, res1!);
                        },
                        options: CarouselOptions(
                          height: 250,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Center(child: buildIndicator()),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Latest Trends!",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                                fontFamily: 'Pacifico',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> AllNews(news: "Latest Trends")));
                              },
                              child: Text(
                                "View all",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(height: 20.0),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              url: articles[index].url!,
                              desc: articles[index].description!,
                              imageUrl: articles[index].urlToImage!,
                              title: articles[index].title!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: image,
            height: 250,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          height: 250,
          padding: EdgeInsets.only(left: 12.0),
          margin: EdgeInsets.only(top: 165.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Text(
            name,
            maxLines: 2,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
  //slider dots indicator
  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 5,
    effect: const JumpingDotEffect(
      jumpScale: 1,
      verticalOffset: 10,
      activeDotColor: Colors.deepPurple,
    ),
  );
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryNews(name: categoryName) ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Center(
                child: Text(
                  categoryName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//besides latest trends section
class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile({
    required this.desc,
    required this.imageUrl,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 5.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 110,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 7.0),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          desc,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
