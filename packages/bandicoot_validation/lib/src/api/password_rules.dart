class PasswordRules {
  static const SPECIAL_CHARS = '!@#\$%^&*(){}\\[\\]\|\:;\'"<,>\.?\\/';

  int min = 8;
  int max = 20;
  bool requireLowercase = true;
  bool requireUppercase = true;
  bool requireNumbers = true;
  bool requireSpecialCharacters = true;
  String specialCharacters;

  PasswordRules(
      {required this.min,
      required this.max,
      required this.requireLowercase,
      required this.requireUppercase,
      required this.requireNumbers,
      required this.requireSpecialCharacters,
      this.specialCharacters = SPECIAL_CHARS});

  List<String> get _charList {
    List<String> chars = [];

    if (requireLowercase == true) chars.add('a-z');
    if (requireUppercase == true) chars.add('A-Z');
    if (requireNumbers == true) chars.add('\\d');
    if (requireSpecialCharacters == true) chars.add(specialCharacters);

    return chars;
  }

  String get _lookaheads => _charList.map((char) => '(?=.*[$char])').join();
  String get _chars => _charList.map((char) => '$char').join();

  String get regexAsString => '^$_lookaheads[$_chars]{$min,$max}\$';

  RegExp get regex => RegExp(regexAsString);
}
