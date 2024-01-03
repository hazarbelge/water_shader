import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:water_shader/core/utils/index.dart';

class TranslationUtil extends Translations {
  static TranslationUtil instance = TranslationUtil();

  static Locale? locale = getLocale() ?? Get.deviceLocale;
  static const Locale fallbackLocale = Locale("en");

  static List<String> items = <String>[];

  static void setLocale() {
    if (getLocale() == null && Get.deviceLocale == null) {
      debugPrint("LocaleFallback: ${TranslationUtil.fallbackLocale}");
      Get.updateLocale(TranslationUtil.fallbackLocale);
    } else {
      debugPrint("LocaleUpdate: $locale");
      Get.updateLocale(locale!);
    }
    languageSave();
  }

  static void setLocaleByCode(String code) {
    final Locale _locale = Locale(code, Get.deviceLocale?.countryCode);
    Get.updateLocale(_locale);
    languageSaveByCode(code);
  }

  static void languageSave() {
    StorageUtil.write("language_code", locale?.languageCode);
    StorageUtil.write("country_code", locale?.countryCode);
    debugPrint("Locale ${locale?.languageCode}_${locale?.countryCode} is saved.");
  }

  static void languageSaveByCode(String code) {
    StorageUtil.write("language_code", code);
    StorageUtil.write("country_code", Get.deviceLocale?.countryCode);
    debugPrint("Locale ${code}_${Get.deviceLocale?.countryCode} is saved.");
  }

  static String? getLanguageCode() {
    return StorageUtil.read<String>("language_code");
  }

  static String? getCountryCode() {
    return StorageUtil.read<String>("country_code");
  }

  static Locale? getLocale() {
    final String? languageCode = getLanguageCode();
    final String? countryCode = getCountryCode();
    return languageCode != null && countryCode != null ? Locale(languageCode, countryCode) : Get.deviceLocale;
  }

  @override
  Map<String, Map<String, String>> get keys => const <String, Map<String, String>>{
        "tr": <String, String>{
          "shader.tab.title": "Su Simülasyon Gölgendiricisi",
          "view.tab.title": "Manzara",
          "shader.tab.sea.height": "Deniz Yüksekliği",
          "shader.tab.sea.speed": "Deniz Hızı",
          "shader.tab.sea.choppy": "Deniz Dalga Düzeyi",
        },
        "en": <String, String>{
          "shader.tab.title": "Water Simulation Shader",
          "view.tab.title": "View",
          "shader.tab.sea.height": "Sea Height",
          "shader.tab.sea.speed": "Sea Speed",
          "shader.tab.sea.choppy": "Sea Choppy",
        },
        "fr": <String, String>{
          "shader.tab.title": "L'ombrage de la simulation de l'eau",
          "view.tab.title": "Vue",
          "shader.tab.sea.height": "Hauteur de la mer",
          "shader.tab.sea.speed": "Vitesse de la mer",
          "shader.tab.sea.choppy": "Mer agitée",
        },
      };
}
