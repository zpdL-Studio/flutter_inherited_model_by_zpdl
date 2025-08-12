// ignore_for_file: deprecated_member_use
import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutter_inherited_model/annotation/annotation.dart';
import 'package:flutter_inherited_model_builder/src/code_indent_writer.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_model/annotation_info.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_model/inherited_model_builder.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_model/inherited_model_state_builder.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_model/inherited_model_widget_builder.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_model/mixin_builder.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_model/model_builder.dart';
import 'package:source_gen/source_gen.dart';

class FlutterInheritedModelBuilder
    extends GeneratorForAnnotation<FlutterInheritedModel> {
  const FlutterInheritedModelBuilder();

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    print(
      'FlutterInheritedModelBuilder -> element : ${element.name}, ${annotation.objectValue.type?.getDisplayString()}',
    );

    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator cannot be applied to ${element.displayName}.',
        todo: 'This annotation can only be used on classes.',
        element: element,
      );
    }

    if (element.isAbstract) {
      throw InvalidGenerationSourceError(
        'Generator cannot be applied to abstract class ${element.displayName}.',
        todo: 'This annotation can only be used on not abstract classes.',
        element: element,
      );
    }

    ConstructorElement? privateConstructor;
    ConstructorElement? factoryConstructor;

    for (final constructor in element.constructors) {
      if (constructor.name == '' && constructor.isFactory) {
        factoryConstructor = constructor;
      } else if (constructor.name == '_' && !constructor.isFactory) {
        privateConstructor = constructor;
      }
    }

    if (privateConstructor == null) {
      throw InvalidGenerationSourceError(
        'The generator could not find an "${element.displayName}._();" for this ${element.displayName}',
        todo: 'Ensure the class has a "${element.displayName}._();"',
        element: element,
      );
    }

    final List<ParameterElement>? factoryConstructorParameters;
    if (factoryConstructor != null) {
      factoryConstructorParameters = <ParameterElement>[];
      for (final parameter in factoryConstructor.parameters) {
        if (parameter.isRequiredNamed || parameter.isOptionalNamed) {
          factoryConstructorParameters.add(parameter);
        } else {
          final name = parameter.name;
          throw InvalidGenerationSourceError(
            'The construct parameter `$name` is only named parameter',
            todo: 'Please ensure `$name` is changed named parameter',
            element: parameter,
          );
        }
      }
    } else {
      factoryConstructorParameters = null;
    }

    final stateTypeChecker = TypeChecker.fromRuntime(InheritedModelState);

    final fields = <FieldElement>[];
    for (final field in element.fields) {
      if (stateTypeChecker.hasAnnotationOf(field)) {
        if (!field.isStatic && !field.isFinal && field.isPublic) {
          fields.add(field);
        } else {
          final fieldName = field.name;
          throw InvalidGenerationSourceError(
            'The field `$fieldName` annotated with `@FlutterInheritedModelState` must be public, non-static, and non-final.',
            todo:
                'Please ensure `$fieldName` is declared as `late` and is not `static` or `final`.',
            element: field, // Point the error directly to the problematic field
          );
        }
      }
    }

    final annotationInfo = AnnotationInfo.from(annotation);
    print('FlutterInheritedModelBuilder -> annotation : $annotationInfo');
    if (annotationInfo.useSingleTickerProvider &&
        annotationInfo.useTickerProvider) {
      throw InvalidGenerationSourceError(
        'The `useSingleTickerProvider` and `useTickerProvider` annotations cannot be used together',
        todo:
            'Please choose only one or remove the unnecessary annotation (`useSingleTickerProvider` or `useTickerProvider`).',
        element: element,
      );
    }

    final code = CodeIndentWriter();

    final mixinName = '\$${element.name}';
    final modelName = '_\$${element.name}';
    final inheritedModelName =
        annotationInfo.name ?? '${element.name}InheritedModel';
    final inheritedModelStateName = '_${inheritedModelName}State';
    final inheritedModelWidgetName = '_$inheritedModelName';

    code.write(
      MixinBuilder.build(
        annotation: annotationInfo,
        name: mixinName,
        constructorParameters: factoryConstructorParameters ?? [],
        fields: fields,
      ),
    );

    code.write(
      InheritedModelWidgetBuilder.build(
        annotation: annotationInfo,
        name: inheritedModelName,
        elementName: element.name,
        inheritedModelWidgetName: inheritedModelWidgetName,
        inheritedModelStateName: inheritedModelStateName,
        constructorParameters: factoryConstructorParameters ?? [],
        fields: fields,
      ),
    );

    code.write(
      ModelBuilder.build(
        annotation: annotationInfo,
        name: modelName,
        elementName: element.name,
        constructorParameters: factoryConstructorParameters ?? [],
        fields: fields,
      ),
    );

    code.write(
      InheritedModelStateBuilder.build(
        annotation: annotationInfo,
        name: inheritedModelStateName,
        inheritedModelName: inheritedModelName,
        modelName: modelName,
        inheritedModelWidgetName: inheritedModelWidgetName,
        constructorParameters: factoryConstructorParameters ?? [],
        fields: fields,
      ),
    );

    code.write(
      InheritedModelBuilder.build(
        annotation: annotationInfo,
        name: inheritedModelWidgetName,
        modelName: modelName,
        constructorParameters: factoryConstructorParameters ?? [],
        fields: fields,
      ),
    );

    return code.toString();
  }
}
