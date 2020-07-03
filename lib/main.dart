import 'dart:async';

import 'package:apahabar/loadingdialog_widget.dart';
import 'package:apahabar/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(
      builder: (BuildContext context) {
        return WebView(
          initialUrl: 'https://apahabar.com',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete();
          },
          onPageStarted: (String url) {
            LoadingDialog.show(context);
          },
          onPageFinished: (String url) {
            LoadingDialog.hide(context);
          },
          onWebResourceError: (error) {
            LoadingDialog.hide(context);
          },
        );
      },
    ));
  }
}
