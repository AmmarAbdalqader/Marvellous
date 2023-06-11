import 'package:get/get.dart';
import '../models/marvel_characters.dart';

class HomeController extends GetxController with StateMixin<List> {
  RxList<MarvelCharacters> charactersList = <MarvelCharacters>[].obs;

  @override
  Future onReady() async {
    await getCharacters();
    super.onReady();
  }

  Future getCharacters() async {
    change([], status: RxStatus.loading());
    try {
      await MarvelCharacters.getCharacters()
          .then((value) => change(value, status: RxStatus.success()));
    } catch (e) {
      change([], status: RxStatus.error());
    }
  }
}
