import 'package:get/get.dart';
import '../models/marvel_characters.dart';
// import '../models/marvel_movies.dart';
import '../models/marvel_series.dart';

class HomeController extends GetxController with StateMixin {
  RxList<MarvelCharacters> charactersList = <MarvelCharacters>[].obs;
  // RxList<MarvelMovies> moviesList = <MarvelMovies>[].obs;
  RxList<MarvelSeries> seriesList = <MarvelSeries>[].obs;

  // @override
  // Future onReady() async {
  //   await getCharacters();
  //   super.onReady();
  // }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future fetchData() async {
    try {
      change([], status: RxStatus.loading());
      final characterResponse = await MarvelCharacters.fetchCharacters();
      // final movieResponse = await MarvelMovies.fetchMovies();
      final seriesResponse = await MarvelSeries.fetchSeries();
      charactersList.value = characterResponse;
      // moviesList.value = movieResponse;
      seriesList.value = seriesResponse;
      change(charactersList, status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.error(error.toString()));
    }
  }

  // Future getCharacters() async {
  //   change([], status: RxStatus.loading());
  //   try {
  //     List<MarvelCharacters> list = await MarvelCharacters.fetchCharacters();
  //     charactersList.addAll(list);
  //     change(list, status: RxStatus.success());
  //   } catch (e) {
  //     change([], status: RxStatus.error());
  //   }
  // }
  //
  // Future getMovies() async {
  //   change([], status: RxStatus.loading());
  //   try {
  //     List<MarvelMovies> list = await MarvelMovies.fetchMovies();
  //     moviesList.addAll(list);
  //     change(list, status: RxStatus.success());
  //   } catch (e) {
  //     change([], status: RxStatus.error());
  //   }
  // }
  //
  // Future getSeries() async {
  //   change([], status: RxStatus.loading());
  //   try {
  //     List<MarvelSeries> list = await MarvelSeries.fetchSeries();
  //     seriesList.addAll(list);
  //     change(value, status: RxStatus.success());
  //   } catch (e) {
  //     change([], status: RxStatus.error());
  //   }
  // }
}
