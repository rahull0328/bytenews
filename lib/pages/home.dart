import 'package:bytenews/models/category_model.dart';
import 'package:bytenews/models/slider_model.dart';
import 'package:bytenews/services/data.dart';
import 'package:bytenews/services/slider_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //import the list of sliders and categories
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  @override
  void initState() {
    categories = getCategories();
    sliders = getSliders();
    super.initState();
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
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
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
            CarouselSlider.builder(itemCount: sliders.length, itemBuilder: (context, index, realIndex){
              String? res = sliders[index].image;
              String? res1 = sliders[index].name;
              return buildImage(res!, index, res1!);
            },
                options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height
              )
            )
          ],
        ),
      ),
    );
  }
  Widget buildImage(String image, int index, String name) => Container(
    child: Image.asset(
      image,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
    ),
  );
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                  image,
                  width: 120,
                  height: 80, fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Center(child: Text(categoryName, style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold),)),
            )
          ],
      ),
    );
  }
}
