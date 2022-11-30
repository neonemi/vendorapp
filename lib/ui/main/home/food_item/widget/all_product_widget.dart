import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../ui.dart';

class FoodAllProductScreen extends StatelessWidget {
  final List<ProductListData> productData;
  const FoodAllProductScreen({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
     // scrollDirection: Axis.vertical,
      itemCount: productData.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => {},
          child: Container(
              width: MediaQuery.of(context).size.width - 20,
              //height: 200,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AppImageLoader(
                  imageUrl: Apis.imageBaseUrl + productData[index].image!,
                  boxFit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width - 60,
                  height: 200,
                ),
              )),
        );
      },
    );
  }
}
