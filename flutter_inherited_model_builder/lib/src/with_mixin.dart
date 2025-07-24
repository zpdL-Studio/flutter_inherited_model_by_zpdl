// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';

class WithMixin {
  static const widgetsBindingObserver = 'WidgetsBindingObserver';

  final bool isWidgetsBindingObserver;

  WithMixin({required this.isWidgetsBindingObserver});

  factory WithMixin.fromElement(ClassElement element) {
    bool isWidgetsBindingObserver = false;

    for (final mixin in element.mixins) {
      switch (mixin.name) {
        case widgetsBindingObserver:
          isWidgetsBindingObserver = true;
          break;
      }
    }

    return WithMixin(isWidgetsBindingObserver: isWidgetsBindingObserver);
  }
}
