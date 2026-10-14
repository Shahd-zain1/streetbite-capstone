// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'StreetBite';

  @override
  String get tagline => 'Street food, found fast';

  @override
  String get loginTitle => 'Welcome back';

  @override
  String get loginSubtitle => 'Log in to find your next bite';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get loginButton => 'Log in';

  @override
  String get signUpButton => 'Sign up';

  @override
  String get noAccountPrompt => 'New here? Create an account';

  @override
  String get signUpTitle => 'Create your account';

  @override
  String get signUpSubtitle => 'Join StreetBite and start exploring';

  @override
  String get nameRequired => 'Please enter your full name';

  @override
  String get nameCapital => 'The first letter of your name must be capital';

  @override
  String get emailRequired => 'Please enter your email';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get passwordRequired => 'Please enter a password';

  @override
  String get passwordShort => 'Password must be at least 6 characters';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get errNetwork =>
      'No internet connection. Check your network and try again.';

  @override
  String get errTimeout => 'The request took too long. Please try again.';

  @override
  String get errServer =>
      'The meal service is having trouble right now. Try again soon.';

  @override
  String get errInvalidCredentials => 'Wrong email or password.';

  @override
  String get errEmailInUse => 'This email is already registered.';

  @override
  String get errWeakPassword =>
      'That password is too weak. Try a stronger one.';

  @override
  String get errTooManyRequests =>
      'Too many attempts. Please wait a bit and try again.';

  @override
  String get errPermissionDenied => 'You do not have permission to do that.';

  @override
  String get errPaymentFailed => 'Payment failed. Please try again.';

  @override
  String get errUnknown => 'Something went wrong. Please try again.';

  @override
  String get retry => 'Try again';

  @override
  String homeGreeting(String name) {
    return 'Hi, $name';
  }

  @override
  String get homeSubtitle => 'What are you craving today?';

  @override
  String get hotOffersTitle => 'Hot Offers';

  @override
  String get allMealsTitle => 'Explore meals';

  @override
  String get addToCart => 'Add to cart';

  @override
  String addedToCart(String name) {
    return '$name added to cart';
  }

  @override
  String get favouriteAdd => 'Save to favourites';

  @override
  String get favouriteRemove => 'Remove from favourites';

  @override
  String originLabel(String area) {
    return 'Origin: $area';
  }

  @override
  String get instructionsTitle => 'Instructions';

  @override
  String priceFormat(num amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    return '$amountString EGP';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navVendors => 'Vendors';

  @override
  String get navCart => 'Cart';

  @override
  String get navProfile => 'Profile';

  @override
  String get toggleTheme => 'Switch theme';

  @override
  String get switchLanguage => 'العربية';

  @override
  String get cartTitle => 'Your cart';

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String get cartBecameEmpty => 'Cart is now empty';

  @override
  String get removeFromCart => 'Remove from cart';

  @override
  String quantityLabel(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Qty: $countString';
  }

  @override
  String get totalLabel => 'Total';

  @override
  String get paymentMethodTitle => 'Payment method';

  @override
  String get payCash => 'Cash';

  @override
  String get payCard => 'Card';

  @override
  String get placeOrder => 'Place order';

  @override
  String get orderPlaced => 'Order placed successfully';

  @override
  String get nearbyVendors => 'Nearby Vendors';

  @override
  String vendorSnippet(String cuisine, num rating) {
    final intl.NumberFormat ratingNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String ratingString = ratingNumberFormat.format(rating);

    return '$cuisine · Rating $ratingString';
  }

  @override
  String get profileTitle => 'Your profile';

  @override
  String get changePhoto => 'Change photo';

  @override
  String get deviceTitle => 'Device details';

  @override
  String androidVersion(String version, String sdk) {
    return 'Android $version (SDK $sdk)';
  }

  @override
  String get favouritesTitle => 'Favourites';

  @override
  String get noFavourites =>
      'No favourites yet. Tap the heart on a meal to save it.';

  @override
  String get ordersTitle => 'Order history';

  @override
  String get noOrders => 'You have not placed any orders yet.';

  @override
  String orderItemsLabel(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Items: $countString';
  }

  @override
  String get signOut => 'Sign out';

  @override
  String get biometricReason => 'Verify your fingerprint to open your profile';

  @override
  String get biometricUnavailable =>
      'Fingerprint authentication is not available on this device.';

  @override
  String get biometricFailed =>
      'Fingerprint verification failed. Please try again.';
}
