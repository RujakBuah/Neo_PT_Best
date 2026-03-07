String insertNewlines(String text, int interval) {
  List<String> lines = text.split('\n');
  String result = '';
  for (int i = 0; i < lines.length; i++) {
    result += lines[i];
    if (i != lines.length - 1) {
      result += '\n';
    }
    if ((i + 1) % interval == 0 && i != lines.length - 1) {
      result += '\n';
    }
  }
  return result;
}
