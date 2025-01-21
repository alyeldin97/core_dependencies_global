import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../../../../../feature_structure/__brick__/feature_structure/{{feature_name}}/presentation/data/repo/{{feature_name}}_repo.dart';
import '../../../data/model/{{feature_name}}.dart';

part '{{feature_name}}_state.dart';

class {{feature_name}}Cubit extends Cubit<{{feature_name}}State> {
  final {{feature_name}}Repo _{{feature_name.camelCase}}Repo;

  {{feature_name}}Cubit(this._{{feature_name.camelCase}}Repo) 
      : super({{feature_name}}State());
}
