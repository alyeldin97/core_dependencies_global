import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../../../../../feature_structure/__brick__/feature_structure/news/presentation/data/repo/news_repo.dart';
import '../../../data/model/news.dart';

part 'news_state.dart';

class Cubit extends Cubit<State> {
  final Repo _Repo;

  Cubit(this._Repo) 
      : super(State());
}
