import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/data/model/movie_response_model.dart';
import 'package:movie_app/domain/app_error.dart';

class MovieRepository {
  final ApiClient _apiClient;

  MovieRepository(this._apiClient);

  Future<Either<AppError, List<Results>>> getMovies() async {
    try {
      final response = await _apiClient.get(
        ApiConstants.nowPlayingEndPoint,
      );
      return Right(MovieResponseResult.fromJson(response).results);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
