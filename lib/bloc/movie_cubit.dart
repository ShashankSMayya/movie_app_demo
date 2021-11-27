import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/model/movie_response_model.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';
import 'package:movie_app/domain/app_error.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.movieRepository) : super(MovieInitial());
  final MovieRepository movieRepository;

  void loadMovies() async {
    emit(MovieLoading());
    final Either<AppError, List<Results>> response =
        await movieRepository.getMovies();
    response.fold((l) => emit(MovieLoadFailed(l.appErrorType)),
        (r) => emit(MovieLoadSuccess(r)));
  }
}
