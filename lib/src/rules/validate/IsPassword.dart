import 'package:bandicoot/bandicoot.dart';

import 'package:bandicoot/src/helpers/PasswordRules.dart';

bool isPassword(String value, PasswordRules rules) =>
    rules.regex.hasMatch(value);

ValidationRule<String> IsPassword(PasswordRules rules, {String? message}) =>
    ValidationRule(
        message: message,
        constraints: [rules],
        validate: (value, arguments) =>
            Future(() => isPassword(value, arguments.constraints[0])),
        defaultMessage: (arguments) {
          PasswordRules rules = arguments.constraints[0];
          List<String> requirements = [];

          if (rules.requireLowercase) requirements.add('one lowercase letter');
          if (rules.requireUppercase) requirements.add('one uppercase letter');
          if (rules.requireNumbers) requirements.add('one number');

          if (rules.requireSpecialCharacters)
            requirements
                .add('one special character (${rules.specialCharacters})');

          String lengthString =
              'be  ${rules.min}-${rules.max} characters long.';

          String requirementsString = requirements.length > 0
              ? 'must have a least ${requirements.join(', ')} and ${lengthString}.'
              : 'must ${lengthString}';

          return '"${arguments.property}" must match the following criteria: ${requirementsString}';
        });
