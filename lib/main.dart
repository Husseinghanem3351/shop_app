import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_app_layout/Shop_Layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shop_app/Shop_Login/Shop_Login.dart';
import 'package:shop_app/shop_app/on_boarding/on_boarding.dart';

import 'layout/shop_app_layout/cubit/cubit.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  late Widget widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? isOnBoarding = CacheHelper.getData(key: 'isOnBoarding');
  String? token = CacheHelper.getData(key: 'token');
  print('token $token');
  if (isOnBoarding != null) {
    if (token != null) {
      widget = const Shop_Layout();
    } else {
      widget = ShopLogin();
    }
  } else {
    widget = const OnBoarding();
  }
  runApp( MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget, required this.isDark});
  final Widget startWidget;
  final bool? isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavorites()
            ..getSearchData('')
            ..getCart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: startWidget,
      ),
    );
  }
}

