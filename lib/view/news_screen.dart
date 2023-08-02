import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/app_mode_cubit.dart';
import 'package:newsapp/cubit/news_app_cubit.dart';
import 'package:newsapp/cubit/news_app_state.dart';

import 'search_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = NewsAppCubit.get(context);

        return BlocConsumer<AppModeCubit, AppModeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var myCubit = AppModeCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text('News App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search()));
                      }, icon: const Icon(Icons.search)),
                  IconButton(
                    onPressed: () {
                      myCubit.changeMode();
                    },
                    icon: const Icon(Icons.light_mode),
                  )
                ],
              ),

              bottomNavigationBar: BottomNavigationBar(
                items: cubit.items,
                currentIndex: cubit.currentIndex,
                onTap: (int index) {
                  cubit.changeIndex(index);
                },
              ),
              body: cubit.screens[cubit.currentIndex],
            );
          },
        );
      },
    );
  }
}
