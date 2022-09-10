import 'package:equatable/equatable.dart';

import '../../repository/models/university.dart';

abstract class UniversityState extends Equatable {
  const UniversityState();

  @override
  List<Object> get props => [];
}

class GetUniversityInitial extends UniversityState {}

class NoneState extends UniversityState {}

class HasUniversityState extends UniversityState {
  final List<UniversityModel> universities;
  const HasUniversityState({required this.universities});
}

class FinishWithError extends UniversityState {
  final String error;

  const FinishWithError({required this.error});

  @override
  String toString() => '$runtimeType { error }';
}
