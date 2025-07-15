class CodeWriter {
  final sb = StringBuffer();
  int _indent = 0;
  final String _indentString;

  CodeWriter({int indent = 0, String indentString = '  '})
      : _indent = indent,
        _indentString = indentString;

  void writeln([Object? obj = "", bool? indent]) {
    if (indent == false) {
      _indent--;
    }
    for (var i = 0; i < _indent; i++) {
      sb.write(_indentString);
    }
    sb.writeln(obj);
    if (indent == true) {
      _indent++;
    }
  }

  void writeIndent(void Function(CodeWriter writer) onWrite,
      [int indentCount = 1]) {
    _indent += indentCount;
    onWrite(this);
    _indent -= indentCount;
  }

  void writelnWithIndent(String object, [int indentCount = 1]) {
    _indent += indentCount;
    for(final o in object.split('\n')) {
      writeln(o);
    }
    _indent -= indentCount;
  }

  void writelnCurlyBrace(
    String opening,
    void Function(CodeWriter writer) onWrite,
  ) {
    writeln('$opening {', true);
    onWrite(this);
    writeln('}', false);
  }

  void openIndent(int count) {
    _indent += count;
  }

  void closeIndent(int count) {
    _indent -= count;
  }

  void ln() {
    sb.writeln();
  }

  @override
  String toString() {
    return sb.toString();
  }
}
