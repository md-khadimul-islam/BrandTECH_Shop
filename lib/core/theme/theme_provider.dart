import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_constants.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  late Box _box;

  @override
  ThemeMode build() {
    _box = Hive.box(AppConstants.themeBoxName);
    final isDark = _box.get(AppConstants.themeKey, defaultValue: false) as bool;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggle() {
    final isDark = state == ThemeMode.dark;
    _box.put(AppConstants.themeKey, !isDark);
    state = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
