// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Email`
  String get kEmail {
    return Intl.message(
      'Email',
      name: 'kEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get kPassword {
    return Intl.message(
      'Password',
      name: 'kPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid`
  String get kInvalidEmail {
    return Intl.message(
      'Email is invalid',
      name: 'kInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is invalid`
  String get kInalidPassword {
    return Intl.message(
      'Password is invalid',
      name: 'kInalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get kLogin {
    return Intl.message(
      'LOGIN',
      name: 'kLogin',
      desc: '',
      args: [],
    );
  }

  /// `The email or password don't match.`
  String get kWrongInputNotification {
    return Intl.message(
      'The email or password don\'t match.',
      name: 'kWrongInputNotification',
      desc: '',
      args: [],
    );
  }

  /// `List of properties`
  String get kListOfProperties {
    return Intl.message(
      'List of properties',
      name: 'kListOfProperties',
      desc: '',
      args: [],
    );
  }

  /// `No properties found`
  String get kNoPropertiesFound {
    return Intl.message(
      'No properties found',
      name: 'kNoPropertiesFound',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get kEvents {
    return Intl.message(
      'Events',
      name: 'kEvents',
      desc: '',
      args: [],
    );
  }

  /// `Discrepancies`
  String get kDiscrepancies {
    return Intl.message(
      'Discrepancies',
      name: 'kDiscrepancies',
      desc: '',
      args: [],
    );
  }

  /// `Registered`
  String get kRegistered {
    return Intl.message(
      'Registered',
      name: 'kRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get kDeadline {
    return Intl.message(
      'Deadline',
      name: 'kDeadline',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get kLogout {
    return Intl.message(
      'Log out',
      name: 'kLogout',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get kLanguage {
    return Intl.message(
      'Language',
      name: 'kLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get kLangEnglish {
    return Intl.message(
      'English',
      name: 'kLangEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Norsk bokm??l`
  String get kLangNorwegian {
    return Intl.message(
      'Norsk bokm??l',
      name: 'kLangNorwegian',
      desc: '',
      args: [],
    );
  }

  /// `??????????????`
  String get kLangRussian {
    return Intl.message(
      '??????????????',
      name: 'kLangRussian',
      desc: '',
      args: [],
    );
  }

  /// `Loading error`
  String get kLoadingError {
    return Intl.message(
      'Loading error',
      name: 'kLoadingError',
      desc: '',
      args: [],
    );
  }

  /// `Await on improvement`
  String get kDiscStatusAwaitOnImprove {
    return Intl.message(
      'Await on improvement',
      name: 'kDiscStatusAwaitOnImprove',
      desc: '',
      args: [],
    );
  }

  /// `Await on accept`
  String get kDiscStatusAwaitOnAccept {
    return Intl.message(
      'Await on accept',
      name: 'kDiscStatusAwaitOnAccept',
      desc: '',
      args: [],
    );
  }

  /// `Await on solution`
  String get kDiscStatusAwaitOnSolution {
    return Intl.message(
      'Await on solution',
      name: 'kDiscStatusAwaitOnSolution',
      desc: '',
      args: [],
    );
  }

  /// `Discrepancy created`
  String get kDiscStatusDiscCreated {
    return Intl.message(
      'Discrepancy created',
      name: 'kDiscStatusDiscCreated',
      desc: '',
      args: [],
    );
  }

  /// `Undefined status`
  String get kDiscStatusUndefined {
    return Intl.message(
      'Undefined status',
      name: 'kDiscStatusUndefined',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get kYes {
    return Intl.message(
      'Yes',
      name: 'kYes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get kNo {
    return Intl.message(
      'No',
      name: 'kNo',
      desc: '',
      args: [],
    );
  }

  /// `Don't know`
  String get kDontKnow {
    return Intl.message(
      'Don\'t know',
      name: 'kDontKnow',
      desc: '',
      args: [],
    );
  }

  /// `Take picture or use gallery?`
  String get kPictureDialogTitle {
    return Intl.message(
      'Take picture or use gallery?',
      name: 'kPictureDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Take picture`
  String get kTakePicture {
    return Intl.message(
      'Take picture',
      name: 'kTakePicture',
      desc: '',
      args: [],
    );
  }

  /// `Upload from gallery`
  String get kUseGallery {
    return Intl.message(
      'Upload from gallery',
      name: 'kUseGallery',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get kSave {
    return Intl.message(
      'Save',
      name: 'kSave',
      desc: '',
      args: [],
    );
  }

  /// `Floor plans`
  String get kFloorPlans {
    return Intl.message(
      'Floor plans',
      name: 'kFloorPlans',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'nb'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}