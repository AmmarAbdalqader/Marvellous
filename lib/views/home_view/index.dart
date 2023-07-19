import 'package:animated_card/animated_card.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:marvel/models/marvel_characters.dart';
import 'package:marvel/models/marvel_movies.dart';
import 'package:marvel/models/marvel_series.dart';
import 'package:shimmer/shimmer.dart';
// import '../../constants/app_colors.dart';
import '../../controllers/home_controller.dart';
import 'components/character_tile.dart';

// class HomeView extends GetView<controller> {
//   const HomeView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: controller.obx(
//               (data) => ListView.separated(
//                 itemCount: data!.length,
//                 separatorBuilder: (_, index) => const Divider(
//                   height: 22,
//                   endIndent: 18,
//                   indent: 18,
//                 ),
//                 itemBuilder: (_, index) =>
//                     CharacterTile(character: data[index]),
//               ),
//               onEmpty: const Center(
//                 child: Text("Empty"),
//               ),
//               onError: (error) => const Center(
//                 child: Text("Error"),
//               ),
//               onLoading: const Center(
//                 child: CircularProgressIndicator.adaptive(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_api_example/controllers/character_controller.dart';
import 'package:marvel_api_example/controllers/movie_controller.dart';
import 'package:marvel_api_example/controllers/series_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:animated_card/animated_card.dart';

