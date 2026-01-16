import 'package:flutter/material.dart';

class LanguageController extends ValueNotifier<bool> {
  LanguageController({bool isEnglish = false}) : super(isEnglish);

  bool get isEnglish => value;

  void toggle() {
    value = !value;
  }

  void setEnglish(bool isEnglish) {
    value = isEnglish;
  }
}

class LanguageScope extends InheritedNotifier<LanguageController> {
  const LanguageScope({
    super.key,
    required LanguageController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static LanguageController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LanguageScope>();
    assert(scope != null, 'LanguageScope not found in widget tree.');
    return scope!.notifier!;
  }
}
