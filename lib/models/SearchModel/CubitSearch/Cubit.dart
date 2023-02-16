import 'package:dio/dio.dart';
import 'package:ecommers/layout/Shop/Cubit/Cubit.dart';
import 'package:ecommers/models/SearchModel/FavoriteModel.dart';
import 'package:ecommers/shared/network/remote/dio_helper.dart';
import 'package:ecommers/shared/network/remote/end_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'States.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(Searchinitaialstate());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void Getsearch(String? text) {
    emit(Searchloadingstate());
    DioHelper.postdata(url: SearchApi, data: {'text': text!}).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchsuccessState());
    }).catchError((onError) {
      print("==========================${onError} =====================");
      emit(SearchErrorstate());
    });
  }
}
