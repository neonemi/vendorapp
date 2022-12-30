import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendorapp/ui/main/home/sub_category/widget/sub_catergory_vertical.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendorapp/core/core.dart';

class SubCategoryScreen extends StatefulWidget {
  final String itemName;
  final String id;
  final String bannerImage;
  const SubCategoryScreen(
      {Key? key,
      required this.itemName,
      required this.id,
      required this.bannerImage})
      : super(key: key);

  @override
  SubCategoryScreenState createState() => SubCategoryScreenState();
}

class SubCategoryScreenState extends State<SubCategoryScreen> {
  late final FoodItemCubit _cubit;
  String itemName = "";
  String itemId = "";
  String bannerImage = "";
  bool visibleBestSeller = true;
  @override
  void initState() {
    super.initState();

    itemName = widget.itemName;
    itemId = widget.id;
    bannerImage = widget.bannerImage;
    if (kDebugMode) {
      print(itemId);
    }
    // _cubit = FoodItemCubit(context.read<CoreRepository>())
    //   ..getFoodProduct(itemId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<FoodItemCubit>(create: (context) {
            _cubit = FoodItemCubit(context.read<CoreRepository>())
              ..getSubCategory(itemId);
            return _cubit;
          }),
        ],
        child: BlocListener<FoodItemCubit, FoodItemState>(
            listener: (context, state) {
              if (kDebugMode) {
                print('state : $state');
              }
              if (state is FoodItemLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }

              if (state is FoodItemError) {
                context.showToast(state.message);
              }
            },
            child: BlocBuilder<FoodItemCubit, FoodItemState>(
                buildWhen: (previous, current) =>
                    current is FoodSubCategorySuccess,
                builder: (context, state) {
                  if (state is FoodSubCategorySuccess) {
                    GetSubCategory getSubCategory = state.response;

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
                              itemName,
                              style: TextStyle(
                                  color: AppTheme.appWhite,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: StringConstant.fontFamily),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        body: getSubCategory.data == null
                            ? const SizedBox.shrink()
                            : getSubCategory.data!.isEmpty
                                ? const SizedBox.shrink()
                                : SubCategoryVerticalList(
                                    categoryData: getSubCategory.data!,
                                    bannerImage: bannerImage,
                                  ));
                  }
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
                          itemName,
                          style: TextStyle(
                              color: AppTheme.appWhite,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontFamily: StringConstant.fontFamily),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                })));
  }
}
