import 'package:budgetro/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class ValidatorUtility {
  ValidatorUtility._();

  static String? validateName(
    String? value,
    String fieldName,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return context.l10n.fieldRequired(fieldName);
    }
    if (!RegExp(r'^[a-zA-Zа-яА-Я\s]+$').hasMatch(value)) {
      return context.l10n.nameLettersOnly(fieldName);
    }
    if (value.length < 2) {
      return context.l10n.fieldTooShort(fieldName, 2);
    }
    return null;
  }

  static String? validateEmail(
    String? value,
    String fieldName,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return context.l10n.fieldRequired(fieldName);
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return context.l10n.emailInvalid;
    }
    return null;
  }

  static String? validatePassword(
    String? value,
    String fieldName,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return context.l10n.fieldRequired(fieldName);
    }
    if (value.length < 8) {
      return context.l10n.fieldTooShort(fieldName, 8);
    }
    return null;
  }
}
