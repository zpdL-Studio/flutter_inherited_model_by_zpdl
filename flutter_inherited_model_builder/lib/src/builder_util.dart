import 'package:analyzer/dart/element/type.dart';

extension DartTypeUtil on DartType {
  bool isOptional() {
    final type = '$this';

    if (type.endsWith('?')) {
      return true;
    } else if (type == 'dynamic') {
      return true;
    }
    return false;
  }
}
