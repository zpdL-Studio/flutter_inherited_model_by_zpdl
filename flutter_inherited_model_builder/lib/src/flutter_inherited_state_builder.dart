import 'dart:async';

import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:flutter_inherited_model/annotation/annotation.dart';
import 'package:flutter_inherited_model_builder/src/code_indent_writer.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/inherited_model_builder.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/inherited_model_state_builder.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/model_builder.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/annotation_info.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/inherited_model_widget_builder.dart';
import 'package:flutter_inherited_model_builder/src/flutter_inherited_state/mixin_builder.dart';
import 'package:source_gen/source_gen.dart';

class FlutterInheritedStateBuilder
    extends GeneratorForAnnotation<FlutterInheritedState> {
  const FlutterInheritedStateBuilder();

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element2 element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    print(
      'FlutterInheritedValueBuilder -> element : ${element.displayName}, ${annotation.objectValue.type?.getDisplayString()}',
    );

    if (element is! ClassElement2) {
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

    ConstructorElement2? privateConstructor;
    ConstructorElement2? factoryConstructor;

    for (final constructor in element.constructors2) {
      if (constructor.displayName == element.displayName &&
          constructor.isFactory) {
        factoryConstructor = constructor;
      } else if (constructor.displayName == '${element.displayName}._' &&
          !constructor.isFactory) {
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

    final List<FormalParameterElement>? factoryConstructorParameters;
    if (factoryConstructor != null) {
      factoryConstructorParameters = <FormalParameterElement>[];
      for (final parameter in factoryConstructor.formalParameters) {
        if (parameter.isRequiredNamed || parameter.isOptionalNamed) {
          factoryConstructorParameters.add(parameter);
        } else {
          final name = parameter.displayName;
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

    final stateTypeChecker = TypeChecker.typeNamed(InheritedModelState);

    final fields = <FieldElement2>[];
    for (final field in element.fields2) {
      if (stateTypeChecker.hasAnnotationOf(field)) {
        if (!field.isStatic && !field.isFinal && field.isPublic) {
          fields.add(field);
        } else {
          final fieldName = field.displayName;
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
    print('FlutterInheritedValueBuilder -> annotation : $annotationInfo');

    final code = CodeIndentWriter();

    final mixinName = '\$${element.displayName}';
    final modelName = '_\$${element.displayName}';
    final inheritedModelName =
        annotationInfo.name ?? '${element.displayName}InheritedModel';
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
        elementName: element.displayName,
        modelName: modelName,
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
        elementName: element.displayName,
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
