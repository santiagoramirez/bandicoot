class PasswordRules {
  static const DefaultSpecialCharacters = '!@#\$%^&*(){}[]|\:;\'"<,>.?/';

  int min = 8;
  int max = 20;
  bool requireLowercase = true;
  bool requireUppercase = true;
  bool requireNumbers = true;
  bool requireSpecialCharacters = true;
  String specialCharacters = DefaultSpecialCharacters;

  PasswordRules(
      {required this.min,
      required this.max,
      required this.requireLowercase,
      required this.requireUppercase,
      required this.requireNumbers,
      required this.requireSpecialCharacters,
      this.specialCharacters = DefaultSpecialCharacters});

  List<String> get _chars {
    List<String> chars = [];

    if (this.requireLowercase == true) chars.add('a-z');
    if (this.requireUppercase == true) chars.add('A-Z');
    if (this.requireNumbers == true) chars.add('\d');
    if (this.requireSpecialCharacters == true)
      chars.add(this.specialCharacters);

    return chars;
  }

  String get _charsString => this._chars.join();

  String get _lookaheadString =>
      this._chars.map((c) => '(?=.*[$c])').join(', ');

  RegExp get regex => RegExp(
      '/^${this._lookaheadString}[${this._charsString}]{${this.min},${this.max}}\$/');
}
