import 'package:equatable/equatable.dart';

abstract class UniversityEvent extends Equatable {
  const UniversityEvent();

  @override
  List<Object> get props => [];
}

class UniversityInitialEvent extends UniversityEvent {}

class NoneEvent extends UniversityEvent {}

class GetUniversitysEvent extends UniversityEvent {
  final int page;
  const GetUniversitysEvent({required this.page});
}
