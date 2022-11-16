import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../ui.dart';

class HomeVerticalList extends StatelessWidget {
  final List<CategoryData> categoryData;
  const HomeVerticalList({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: categoryData.length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {

              },
              child: Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 200,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: AppImageLoader(
                        imageUrl:
                            Apis.imageBaseUrl + categoryData[index].image!,
                        boxFit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width - 60,
                        height: 200,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 200,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 100,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.appWhite),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          categoryData[index].name!,
                          style: TextStyle(color: AppTheme.appWhite),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
