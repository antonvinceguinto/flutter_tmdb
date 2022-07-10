import 'dart:convert';
import 'package:flutter/material.dart';

@immutable
class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    // required this.backdropPath,
    // required this.overview,
    // required this.releaseDate,
    // required this.voteAverage,
  });

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title']?.toString() ?? '',
      posterPath: map['poster_path']?.toString() ?? '',
      // backdropPath: map['backdropPath'] as String,
      // overview: map['overview'] as String,
      // releaseDate: map['releaseDate'] as String,
      // voteAverage: map['voteAverage'] as double,
    );
  }

  // String get fullImageUrl => 'https://image.tmdb.org/t/p/w500/$posterPath';
  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';

  final int id;
  final String title;
  final String posterPath;
  // final String backdropPath;
  // final String overview;
  // final String releaseDate;
  // final double voteAverage;

  Movie copyWith({
    int? id,
    String? title,
    String? posterPath,
    // String? backdropPath,
    // String? overview,
    // String? releaseDate,
    // double? voteAverage,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
      // backdropPath: backdropPath ?? this.backdropPath,
      // overview: overview ?? this.overview,
      // releaseDate: releaseDate ?? this.releaseDate,
      // voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'poster_path': posterPath,
      // 'backdropPath': backdropPath,
      // 'overview': overview,
      // 'releaseDate': releaseDate,
      // 'voteAverage': voteAverage,
    };
  }

  String toJson() => json.encode(toMap());
}
