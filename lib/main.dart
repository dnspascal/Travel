import 'package:get/get.dart';
import 'package:travel/app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel/core/services/storage.dart';

void main() async {
  Get.lazyPut(() => StorageService(Get.find()));
  await GetStorage.init();
  runApp(const Travel());
}
