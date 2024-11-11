String cleanFormatting(String string) {
  final regex = RegExp(r'<[^>]*>');
  final cleanedText = string.replaceAll(regex, '');
  return cleanedText;
}