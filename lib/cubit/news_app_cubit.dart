import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/view/bussiness_screen.dart';
import 'package:newsapp/view/science_screen.dart';
import 'package:newsapp/view/settings/settings.dart';
import 'package:newsapp/view/sport_screen.dart';
import '../networl/remote/dio.dart';
import 'news_app_state.dart';
import 'package:flutter/material.dart';

class NewsAppCubit extends Cubit<NewsAppState> {
  NewsAppCubit() : super(NewsAppInitial());
  static NewsAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),

  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportScreen(),
    const ScienceScreen(),

  ];

  void changeIndex(value) {
    currentIndex = value;
    if (value == 0) {
      getBusiness();
    } else if (value == 1) {
      getSports();
    } else if (value == 2) {
      getScience();
    }

    emit(ChangeBottomNav());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(LoadingBusinessData());
    DioHelper.getDate(
        url:
            'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=427540fb608d431186b83a96451229a7',
        query: {}).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(GetBusinessSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetBusinessError());
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(LoadingSportData());
    DioHelper.getDate(
        url:
            'https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=427540fb608d431186b83a96451229a7',
        query: {
          // 'country': 'us',
          // 'category': 'sports',
          // 'apikey': '427540fb608d431186b83a96451229a7',
        }).then((value) {
      sports = value.data['articles'];
      print(sports[0]['title']);
      emit(GetSportsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetSportsError());
    });
  }

  List<dynamic> science = [];
  void getScience() {
    emit(LoadingScienceData());
    DioHelper.getDate(
        url:
            'https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=427540fb608d431186b83a96451229a7',
        query: {
          // 'country': 'eg',
          // 'category': 'science',
          // 'apikey': '427540fb608d431186b83a96451229a7',
        }).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);

      emit(GetScienceSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetScienceError());
    });
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(GetSearchSuccess());
    search = [];
    DioHelper.getDate(
      url: 'https://newsapi.org/v2/everything',
      query: {
        'q': value,
        'from': '2023-06-28',
        'sortBy': 'publishedAt',
        'apiKey': '4e285617e30d44a0bc76ec9f3ba0c552',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(GetSearchSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchError());
    });
  }

}
