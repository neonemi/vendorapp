import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive/hive.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendorapp/ui/ui.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CartAdapter());
  await Hive.openBox('cartBox');
  await Hive.openBox('keyedBox');
  // Hive.box<Cart>('keyedBox');
  final LocalRepository localRepository = await LocalRepository.instance;
  runApp( MyApp( localRepository: localRepository,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key, this.localRepository});
  //Local database which contains SharedPreference
  final LocalRepository? localRepository;

   final _navKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? Colors.black : Colors.red,
    ));
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalRepository>(
          create: (context) => localRepository!,
          lazy: true,
        ),
        RepositoryProvider<CoreRepository>(
          create: (context) =>
              CoreRepository(localRepository: context.read<LocalRepository>()),
          lazy: true,
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AppCoreCubit>(create: (context) {
                return AppCoreCubit(
                  repository: context.read<CoreRepository>()
                );
              }),
              BlocProvider<ConnectivityCubit>(
                create: (context) => ConnectivityCubit(),
              ),
            ],
            child:   GlobalLoaderOverlay(
              overlayOpacity: 0.5,
              overlayColor: Colors.brown.withOpacity(0.5),
              useDefaultLoading: false,
              overlayWidget:  Center(
                child: CircularProgressIndicator(color: AppTheme.appRed,),
              ),
              child: MultiBlocListener(
                listeners: [
                  BlocListener<AppCoreCubit, AppCoreState>(
                    listener: (context, state) {
                      if (state is AppCoreRequestTimeOut) {
                        _navKey.currentState!.context.showTimeOutAlert();
                        context.showToast('Time Out');
                      }
                      if (state is AppCoreRequestError) {
                       _navKey.currentState!.context.showToast(state.error);
                      }
                    },
                  ),
                ],
                child: Column(
                  children: [
                    BlocBuilder<ConnectivityCubit, ConnectivityState>(
                      builder: (context, state) {
                        if (state is ConnectivityOffline) {
                          return  _ConnectionStatusAppBar(
                            title:"No internet",
                            color: AppTheme.appRed,
                            icon: Icons.signal_wifi_connected_no_internet_4,
                          );
                        }
                        if (state is ConnectivityRestored) {
                          return  _ConnectionStatusAppBar(
                            title:"Internet restored",
                            color: AppTheme.appGreen,
                            icon: Icons.signal_wifi_4_bar,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    Expanded(
                      child: MaterialApp(
                        navigatorKey: _navKey,
                        title: 'Flutter Demo',
                        navigatorObservers: [FlutterSmartDialog.observer],
                        builder: FlutterSmartDialog.init(),
                        debugShowCheckedModeBanner: false,
                        theme: AppTheme().getThemeData(context),
                        home: const SplashScreen(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}



class _ConnectionStatusAppBar extends StatelessWidget {
  const _ConnectionStatusAppBar({
    required this.title,
    this.color,
    this.icon,
  });

  final String title;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: double.maxFinite,
      color: color,
      padding: const EdgeInsets.only(bottom: 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child:
        Row(
          textDirection: TextDirection.ltr,
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Icon(
                icon,
                color: Colors.white,
                size: 15,
              ),
            ),
            const SizedBox(width: 8),
        Directionality(
           textDirection: TextDirection.ltr,
           child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            )),
          ],
        ),
      ),
    );
  }
}