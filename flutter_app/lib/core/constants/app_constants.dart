class AppConstants {
  AppConstants._();

  static const mealApiBaseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  static const mealSearchPath = 'search.php';
  static const mealLetters = ['b', 'c', 'p'];
  static const connectTimeout = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 20);

  static const bannerCount = 5;
  static const hotOffersCount = 5;
  static const minPasswordLength = 6;

  static const cacheLifetime = Duration(hours: 6);
  static const mealsCacheKey = 'cached_meals';
  static const mealsCachedAtKey = 'cached_meals_at';
  static const darkModeKey = 'dark_mode';
  static const localeKey = 'locale_code';

  static const usersCollection = 'users';
  static const ordersCollection = 'orders';

  static const englishCode = 'en';
  static const arabicCode = 'ar';

  static const photoMaxSize = 512.0;
  static const photoQuality = 70;
}
