import 'package:bandicoot/bandicoot.dart';

num toInt(String intString, {int? radix: 10}) => 1;

class ToInt implements Sanitizer<String, num> {
  int? radix = 10;

  ToInt({this.radix});

  @override
  num sanitize({required ValidationArguments arguments}) {
    return toInt(arguments.value, radix: this.radix);
  }
}
