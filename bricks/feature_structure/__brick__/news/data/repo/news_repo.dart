import '../remote/news_rds.dart';

abstract class Repository {
  final RDS rds;

  Repository(this.rds);

  Future<void> getData();
}