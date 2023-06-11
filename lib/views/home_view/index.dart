import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'components/character_tile.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: controller.obx(
              (data) => ListView.separated(
                itemCount: data!.length,
                separatorBuilder: (_, index) => const Divider(
                  height: 22,
                  endIndent: 18,
                  indent: 18,
                ),
                itemBuilder: (_, index) =>
                    CharacterTile(character: data[index]),
              ),
              onEmpty: const Center(
                child: Text("Empty"),
              ),
              onError: (error) => const Center(
                child: Text("Error"),
              ),
              onLoading: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
