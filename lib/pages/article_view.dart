import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;

  const ArticleView({super.key, required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Create a WebViewController and load the URL
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(widget.blogUrl));
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
                    fontFamily: 'Pacifico'
                  ),
              )
            ],
          ),
        centerTitle: true,
      ),
      body: Container(
          child: WebViewWidget(controller: _controller)
      ),
    );
  }
}
