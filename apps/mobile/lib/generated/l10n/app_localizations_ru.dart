// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get signUpPage => 'Страница Регистрации';

  @override
  String get firstName => 'Имя';

  @override
  String get firstNameHint => 'Введите Имя';

  @override
  String get lastName => 'Фамилия';

  @override
  String get lastNameHint => 'Введите Фамилию';

  @override
  String get email => 'Почта';

  @override
  String get emailHint => 'Введите Адрес Эл. Почты';

  @override
  String get password => 'Пароль';

  @override
  String get passwordHint => 'Введите Пароль';

  @override
  String fieldRequired(String fieldName) {
    return 'Требуется ввести поле $fieldName';
  }

  @override
  String fieldTooShort(String fieldName) {
    return 'Поле $fieldName должно содержать как минимум 2 символа';
  }

  @override
  String nameLettersOnly(String fieldName) {
    return 'Поле $fieldName должно содержать только буквы';
  }
}
