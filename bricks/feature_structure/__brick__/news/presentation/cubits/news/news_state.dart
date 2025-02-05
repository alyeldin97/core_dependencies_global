// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'news_cubit.dart';

class State {
  final Status? Status;

  State({this.Status});

  State copyWith({
    Status? Status,
  }) {
    return State(
      Status: Status ?? this.Status,
    );
  }

  @override
  bool operator ==(covariant State other) {
    if (identical(this, other)) return true;
    return other.Status == Status;
  }

  @override
  int get hashCode {
    return Status.hashCode;
  }
}

enum Status {
  initial,
  loading,
  success,
  failure,
}


extension StateX on State {
  bool get isInitial => Status == Status.initial;
  bool get isLoading => Status == Status.loading;
  bool get isSuccess => Status == Status.success;
  bool get isFailure => Status == Status.failure;
}