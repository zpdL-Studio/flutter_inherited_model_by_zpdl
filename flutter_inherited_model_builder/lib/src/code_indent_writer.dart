class CodeIndentWriter {
  final sb = StringBuffer();
  int _indent = 0;
  final String _indentString;

  CodeIndentWriter({int indent = 0, String indentString = '  '})
    : _indent = indent,
      _indentString = indentString;

  void _write(String object) {
    if (object.isEmpty) {
      sb.writeln(object);
      return;
    }
    for (var i = 0; i < _indent; i++) {
      sb.write(_indentString);
    }
    sb.writeln(object);
  }

  void write(String object) {
    for (final o in object.split('\n')) {
      _write(o);
    }
  }

  void openIndent() {
    _indent++;
  }

  void closeIndent() {
    _indent--;
  }

  void writeIndent(void Function(CodeIndentWriter codeWriter) onWrite) {
    _indent++;
    onWrite(this);
    _indent--;
  }

  void line() {
    sb.writeln();
  }

  @override
  String toString() {
    return sb.toString();
  }
}