class HomeView extends StatelessWidget {
  final CharacterController characterController = Get.find<CharacterController>();
  final MovieController movieController = Get.find<MovieController>();
  final SeriesController seriesController = Get.find<SeriesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel API Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Characters',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
                  () {
                if (characterController.isLoading.value) {
                  return _buildLoadingIndicator();
                } else if (characterController.errorMessage.value.isNotEmpty) {
                  return _buildErrorMessage(characterController.errorMessage.value);
                } else {
                  return _buildCharacterList();
                }
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Movies',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
                  () {
                if (movieController.isLoading.value) {
                  return _buildLoadingIndicator();
                } else if (movieController.errorMessage.value.isNotEmpty) {
                  return _buildErrorMessage(movieController.errorMessage.value);
                } else {
                  return _buildMovieList();
                }
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Series',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
                  () {
                if (seriesController.isLoading.value) {
                  return _buildLoadingIndicator();
                } else if (seriesController.errorMessage.value.isNotEmpty) {
                  return _buildErrorMessage(seriesController.errorMessage.value);
                } else {
                  return _buildSeriesList();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 120,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildCharacterList() {
    return Container(
      height: 220,
      child: Swiper(
        itemCount: characterController.characters.length,
        itemBuilder: (BuildContext context, int index) {
          final character = characterController.characters[index];
          return AnimatedCard(
            direction: AnimatedCardDirection.left,
            initDelay: Duration(milliseconds: 200),
            duration: Duration(seconds: 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: CachedNetworkImageProvider(character.image),
                    ),
                    SizedBox(height: 8),
                    DefaultTextStyle(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(character.name),
                        ],
                        isRepeatingAnimation: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        viewportFraction: 0.4,
        scale: 0.8,
      ),
    );
  }

  Widget _buildMovieList() {
    return Container(
      height: 220,
      child: Swiper(
        itemCount: movieController.movies.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = movieController.movies[index];
          return AnimatedCard(
            direction: AnimatedCardDirection.bottom,
            initDelay: Duration(milliseconds: 200),
            duration: Duration(seconds: 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(movie.posterUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextStyle(
                        style: TextStyle(fontWeight: FontWeight.bold),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(movie.title),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        viewportFraction: 0.6,
        scale: 0.9,
      ),
    );
  }

  Widget _buildSeriesList() {
    return Container(
      height: 220,
      child: Swiper(
        itemCount: seriesController.series.length,
        itemBuilder: (BuildContext context, int index) {
          final series = seriesController.series[index];
          return AnimatedCard(
            direction: AnimatedCardDirection.right,
            initDelay: Duration(milliseconds: 200),
            duration: Duration(seconds: 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(series.coverUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextStyle(
                        style: TextStyle(fontWeight: FontWeight.bold),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(series.title),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        viewportFraction: 0.6,
        scale: 0.9,
      ),
    );
  }
}*/

class HomeView extends GetView<HomeController> {
  // final controller controller = Get.find<controller>();

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marvel API Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Characters',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          controller.obx(
            (state) {
              if (controller.charactersList.isEmpty) {
                return _buildLoadingIndicator();
                // if (controller.hasError) {
                //   return _buildErrorMessage(controller.errorMessage);
                // } else {
                //   return _buildLoadingIndicator();
                // }
              } else {
                return _buildCharacterList(controller.charactersList);
              }
            },
            onLoading: _buildLoadingIndicator(),
          ),
          const SizedBox(height: 20),
          // const Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Text(
          //     'Movies',
          //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // Obx(
          //   () {
          //     if (controller.moviesList.isEmpty) {
          //       return _buildLoadingIndicator();
          //       // if (controller.hasError) {
          //       //   return _buildErrorMessage(controller.errorMessage);
          //       // } else {
          //       //   return _buildLoadingIndicator();
          //       // }
          //     } else {
          //       return _buildMovieList(controller.moviesList);
          //     }
          //   },
          // ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Series',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          controller.obx(
            (state) {
              if (controller.seriesList.isEmpty) {
                return _buildLoadingIndicator();
                // if (controller.hasError) {
                //   return _buildErrorMessage(controller.errorMessage);
                // } else {
                //   return _buildLoadingIndicator();
                // }
              } else {
                return _buildSeriesList(controller.seriesList);
              }
            },
            onLoading: _buildLoadingIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 120,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget _buildErrorMessage(String message) {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Text(
  //         message,
  //         style: const TextStyle(fontSize: 16, color: Colors.red),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCharacterList(List<MarvelCharacters> characters) {
    return Expanded(
      child: ListView.separated(
        itemCount: characters.length,
        separatorBuilder: (_, index) => const Divider(
          height: 22,
          endIndent: 18,
          indent: 18,
        ),
        itemBuilder: (_, index) => CharacterTile(character: characters[index]),
      ),

      // CardSwiper(
      //   cardsCount: characters.length,
      //   cardBuilder: (BuildContext context, int index) {
      //     final character = characters[index];
      //     return AnimatedCard(
      //       direction: AnimatedCardDirection.left,
      //       initDelay: const Duration(milliseconds: 200),
      //       duration: const Duration(seconds: 1),
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Card(
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(16.0),
      //           ),
      //           elevation: 4,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               CircleAvatar(
      //                 radius: 60,
      //                 backgroundImage: NetworkImage(
      //                     "${character.thumbnail!.path}.${character.thumbnail!.extension}"),
      //               ),
      //               const SizedBox(height: 8),
      //               DefaultTextStyle(
      //                 style: const TextStyle(fontWeight: FontWeight.bold),
      //                 child: AnimatedTextKit(
      //                   animatedTexts: [
      //                     TypewriterAnimatedText(character.name!),
      //                   ],
      //                   isRepeatingAnimation: false,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      //   // viewportFraction: 0.4,
      //   scale: 0.8,
      // ),
    );
  }

  // Widget _buildMovieList(List<MarvelMovies> movies) {
  //   return SizedBox(
  //     height: 220,
  //     child: CardSwiper(
  //       cardsCount: movies.length,
  //       cardBuilder: (BuildContext context, int index) {
  //         final movie = movies[index];
  //         return AnimatedCard(
  //           direction: AnimatedCardDirection.bottom,
  //           initDelay: const Duration(milliseconds: 200),
  //           duration: const Duration(seconds: 1),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Card(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(16.0),
  //               ),
  //               elevation: 4,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: [
  //                   Container(
  //                     height: 120,
  //                     decoration: BoxDecoration(
  //                       image: DecorationImage(
  //                         image: NetworkImage(movie.posterUrl),
  //                         fit: BoxFit.cover,
  //                       ),
  //                       borderRadius: const BorderRadius.vertical(
  //                           top: Radius.circular(16.0)),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: DefaultTextStyle(
  //                       style: const TextStyle(fontWeight: FontWeight.bold),
  //                       child: AnimatedTextKit(
  //                         animatedTexts: [
  //                           TypewriterAnimatedText(movie.title),
  //                         ],
  //                         isRepeatingAnimation: false,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //       // viewportFraction: 0.6,
  //       scale: 0.9,
  //     ),
  //   );
  // }

  Widget _buildSeriesList(List<MarvelSeries> seriesList) {
    return Expanded(
      child: ListView.separated(
        itemCount: seriesList.length,
        separatorBuilder: (_, index) => const Divider(
          height: 22,
          endIndent: 18,
          indent: 18,
        ),
        itemBuilder: (context, index) {
          return CupertinoListTile(
            title: Text(
              seriesList[index].title,
              // style: const TextStyle(color: white),
            ),
            subtitle: Text(seriesList[index].id.toString()),
            leading: Image(
              width: 60,
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                  "${seriesList[index].thumbnail.path!}.${seriesList[index].thumbnail.extension!}"),
            ),
          );
        },
      ),

      // CardSwiper(
      //   cardsCount: seriesList.length,
      //   numberOfCardsDisplayed: 3,
      //   cardBuilder: (BuildContext context, int index) {
      //     final series = seriesList[index];
      //     return AnimatedCard(
      //       direction: AnimatedCardDirection.right,
      //       initDelay: const Duration(milliseconds: 200),
      //       duration: const Duration(seconds: 1),
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Card(
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(16.0),
      //           ),
      //           elevation: 4,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.stretch,
      //             children: [
      //               Container(
      //                 height: 120,
      //                 decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                     image: NetworkImage(
      //                         "${series.thumbnail.path}.${series.thumbnail.extension}"),
      //                     fit: BoxFit.cover,
      //                   ),
      //                   borderRadius: const BorderRadius.vertical(
      //                       top: Radius.circular(16.0)),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: DefaultTextStyle(
      //                   style: const TextStyle(fontWeight: FontWeight.bold),
      //                   child: AnimatedTextKit(
      //                     animatedTexts: [
      //                       TypewriterAnimatedText(series.title),
      //                     ],
      //                     isRepeatingAnimation: true,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      //   // viewportFraction: 0.6,
      //   scale: 0.8,
      //   initialIndex: 5,
      // ),
    );
  }
}
