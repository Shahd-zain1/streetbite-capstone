// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'ستريت بايت';

  @override
  String get tagline => 'أكل الشارع، أسرع وأسهل';

  @override
  String get loginTitle => 'أهلاً بعودتك';

  @override
  String get loginSubtitle => 'سجّل دخولك واكتشف وجبتك القادمة';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get signUpButton => 'إنشاء حساب';

  @override
  String get noAccountPrompt => 'مستخدم جديد؟ أنشئ حساباً';

  @override
  String get signUpTitle => 'أنشئ حسابك';

  @override
  String get signUpSubtitle => 'انضم إلى ستريت بايت وابدأ الاستكشاف';

  @override
  String get nameRequired => 'من فضلك أدخل اسمك الكامل';

  @override
  String get nameCapital => 'يجب أن يبدأ الاسم بحرف كبير';

  @override
  String get emailRequired => 'من فضلك أدخل بريدك الإلكتروني';

  @override
  String get emailInvalid => 'أدخل بريداً إلكترونياً صالحاً';

  @override
  String get passwordRequired => 'من فضلك أدخل كلمة المرور';

  @override
  String get passwordShort => 'يجب ألا تقل كلمة المرور عن 6 أحرف';

  @override
  String get passwordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get errNetwork =>
      'لا يوجد اتصال بالإنترنت. تحقق من الشبكة وحاول مرة أخرى.';

  @override
  String get errTimeout => 'استغرق الطلب وقتاً طويلاً. حاول مرة أخرى.';

  @override
  String get errServer => 'خدمة الوجبات تواجه مشكلة حالياً. حاول لاحقاً.';

  @override
  String get errInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get errEmailInUse => 'هذا البريد الإلكتروني مسجّل بالفعل.';

  @override
  String get errWeakPassword => 'كلمة المرور ضعيفة. جرّب كلمة أقوى.';

  @override
  String get errTooManyRequests =>
      'محاولات كثيرة. انتظر قليلاً ثم حاول مرة أخرى.';

  @override
  String get errPermissionDenied => 'ليس لديك صلاحية لتنفيذ هذا الإجراء.';

  @override
  String get errPaymentFailed => 'فشلت عملية الدفع. حاول مرة أخرى.';

  @override
  String get errUnknown => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String homeGreeting(String name) {
    return 'أهلاً، $name';
  }

  @override
  String get homeSubtitle => 'ماذا تشتهي اليوم؟';

  @override
  String get hotOffersTitle => 'عروض ساخنة';

  @override
  String get allMealsTitle => 'استكشف الوجبات';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String addedToCart(String name) {
    return 'تمت إضافة $name إلى السلة';
  }

  @override
  String get favouriteAdd => 'أضف إلى المفضلة';

  @override
  String get favouriteRemove => 'إزالة من المفضلة';

  @override
  String originLabel(String area) {
    return 'المنشأ: $area';
  }

  @override
  String get instructionsTitle => 'طريقة التحضير';

  @override
  String priceFormat(num amount) {
    final intl.NumberFormat amountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String amountString = amountNumberFormat.format(amount);

    return '$amountString ج.م';
  }

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navVendors => 'البائعون';

  @override
  String get navCart => 'السلة';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get toggleTheme => 'تغيير المظهر';

  @override
  String get switchLanguage => 'English';

  @override
  String get cartTitle => 'سلتك';

  @override
  String get cartEmpty => 'سلتك فارغة';

  @override
  String get cartBecameEmpty => 'أصبحت السلة فارغة';

  @override
  String get removeFromCart => 'إزالة من السلة';

  @override
  String quantityLabel(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'الكمية: $countString';
  }

  @override
  String get totalLabel => 'الإجمالي';

  @override
  String get paymentMethodTitle => 'طريقة الدفع';

  @override
  String get payCash => 'نقداً';

  @override
  String get payCard => 'بطاقة';

  @override
  String get placeOrder => 'تأكيد الطلب';

  @override
  String get orderPlaced => 'تم تقديم الطلب بنجاح';

  @override
  String get nearbyVendors => 'البائعون القريبون';

  @override
  String vendorSnippet(String cuisine, num rating) {
    final intl.NumberFormat ratingNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String ratingString = ratingNumberFormat.format(rating);

    return '$cuisine · التقييم $ratingString';
  }

  @override
  String get profileTitle => 'ملفك الشخصي';

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get deviceTitle => 'تفاصيل الجهاز';

  @override
  String androidVersion(String version, String sdk) {
    return 'أندرويد $version (SDK $sdk)';
  }

  @override
  String get favouritesTitle => 'المفضلة';

  @override
  String get noFavourites =>
      'لا توجد مفضلات بعد. اضغط على القلب في أي وجبة لحفظها.';

  @override
  String get ordersTitle => 'سجل الطلبات';

  @override
  String get noOrders => 'لم تقدّم أي طلبات بعد.';

  @override
  String orderItemsLabel(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'العناصر: $countString';
  }

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get biometricReason => 'تحقق من بصمتك لفتح ملفك الشخصي';

  @override
  String get biometricUnavailable =>
      'المصادقة بالبصمة غير متاحة على هذا الجهاز.';

  @override
  String get biometricFailed => 'فشل التحقق من البصمة. حاول مرة أخرى.';
}
