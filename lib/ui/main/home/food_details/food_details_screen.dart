import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/core.dart';


class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  late final FoodDetailsCubit _cubit;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodDetailsCubit>(
      create: (context) {
        _cubit = FoodDetailsCubit(context.read<CoreRepository>());
        _cubit.getFoodDetails();
        return _cubit;
      },
      child: BlocListener<FoodDetailsCubit, FoodDetailsState>(
        listener: (context, state) {
          if (state is FoodDetailsLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }

          if (state is FoodDetailsError) {
            context.showToast(state.message);
          }
        },
        child:
        Scaffold(
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
                'Detail',
                style: TextStyle(
                    color: AppTheme.appWhite,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontFamily: "Montserrat"),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          body: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(builder: (context, state) {

            return const SizedBox.shrink();
          }),
        ),
      ),
    );
    //const Center(child: Text("profile",style: TextStyle(color: Colors.red),));
  }


}
