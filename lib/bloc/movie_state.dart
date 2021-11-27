part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoadFailed extends MovieState {
  final AppErrorType appErrorType;

  const MovieLoadFailed(this.appErrorType);

  @override
  List<Object> get props => [appErrorType];
}

class MovieLoadSuccess extends MovieState {
  final List<Results> movies;

  const MovieLoadSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}
