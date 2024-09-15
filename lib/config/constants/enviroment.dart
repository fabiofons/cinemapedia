import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'There are not api key';
  static String moviebdBaseUrl = dotenv.env['MOVIEDB_BASEURL'] ?? 'There are not base Url';
}