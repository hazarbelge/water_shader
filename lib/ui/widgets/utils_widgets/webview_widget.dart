import "package:flutter/material.dart";

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({
    super.key,
    required this.url,
    required this.title,
  });

  final String url;
  final String title;

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(
        url: widget.url,
        title: widget.title,
      ),
    );
  }
}
