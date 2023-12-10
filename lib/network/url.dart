class Url {
  static const String _baseUrl = "https://${productionPath}cosmopair.com";
  static const int clientId = 2;
  static const String clientSecret = "b2Ta5aiDvr4oq7MVMNhYkn16Jj3SKDMn8Anf1lEr";

  static const String stagingPath = "dev.";
  static const String productionPath = "";

  static const String appSettings = "$_baseUrl/api/app-settings";
  static const String translations = "$_baseUrl/api/translations";
  static const String pages = "$_baseUrl/api/pages";

  static const String facebookLogin = "$_baseUrl/api/v1/social/login/facebook";
  static const String googleLogin = "$_baseUrl/api/v1/social/login/google";
  static const String appleLogin = "$_baseUrl/api/v1/social/login/apple";

  static const String registerPhone = "$_baseUrl/api/users/register-with-phone";
  static const String verificationPhone = "$_baseUrl/api/users/send-verification-code";
  static const String loginPhone = "$_baseUrl/oauth/token";

  static String cities(String keyword) => "$_baseUrl/api/cities/with/paginate?q=$keyword";

  static const String questions = "$_baseUrl/api/questions";
  static const String userAnswers = "$_baseUrl/api/user-answers";

  static const String me = "$_baseUrl/api/me";
  static const String meFields = "$_baseUrl/api/me/edit/fields";
  static const String meUpdate = "$_baseUrl/api/me/update";
  static const String tags = "$_baseUrl/api/tags";
  static String syncTags(int _userID) => "$_baseUrl/api/users/$_userID/sync-tags";

  static const String users = "$_baseUrl/api/users";
  static String usersById(int id) => "$_baseUrl/api/users/$id";
  static String deleteUserReason(int _userID) => "$_baseUrl/api/users/$_userID/delete-reason";
  static const String filters = "$_baseUrl/api/filters";
  static const String userReport = "$_baseUrl/api/user-report";

  static const String matches = "$_baseUrl/api/matches";
  static String hints(int userId) => "$_baseUrl/api/users/$userId/hints";
  static const String myLikes = "$_baseUrl/api/likes/my";
  static const String opponentLikes = "$_baseUrl/api/likes/opponents";

  static const String cardReverted = "$_baseUrl/api/matches/revert";

  static const String fcmTokenUpdate = "$_baseUrl/api/store-device";
  static String locationUpdate(int userId) => "$_baseUrl/api/users/$userId/update-locations";

  static const String threads = "$_baseUrl/api/chat/start";
  static String message(int threadId) => "$_baseUrl/api/chat/threads/$threadId/messages";
  static String readThread(int threadId) => "$_baseUrl/api/chat/threads/$threadId/read";
  static String emoji(final int threadID, final int messageID) => "$_baseUrl/api/chat/threads/$threadID/messages/$messageID/emoji";
  static const String medias = "$_baseUrl/api/medias";
  static const String blocks = "$_baseUrl/api/blocks";
  static const String reports = "$_baseUrl/api/reports";

  static String subscriptions(int _planID) => "$_baseUrl/api/payments/plans/$_planID/subscriptions/without/provider";
  static const String restoreSubscriptions = "$_baseUrl/api/payments/plans/subscriptions/restore";

  static const String upcomingEvents = "$_baseUrl/api/events/by/upcoming";
  static const String pastEvents = "$_baseUrl/api/events/by/past";
  static const String eventStories = "$_baseUrl/api/stories/by/events";
  static String eventMembers(int _eventID) => "$_baseUrl/api/events/$_eventID/members";
  static String eventById(int _eventID) => "$_baseUrl/api/events/$_eventID";
  static String joinEvent(int _eventID) => "$_baseUrl/api/events/$_eventID/members";
  static String leaveEvent(int _eventID) => "$_baseUrl/api/events/$_eventID/members/leave";
  static const String likeEvent = "$_baseUrl/api/likes";
  static const String opponentLikesEvents = "$_baseUrl/api/likes/opponents/by/events";
}
