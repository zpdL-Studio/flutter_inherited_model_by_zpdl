# flutter_inherited_model_builder

[![pub package](https://img.shields.io/pub/v/flutter_inherited_model_builder.svg)](https://pub.dev/packages/flutter_inherited_model_builder)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

이 패키지는 [flutter_inherited_model](https://pub.dev/packages/flutter_inherited_model)의 코드 생성을 위한 빌더(builder)입니다.

## 중요

이 패키지를 직접 사용할 일은 거의 없습니다. `flutter_inherited_model` 패키지의 일부로, 코드 생성을 자동화하는 역할을 담당합니다.

자세한 사용법과 기능은 메인 패키지의 문서를 참고해주세요.

- **[flutter_inherited_model 패키지 바로가기](https://pub.dev/packages/flutter_inherited_model)**

## 설치하기

`pubspec.yaml` 파일의 `dev_dependencies`에 아래와 같이 `build_runner`와 함께 추가합니다.

```yaml
dev_dependencies:
  flutter_inherited_model_builder: ^0.9.1 # 최신 버전을 확인해주세요.
  build_runner: ^2.4.10 # build_runner 버전은 호환성에 맞게 조정될 수 있습니다.
```

## 라이선스

이 프로젝트는 MIT 라이선스를 따릅니다. 자세한 내용은 `LICENSE` 파일을 참고하세요.