import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_quote_generator/core/services/bloc_observer.dart';
import 'package:random_quote_generator/core/services/dio_helper.dart';
import 'package:random_quote_generator/features/view_models/cubit/cubit.dart';
import 'package:random_quote_generator/features/view_models/cubit/states.dart';
import 'package:random_quote_generator/features/views/home_screen.dart';
import 'package:random_quote_generator/features/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<List<String>>('myBox');
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
          create: (BuildContext context) => HomeCubit()..getNewQuote()..getFavorites(),
          child: BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: child,
              );
            },
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}
