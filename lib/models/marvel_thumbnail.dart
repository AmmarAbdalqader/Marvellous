class Thumbnail {
  String? path;
  String? extension;

  Thumbnail({required this.path, required this.extension});

  factory Thumbnail.fromJson(Map json) => Thumbnail(
        path: json['path'],
        extension: json['extension'],
      );
}
