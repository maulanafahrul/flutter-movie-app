import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/movies_slider.dart';

class GenreMoviesSlider extends StatelessWidget {
  final List<Genre> genres;
  final Function(Movie) onMovieSelected;
  const GenreMoviesSlider({
    Key? key,
    required this.genres,
    required this.onMovieSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final genre in genres)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  genre.name,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder(
                  future: Api().getMoviesByGenre(genre.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      // Use snapshot.data directly instead of passing snapshot
                      return MoviesSlider(
                        snapshot: snapshot, // Pass the list of movies
                        onMovieSelected: onMovieSelected,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
        ],
      ),
    );
  }
}
