import '../remote/{{feature_name}}_rds.dart';

abstract class {{feature_name}}Repository {
  final {{feature_name}}RDS {{feature_name}}rds;

  {{feature_name}}Repository(this.{{feature_name}}rds);

  Future<void> getData();
}