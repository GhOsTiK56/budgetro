import 'package:budgetro/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:budgetro/core/routing/router.dart';
import 'package:budgetro/core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Budgetro",
      debugShowCheckedModeBanner: false,
      
      // Localization
      // locale: const Locale('ru', 'RU'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU')
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Navigation
     routerConfig: appRouter, 
    );
  }
}