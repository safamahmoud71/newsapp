



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/component/component.dart';
import 'package:newsapp/cubit/news_app_cubit.dart';
import 'package:newsapp/cubit/news_app_state.dart';

class Search extends StatelessWidget {

  TextEditingController SearchController = TextEditingController();

  Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        NewsAppCubit myCubit = NewsAppCubit.get(context);
        return Scaffold(

          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: SearchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        label: Text('Search' , style: TextStyle(
                          color: Colors.grey
                        ),),
                        prefix: Icon(Icons.search_sharp ,color: Colors.grey,),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.deepOrange,
                        ),
                      ),


                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Please Enter Your Search';

                      return null;
                    },
                    onChanged: (value){
                      myCubit.getSearch(value);
                    },

                  ),
                ),

                Expanded(
                   child: ListView.builder(
                     shrinkWrap: true,
                     itemCount: myCubit.search.length,
                     itemBuilder: (context, index) {
                       return Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: NewsContainer(article: myCubit.search[index]),
                       );
                     },
                   ),
                 )



              ],
            ),
          ),
        );
      },
    );
  }
}
