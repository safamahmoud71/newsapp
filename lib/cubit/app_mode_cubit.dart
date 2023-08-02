import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newsapp/networl/local/cache_helper.dart';

part 'app_mode_state.dart';

class AppModeCubit extends Cubit<AppModeState> {
  AppModeCubit() : super(AppModeInitial());
  static AppModeCubit get(context) => BlocProvider.of(context);

  bool isDark = true;
  void changeMode({bool? cache}) {
    if (cache != null) {
      isDark = cache;
      emit(ChangeAppMode());
    } else {
      isDark = !isDark;
      CacheHelper.putDate(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppMode());
      });

    }


  }
}
