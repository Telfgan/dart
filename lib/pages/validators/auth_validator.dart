class AuthValidators {
  static const String emailErrMsg =
      "Invalid Email Address, Please provide a valid email.";
  static const String passwordErrMsg =
      "Password must have at least 6 characters.";
  static const String confirmPasswordErrMsg = "Two passwords don't match.";

  String? emailValidator(String? val) {
    final String email = val as String;
    if (email.length <= 3) return emailErrMsg;

    final hasAtSymbol = email.contains('@');
    final indexOfAt = email.indexOf('@');

    final numbersOfAt = "@".allMatches(email).length;
    if (!hasAtSymbol) return emailErrMsg;

    if (numbersOfAt != 1) return emailErrMsg;

    if (indexOfAt == 0 || indexOfAt == email.length - 1) return emailErrMsg;

    return null;
  }

  String? passwordVlidator(String? val) {
    final String password = val as String;

    if (password.isEmpty || password.length <= 5) return passwordErrMsg;

    return null;
  }

  String? confirmPasswordValidator(String? val, firstPasswordInpTxt) {
    final String firstPassword = firstPasswordInpTxt;
    final String secondPassword = val as String;

    if (firstPassword.isEmpty ||
        secondPassword.isEmpty ||
        firstPassword.length != secondPassword.length) {
      return confirmPasswordErrMsg;
    }

    if (firstPassword != secondPassword) return confirmPasswordErrMsg;

    return null;
  }
}
