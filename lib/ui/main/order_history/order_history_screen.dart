import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/core.dart';
import '../../ui.dart';

class OrderHistoryScreen extends StatefulWidget {
  final bool showAppBar;
  const OrderHistoryScreen({super.key, required this.showAppBar});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late final OrderCubit _cubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderCubit>(
      create: (context) {
        _cubit = OrderCubit(context.read<CoreRepository>())..getOrder();

        return _cubit;
      },
      child: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state is OrderSuccess) {}
          if (state is OrderError) {
            context.showToast(state.message);
          }
        },
        child: Scaffold(
          appBar: widget.showAppBar == true
              ? AppBar(
                  backgroundColor: AppTheme.appRed,
                  centerTitle: true,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: AppTheme.appWhite),
                  title: Container(
                    margin: const EdgeInsets.only(right: 40),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      StringConstant.myOrders,
                      style: TextStyle(
                          color: AppTheme.appWhite,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontFamily: StringConstant.fontFamily),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : null,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              children: [
                if (widget.showAppBar == false)
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      StringConstant.myOrders,
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontFamily: StringConstant.fontFamily),
                      textAlign: TextAlign.center,
                    ),
                  ),
                BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
                  if (state is OrderLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }
                  if (state is OrderSuccess) {
                    GetCustomerOrderResponse response = state.response;
                    return response.data == null
                        ? Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        StringConstant.firstOrderNote,
                        style: TextStyle(
                            color: AppTheme.appBlack,
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            fontFamily: StringConstant.fontFamily),
                        textAlign: TextAlign.center,
                      ),
                    )
                        :response.data!.isEmpty
                        ? Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        StringConstant.firstOrderNote,
                        style: TextStyle(
                            color: AppTheme.appBlack,
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            fontFamily: StringConstant.fontFamily),
                        textAlign: TextAlign.center,
                      ),
                    )
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: response.data!.length,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                shadowColor: AppTheme.appGrey,
                                elevation: 2,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppTheme.appWhite,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${StringConstant.orderId} ${response.data![index].id!}'),
                                          Text(
                                              '${StringConstant.price} ${StringConstant.rupeeSymbol}${response.data![index].finalamount!}'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${StringConstant.date} ${DateTime.parse(response.data![index].createdAt!).year}-${DateTime.parse(response.data![index].createdAt!).month}-${DateTime.parse(response.data![index].createdAt!).day}'),
                                        ],
                                      ),
                                      const Divider(),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    AppTheme.appRed,
                                                elevation: 3,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                alignment: Alignment.center,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0)),
                                                //fixedSize: const Size(100, 30),
                                                //////// HERE
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            OrderDetailsScreen(
                                                              orderitems: response
                                                                  .data![index]
                                                                  .orderitems!, customerOrderData:  response.data![index],
                                                            )));
                                              },
                                              child: const Text(
                                                StringConstant.view,
                                                style: TextStyle(fontSize: 14),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    AppTheme.appRed,
                                                elevation: 3,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                alignment: Alignment.center,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0)),
                                                // fixedSize: const Size(100, 30),
                                                //////// HERE
                                              ),
                                              onPressed: () {},
                                              child: const Text(
                                                StringConstant.cancel,
                                                style: TextStyle(fontSize: 14),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                  }
                  return Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      StringConstant.firstOrderNote,
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontFamily: StringConstant.fontFamily),
                      textAlign: TextAlign.center,
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
    //const Center(child: Text("order",style: TextStyle(color: Colors.red),));
  }
}
