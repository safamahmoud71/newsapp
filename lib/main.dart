
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/app_mode_cubit.dart';
import 'package:newsapp/networl/local/cache_helper.dart';
import 'package:newsapp/view/news_screen.dart';
import 'component/bloc_observer.dart';
import 'cubit/news_app_cubit.dart';
import 'networl/remote/dio.dart';

void main()  async{

  WidgetsFlutterBinding.ensureInitialized();//ensure that everything is done then reload app
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CacheHelper.init();

 bool? isDark = CacheHelper.getDate(key: 'isDark');

  runApp( MyApp( isDark: isDark,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key, required this.isDark});
   bool? isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppModeCubit()..changeMode(cache: isDark),),
        BlocProvider(create: (context) => NewsAppCubit()..getBusiness()..getScience()..getSports(),)
      ],
      child: BlocConsumer<AppModeCubit, AppModeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AppModeCubit myCubit = AppModeCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  color: Colors.white,
                  titleTextStyle: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 25),
                  iconTheme: IconThemeData(color: Colors.black),
                  elevation: 0.0),
              textTheme: const TextTheme(
                titleLarge: TextStyle(
                  color: Colors.black,
                ),
                titleMedium: TextStyle(
                  color: Colors.black45,
                ),
                titleSmall: TextStyle(
                  color: Colors.white70,
                ),
              ),

              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.deepOrange,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.black26,
              primaryColor: Colors.deepOrange,
              textTheme: const TextTheme(
                titleLarge: TextStyle(
                  color: Colors.white,
                ),
                titleMedium: TextStyle(
                  color: Colors.white70,
                ),
                titleSmall: TextStyle(
                  color: Colors.white70,
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.black26,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 25)),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.black26,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.deepOrange),
            ),
            themeMode: myCubit.isDark? ThemeMode.dark : ThemeMode.light,
            home: const NewsScreen(),
          );
        },
      ),
    );
  }
}
