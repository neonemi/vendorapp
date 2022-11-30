import 'package:flutter/material.dart';
import 'package:vendorapp/core/core.dart';
import 'package:vendorapp/ui/ui.dart';

class FoodBestSellerList extends StatelessWidget {
  final List<BestSellerData> bestSellerData;
  const FoodBestSellerList({super.key, required this.bestSellerData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bestSellerData.length,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {},
              child: Container(
                width: 160,
                height: 160,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AppImageLoader(
                    imageUrl: Apis.imageBaseUrl + bestSellerData[index].image!,
                    boxFit: BoxFit.cover,
                    height: 110,
                    width: 110,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
