import 'package:bandicoot/bandicoot.dart';

abstract class Sanitizer<InputType, OutputType> {
  OutputType sanitize({required ValidationArguments<InputType> arguments});
}
