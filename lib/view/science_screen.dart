import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/news_app_cubit.dart';
import 'package:newsapp/cubit/news_app_state.dart';

import '../component/component.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        NewsAppCubit mycubit = NewsAppCubit.get(context);

        if (mycubit.science.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              //physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return NewsContainer(article: mycubit.science[index]);
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white60,
                    thickness: 1,
                  ),
                );
              },
              itemCount:mycubit.science.length,

            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}



