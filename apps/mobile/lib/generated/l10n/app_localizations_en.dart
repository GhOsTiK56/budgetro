// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signUpPage => 'Sign Up Page';

  @override
  String get loginPage => 'Login Page';

  @override
  String get signUp => 'Sign Up';

  @override
  String get login => 'Login';

  @override
  String get firstName => 'First Name';

  @override
  String get firstNameHint => 'Enter First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get lastNameHint => 'Enter Last Name';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Enter Email Adress';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter Password';

  @override
  String fieldRequired(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String fieldTooShort(String fieldName, int charactersContains) {
    return '$fieldName must contain at least $charactersContains characters';
  }

  @override
  String nameLettersOnly(String fieldName) {
    return '$fieldName must contain only letters';
  }

  @override
  String get emailInvalid => 'Please enter a valid Email adress';
}
