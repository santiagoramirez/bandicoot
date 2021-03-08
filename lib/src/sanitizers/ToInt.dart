import 'package:bandicoot/bandicoot.dart';
import 'package:validators/sanitizers.dart';

class ToInt implements Sanitizer<String, num> {
  int? radix = 10;

  ToInt({this.radix});

  @override
  num sanitize({required ValidationArguments arguments}) {
    return toInt(arguments.value, radix: this.radix);
  }
}
