import 'package:get/get.dart';
import 'package:travel/app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel/core/controllers/locale_controller.dart';

void main() async {
  await GetStorage.init();
  runApp(const Travel());
}
