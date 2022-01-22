import 'package:app/models/exhibition.dart';
import 'package:app/services/museum_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'museum_state.dart';

class MuseumCubit extends Cubit<MuseumState> {
  final MuseumRepository museumRepository;

  MuseumCubit(this.museumRepository) : super(MuseumInitial());

  void getExhibitions() async {
    emit(ExhibitionsLoading());
    List<Exhibition> exhibitions = await museumRepository.getExhibitions();
    emit(ExhibitionsLoaded(exhibitions));
  }
}
