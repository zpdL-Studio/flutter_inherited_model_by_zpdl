// ignore_for_file: deprecated_member_use
import 'package:build/build.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_model_builder.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state_builder.dart';
import 'package:source_gen/source_gen.dart';

Builder flutterInheritedModelBuilder(BuilderOptions options) =>
    SharedPartBuilder([
      const FlutterInheritedModelBuilder(),
      const FlutterInheritedStateBuilder(),
    ], 'flutterInheritedModelBuilder');
