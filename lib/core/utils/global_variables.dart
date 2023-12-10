import 'package:dio/dio.dart';
import 'package:water_shader/generated/assets.dart';

class GlobalVariables {
  static _App app = _App();
  static _Tools tools = _Tools();
  static _Settings settings = _Settings();
  static _Pages pages = _Pages();
  static _Media media = _Media();
  static _AppleLogin appleLogin = _AppleLogin();
}

class _App {}

class _Tools {
  final Dio dio = Dio();
}

class _Settings {
  late final String androidAppVersion;
  late final String playStoreUrl;
}

class _Pages {
  String? termsTitle;
  String? terms;
  String? privacyPolicyTitle;
  String? privacyPolicy;
  String? cookiePolicyTitle;
  String? cookiePolicy;
  String? faqTitle;
  String? faq;
  String? safetyTipsTitle;
  String? safetyTips;
}

class _Media {
  String get appIconPath => Assets.appIcon;
}

class _AppleLogin {
  String? firstName;
  String? lastName;
}
