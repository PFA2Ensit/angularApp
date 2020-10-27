import 'package:comptabli_blog/core/i18n/translations.dart';
import 'package:flutter/material.dart';

const kSupportedLocales = ['en'];

/// [TranslationsDelegate] is delegate for [Translations]
class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      kSupportedLocales.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
