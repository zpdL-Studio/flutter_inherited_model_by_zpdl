class CodeWriter {
  final sb = StringBuffer();
  int _indent = 0;

  CodeWriter();

  void writeln([Object? obj = "", bool? indent]) {
    for (var i = 0; i < _indent; i++) {
      sb.write('\t');
    }
    sb.writeln(obj);
    if (indent != null) {
      if (indent) {
        _indent++;
      } else {
        _indent--;
      }
    }
  }

  void writeIndent(
      String opening,
      String closing,
      void Function(CodeWriter writer) onWrite,
      ) {
    writeln(opening, true);
    onWrite(this);
    writeln(closing, false);
  }

  void writelnCurlyBrace(
    String opening,
    void Function(CodeWriter writer) onWrite,
  ) {
    writeln('$opening {', true);
    onWrite(this);
    writeln('}', false);
  }

  void ln() {
    sb.writeln();
  }

  @override
  String toString() {
    return sb.toString();
  }
}
