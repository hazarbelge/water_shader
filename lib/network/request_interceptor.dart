import 'package:water_shader/core/utils/index.dart';

class RequestInterceptor {
  static Map<String, String> get getHeaders {
    final Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "Accept-Type": "application/json",
      "Time-Zone": DateTime.now().timeZoneName,
      "Time-Zone-Offset": DateTime.now().timeZoneOffset.toString(),
      if (TranslationUtil.getLanguageCode() != null && TranslationUtil.getCountryCode() != null) "Accept-Language": "${TranslationUtil.getLanguageCode()}-${TranslationUtil.getCountryCode()}",
    };
    return headers;
  }

  static Map<String, dynamic> get getQueries {
    final Map<String, dynamic> queries = <String, dynamic>{
      if (TranslationUtil.getLanguageCode() != null && TranslationUtil.getCountryCode() != null) "language": "${TranslationUtil.getLanguageCode()}-${TranslationUtil.getCountryCode()}",
    };
    return queries;
  }
}
