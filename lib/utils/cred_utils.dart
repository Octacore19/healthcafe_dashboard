class CredUtils {
  CredUtils._();

  static bool isValidPassword(String? password) {
    if (password == null) return false;
    final exp =
        RegExp('((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#\$%?=*&]).{4,20})');
    return exp.hasMatch(password);
  }

  static bool isValidEmail(String? email) {
    if (email == null) return false;
    return RegExp(r'\S+@\S+\.\S+').hasMatch(email);
  }
}
