import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel/constants/app_colors.dart';
import 'package:marvel/models/marvel_characters.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({Key? key, required this.character}) : super(key: key);

  final MarvelCharacters character;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        character.name!,
        // style: const TextStyle(color: white),
      ),
      subtitle: Text(character.description!),
      leading: Image(
        width: 120,
        height: 120,
        fit: BoxFit.fitWidth,
        image: NetworkImage(
            "${character.thumbnail!.path!}.${character.thumbnail!.extension!}"),
      ),
    );
  }
}
