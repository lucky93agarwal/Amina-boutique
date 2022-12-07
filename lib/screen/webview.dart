import 'dart:io';

import 'package:amin/utils/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatefulWidget {
  String title;
  String url;
  WebViewScreen({Key? key,required this.title,required this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    var baseUrl = "https://desiflea.com/admin/api/desifleaapi.php";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title).tr(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: pageFinishedLoading,
            ),
            _isLoading == true? Center(child: CircularProgressIndicator(   valueColor: new AlwaysStoppedAnimation<Color>(kMainColor),),):SizedBox(),
          ],
        ),
      ),
    );
  }
  void pageFinishedLoading(String url) {
    setState(() {
      _isLoading = false;
    });
  }
}
