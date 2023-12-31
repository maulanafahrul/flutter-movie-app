import 'dart:convert';

import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/review.dart';

class Api {
  static const _trendingUrl =
      '${Constants.baseUrl}/trending/movie/day?api_key=${Constants.apiKey}';
  static const _topRatedUrl =
      '${Constants.baseUrl}/movie/top_rated?api_key=${Constants.apiKey}';
  static const _upcomingUrl =
      '${Constants.baseUrl}/movie/upcoming?api_key=${Constants.apiKey}';
  static const _genreMovies =
      '${Constants.baseUrl}/genre/movie/list?api_key=${Constants.apiKey}&language=en-US';

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topRatedUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upcomingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Review>> getMovieReviews(int movieId) async {
    final response = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/movie/$movieId/reviews?api_key=${Constants.apiKey}'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> reviewsData = data['results'];
      final List<Review> reviews =
          reviewsData.map((reviewData) => Review.fromJson(reviewData)).toList();

      return reviews;
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<List<Genre>> getMovieGenres() async {
    final response = await http.get(Uri.parse(_genreMovies));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final genresData = data['genres'] as List<dynamic>;

      final genres = genresData
          .map((genreData) => Genre.fromJson(genreData))
          .toList()
          .cast<Genre>();

      return genres;
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<Movie>> getMoviesByGenre(int genreId) async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/discover/movie?with_genres=$genreId&api_key=${Constants.apiKey}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Movie> movies = List<Movie>.from(
          data['results'].map((movieData) => Movie.fromJson(movieData)));
      return movies;
    } else {
      throw Exception('Failed to load movies by genre');
    }
  }
}
