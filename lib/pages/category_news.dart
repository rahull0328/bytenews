import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w700,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          child: Column(
              
          )
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String Image, desc, title;
  ShowCategory({required this.Image, required this.desc, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CachedNetworkImage(
              imageUrl: Image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
          ),
          Text(title),
          Text(desc)
        ],
      ),
    );
  }
}

