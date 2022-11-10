import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:vendorapp/ui/ui.dart';

import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      statusBarColor: isDarkMode ? Colors.black : Colors.white,
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
            child:  MultiBlocListener(
              listeners: [
                BlocListener<AppCoreCubit, AppCoreState>(
                  listener: (context, state) {
                    if (state is AppCoreRequestTimeOut) {
                      // _navKey.currentState!.context.showTimeOutAlert();
                      // context.showToast(LocaleCoreKeys.core_timeOut.tr());
                    }
                    if (state is AppCoreRequestError) {
                    //  _navKey.currentState!.context.showToast(state.error);
                    }
                  },
                ),
              ],
              child: Column(
                children: [
                  BlocBuilder<ConnectivityCubit, ConnectivityState>(
                    builder: (context, state) {
                      if (state is ConnectivityOffline) {
                        return _ConnectionStatusAppBar(
                          title:"No internet",
                        );
                      }
                      if (state is ConnectivityRestored) {
                        return _ConnectionStatusAppBar(
                          title:"Internet restored",
                          color: Colors.green,
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
                      debugShowCheckedModeBanner: false,
                      theme: AppTheme().getThemeData(context),
                      home: const MyHomePage(title: 'Flutter Demo Home Page'),
                    ),
                  ),
                ],
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
      color: color ?? Colors.red,
      padding: const EdgeInsets.only(bottom: 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.signal_wifi_connected_no_internet_4,
              color: Colors.white,
              size: 15,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}