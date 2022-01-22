part of 'museum_cubit.dart';

@immutable
abstract class MuseumState {}

class MuseumInitial extends MuseumState {}

class ExhibitionsLoading extends MuseumState {}

class ExhibitionsLoaded extends MuseumState {
  final List<Exhibition> exhibitions;
  ExhibitionsLoaded(this.exhibitions);
}

class ExhibitionsLoadingError extends MuseumState {}
