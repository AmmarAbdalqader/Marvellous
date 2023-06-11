import 'package:flutter/cupertino.dart';
import 'package:marvel/models/marvel_characters.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({Key? key, required this.character}) : super(key: key);

  final MarvelCharacters character;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(character.name!),
      subtitle: Text(character.description!),
      leading: Image(
        width: 60,
        fit: BoxFit.fitWidth,
        image: NetworkImage(
            "${character.thumbnail!.path!}.${character.thumbnail!.extension!}"),
      ),
    );
  }
}
