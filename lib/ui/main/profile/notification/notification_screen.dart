import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendorapp/core/core.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationCubit _cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationCubit>(
      create: (context) {
        _cubit = NotificationCubit(context.read<CoreRepository>())
          ..getNotifications();

        return _cubit;
      },
      child: BlocListener<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is NotificationLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
            if (state is NotificationSuccess) {}
            if (state is NotificationError) {
              context.showToast(state.message);
            }
          },
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.appRed,
                // centerTitle: true,
                elevation: 0.0,
                iconTheme: IconThemeData(color: AppTheme.appWhite),
                title: Container(
                  height: 50,
                  margin: const EdgeInsets.only(right: 40),
                  alignment: Alignment.center,
                  child: Text(
                    StringConstant.notification,
                    style: TextStyle(
                        color: AppTheme.appWhite,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: StringConstant.fontFamily),
                    textAlign: TextAlign.center,
                  ),
                ),
                actions: [
                  GestureDetector(
                      onTap: () {
                        _cubit.readNotifications();
                      },
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(
                            Icons.more_vert,
                            color: AppTheme.appWhite,
                            size: 32,
                          )))
                ],
              ),
              body: BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                if (state is NotificationLoading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
                if (state is NotificationSuccess) {}
                if (state is NotificationReadSuccess) {}
                return Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: 0,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Card(
                            color: AppTheme.appWhite,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            child: ListTile(
                              title: Text("Title",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.appBlack,
                                  )),
                              subtitle: Text(
                                  DateTime.now().timeAgo(numericDates: false),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.appGrey,
                                  )),
                            ),
                          ),
                        );
                      }),
                );
              }))),
    );
    //const Center(child: Text("profile",style: TextStyle(color: Colors.red),));
  }
}
