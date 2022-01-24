import 'package:app/models/exhibition.dart';
import 'package:app/models/museum.dart';
import 'package:app/models/ticket.dart';
import 'package:app/services/museum_repository.dart';
import 'package:app/services/user_repository.dart';
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

  void getMuseumById(String id) async {
    emit(MuseumLoading());
    Museum museum = await museumRepository.getMuseumsById(id);
    emit(MuseumLoaded(museum));
  }
}
