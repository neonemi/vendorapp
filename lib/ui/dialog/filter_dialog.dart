import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendorapp/core/core.dart';

class FilterDialogBuilder {
  FilterDialogBuilder(
    this.context,
  );

  final BuildContext context;
  late final FilterCubit _cubit;
  TextEditingController commentController = TextEditingController();

  final List<Map<String, dynamic>> sortingList = [
    {
      "sort": ['PRICE LOW TO HIGH', 'PRICE HIGH TO LOW'],
      "value": ['asc', 'dsc'],
      "select": [false, false]
    }
  ];
  showFilterDialog(BuildContext context, final void Function(String)? onConfirm) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: AppTheme.appRed,
      insetPadding: const EdgeInsets.only(top: 60),
      alignment: Alignment.topCenter,
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: StatefulBuilder(builder: (context, setState) {
            return MultiBlocProvider(
                providers: [
                  BlocProvider<FilterCubit>(create: (context) {
                    _cubit = FilterCubit(context.read<CoreRepository>())
                      ..getFilter();
                    return _cubit;
                  }),
                ],
                child: BlocListener<FilterCubit, FilterState>(
                    listener: (context, state) {
                  if (kDebugMode) {
                    print('state : $state');
                  }
                  if (state is FilterLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }

                  if (state is FilterError) {
                    context.showToast(state.message);
                  }
                }, child: BlocBuilder<FilterCubit, FilterState>(
                        builder: (context, state) {
                  if (state is FilterSuccess) {
                    FilterResponse filterData = state.response;
                    if (kDebugMode) {
                      print('response 3  $filterData');
                    }

                      final selectList = List<bool>.generate(
                          filterData.data!.length, (i) => false);

                    return filterData.data!=null?ListView.builder(
                        shrinkWrap: true,
                        itemCount: filterData.data!.length,
                        itemBuilder: (BuildContext context, int index) {

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                trailing:
                                selectList[index] != true
                                        ? Image.asset(
                                            AppIconKeys.unselected,
                                            height: 20,
                                            width: 20,
                                          )
                                        : Image.asset(
                                            AppIconKeys.selected,
                                            height: 20,
                                            width: 20,
                                          ),
                                title: Text(
                                  filterData.data![index].name!,
                                  style: TextStyle(
                                      color: AppTheme.appWhite, fontSize: 16),
                                  textAlign: TextAlign.start,
                                ),
                                onTap: () {
                                  setState(() {
                                    selectList[index] =
                                        !selectList[index];
                                  });
                                  onConfirm!(filterData.data![index].id!.toString());
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        }):const SizedBox.shrink();
                  }
                  return const SizedBox.shrink();
                })));
          })),
    );
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => dialog);
  }
}
