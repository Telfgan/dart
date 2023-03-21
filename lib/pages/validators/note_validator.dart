class NoteValidators {
  static const String contentErrorMessage =
      "Invalid content! It must be at least 10 symbols, but not longer than 200 symbols.";
  static const String nameErrorMessage =
      "Ivalid name of the note. It must be at least 5 characters";

  String? contentValidator(String? val) {
    final String content = val as String;

    if (content.length <= 10 || content.length >= 200 || content.isEmpty)
      return contentErrorMessage;

    return null;
  }

  String? nameValidator(String? val) {
    final String name = val as String;

    if (name.length <= 5 || name.length >= 20 || name.isEmpty)
      return nameErrorMessage;

    return null;
  }
}
