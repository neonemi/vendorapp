import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendorapp/core/core.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyScreen extends StatefulWidget {
  final String url;
  const PrivacyScreen({Key? key, required this.url}) : super(key: key);

  @override
  PrivacyScreenState createState() => PrivacyScreenState();
}

class PrivacyScreenState extends State<PrivacyScreen> {
  bool isLoading = true;
  int valueProgress = 0;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 10.0),
          height: 50,
          alignment: Alignment.centerLeft,
          child:  Text(
            "Privacy policy",
            style: TextStyle(
                color: AppTheme.appBlack,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontFamily: "Montserrat"),
            textAlign: TextAlign.center,
          ),
        ),
      ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
                onProgress: (value) {
                  setState(() {
                    valueProgress = value;
                  });
                },
                javascriptMode: JavascriptMode.unrestricted,
              ),
              Visibility(
                visible: isLoading,
                child: Center(
                  child: CircularProgressIndicator(
                    value: valueProgress / 100,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
