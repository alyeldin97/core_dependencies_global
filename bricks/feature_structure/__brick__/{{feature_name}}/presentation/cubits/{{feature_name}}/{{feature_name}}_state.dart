// ignore_for_file: public_member_api_docs, sort_constructors_first

part of '{{feature_name}}_cubit.dart';

class {{feature_name}}State {
  final {{feature_name}}Status? {{feature_name.camelCase}}Status;

  {{feature_name}}State({this.{{feature_name.camelCase}}Status});

  {{feature_name}}State copyWith({
    {{feature_name}}Status? {{feature_name.camelCase}}Status,
  }) {
    return {{feature_name}}State(
      {{feature_name.camelCase}}Status: {{feature_name.camelCase}}Status ?? this.{{feature_name.camelCase}}Status,
    );
  }

  @override
  bool operator ==(covariant {{feature_name}}State other) {
    if (identical(this, other)) return true;
    return other.{{feature_name.camelCase}}Status == {{feature_name.camelCase}}Status;
  }

  @override
  int get hashCode {
    return {{feature_name.camelCase}}Status.hashCode;
  }
}

enum {{feature_name}}Status {
  initial,
  loading,
  success,
  failure,
}


extension {{feature_name}}StateX on {{feature_name}}State {
  bool get isInitial => {{feature_name.camelCase}}Status == {{feature_name}}Status.initial;
  bool get isLoading => {{feature_name.camelCase}}Status == {{feature_name}}Status.loading;
  bool get isSuccess => {{feature_name.camelCase}}Status == {{feature_name}}Status.success;
  bool get isFailure => {{feature_name.camelCase}}Status == {{feature_name}}Status.failure;
}