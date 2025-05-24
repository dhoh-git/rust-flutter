import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:score/repository/search_repository.dart';

import 'package:score/model/google_search.dart';

class SearchController extends GetxController {
  //final SearchRepository searchRepo;
  //SearchController({required this.searchRepo});
  SearchController();

  late final TextEditingController _inputController = TextEditingController();
  late final RxList<GoogleSearch> _curResults = <GoogleSearch>[].obs;

  TextEditingController get keywordController => _inputController;
  List<GoogleSearch> get curResults => _curResults;
  static SearchController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    log("onInit called", name: "search controller");
    debugPrint("onInit called");
  }

  @override
  void onReady() {
    super.onReady();
    log("onReady called", name: "search controller");
  }

  @override
  void onClose() {
    log("onClose called", name: "search controller");
    _inputController.dispose();
    super.onClose();
  }

  void clearTextField() {
    _inputController.clear();
  }

  Future<void> searchOnGoogle(String keyword) async {
    //_curResults.value = await searchRepo.searchOnGoogle(keyword);
    _curResults.add(GoogleSearch(title: 'title'
      ,link: "https://pga.freeddns.org", displayLink: '', mimeType: '', snippet: '', imageUrl: ''));
    debugPrint("$_curResults");
  }
}
