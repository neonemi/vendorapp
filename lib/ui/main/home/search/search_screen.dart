import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendorapp/core/core.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appRed,
          iconTheme: IconThemeData(color: AppTheme.appWhite),
          centerTitle: true,
          elevation: 0.0,
          title: Container(
            margin: const EdgeInsets.only(right: 40),
            height: 50,
            alignment: Alignment.center,
            child: Text(
              'Search',
              style: TextStyle(
                  color: AppTheme.appWhite,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontFamily: "Montserrat"),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Stack(
            children: [
              Container(
                  height: 90,
                  color: AppTheme.appRed,
                  child: searchBar(
                      context, MediaQuery.of(context).size.width * 0.07)),
              Container(
                margin: const EdgeInsets.only(top: 90),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Sorry, No product found\nYou can browse complete product list by',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'clicking here',
                          style: TextStyle(
                              color: AppTheme.appRed,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget searchBar(BuildContext context, double bodyMargin) {
    var searchController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: bodyMargin, vertical: 22),
      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        textDirection: TextDirection.ltr,
        style: TextStyle(color: AppTheme.appWhite),
        cursorColor: AppTheme.appRed,
        cursorHeight: 0.0,
        cursorWidth: 0.0,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            fillColor: AppTheme.appRed,
            filled: true,
            hintText: 'Cakes, Pastry, Patties',
            hintStyle: TextStyle(color: AppTheme.appWhite),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appWhite)),
            disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appWhite)),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appWhite)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appWhite)),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appWhite))),
        onChanged: (value) {
          debugPrint(value);
          // searchController.text = value;
        },
        onSubmitted: (String value) {},
      ),
    );
  }
}
