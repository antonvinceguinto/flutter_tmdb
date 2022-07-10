import 'dart:convert';
import 'package:flutter/material.dart';

@immutable
class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title']?.toString() ?? '',
      posterPath: map['poster_path']?.toString() ?? '',
      backdropPath: map['backdrop_path']?.toString() ?? '',
      overview: map['overview']?.toString() ?? '',
      releaseDate: map['releaseDate']?.toString() ?? '',
      voteAverage: double.tryParse(map['voteAverage'].toString()) ?? 0,
    );
  }

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';
  String get fullImageUrlHD => 'https://image.tmdb.org/t/p/w500$posterPath';
  String get fullBackdropImageUrl =>
      'https://image.tmdb.org/t/p/w500$backdropPath';

  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  Movie copyWith({
    int? id,
    String? title,
    String? posterPath,
    String? backdropPath,
    String? overview,
    String? releaseDate,
    double? voteAverage,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'overview': overview,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
    };
  }

  String toJson() => json.encode(toMap());
}
