import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streetbite/core/constants/app_constants.dart';
import 'package:streetbite/core/services/biometric_service.dart';
import 'package:streetbite/core/services/device_info_service.dart';
import 'package:streetbite/core/services/image_picker_service.dart';
import 'package:streetbite/data/datasources/firestore_service.dart';
import 'package:streetbite/data/datasources/local_meal_data_source.dart';
import 'package:streetbite/data/datasources/meal_data_source_factory.dart';
import 'package:streetbite/data/datasources/remote_meal_data_source.dart';
import 'package:streetbite/data/repositories/auth_repository_impl.dart';
import 'package:streetbite/data/repositories/favourites_repository_impl.dart';
import 'package:streetbite/data/repositories/meal_repository_impl.dart';
import 'package:streetbite/data/repositories/order_repository_impl.dart';
import 'package:streetbite/data/repositories/profile_repository_impl.dart';
import 'package:streetbite/data/repositories/vendor_repository_impl.dart';
import 'package:streetbite/domain/payment/card_payment.dart';
import 'package:streetbite/domain/payment/cash_payment.dart';
import 'package:streetbite/domain/payment/payment_method.dart';
import 'package:streetbite/domain/payment/payment_processor.dart';
import 'package:streetbite/domain/repositories/auth_repository.dart';
import 'package:streetbite/domain/repositories/favourites_repository.dart';
import 'package:streetbite/domain/repositories/meal_repository.dart';
import 'package:streetbite/domain/repositories/order_repository.dart';
import 'package:streetbite/domain/repositories/profile_repository.dart';
import 'package:streetbite/domain/repositories/vendor_repository.dart';
import 'package:streetbite/domain/usecases/get_meals_use_case.dart';
import 'package:streetbite/domain/usecases/get_vendors_use_case.dart';
import 'package:streetbite/domain/usecases/observe_auth_state_use_case.dart';
import 'package:streetbite/domain/usecases/place_order_use_case.dart';
import 'package:streetbite/domain/usecases/sign_in_use_case.dart';
import 'package:streetbite/domain/usecases/sign_out_use_case.dart';
import 'package:streetbite/domain/usecases/sign_up_use_case.dart';
import 'package:streetbite/domain/usecases/toggle_favourite_use_case.dart';
import 'package:streetbite/domain/usecases/update_profile_photo_use_case.dart';
import 'package:streetbite/domain/usecases/watch_favourites_use_case.dart';
import 'package:streetbite/domain/usecases/watch_orders_use_case.dart';
import 'package:streetbite/domain/usecases/watch_profile_photo_use_case.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/blocs/favourites/favourites_cubit.dart';
import 'package:streetbite/presentation/blocs/locale/locale_cubit.dart';
import 'package:streetbite/presentation/blocs/meals/meals_cubit.dart';
import 'package:streetbite/presentation/blocs/profile/profile_cubit.dart';
import 'package:streetbite/presentation/blocs/theme/theme_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  getIt
    ..registerSingleton<SharedPreferences>(prefs)
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: AppConstants.mealApiBaseUrl,
          connectTimeout: AppConstants.connectTimeout,
          receiveTimeout: AppConstants.receiveTimeout,
        ),
      ),
    )
    ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
    ..registerSingleton<FirestoreService>(FirestoreService())
    ..registerLazySingleton<BiometricService>(
      () => BiometricService(LocalAuthentication()),
    )
    ..registerLazySingleton<DeviceInfoService>(
      () => DeviceInfoService(DeviceInfoPlugin()),
    )
    ..registerLazySingleton<ImagePickerService>(
      () => ImagePickerService(ImagePicker()),
    )
    ..registerLazySingleton<LocalMealDataSource>(
      () => LocalMealDataSource(getIt()),
    )
    ..registerLazySingleton<RemoteMealDataSource>(
      () => RemoteMealDataSource(getIt()),
    )
    ..registerLazySingleton<MealDataSourceFactory>(
      () => MealDataSourceFactory(getIt(), getIt()),
    )
    ..registerLazySingleton<MealRepository>(
      () => MealRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<FavouritesRepository>(
      () => FavouritesRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(getIt()))
    ..registerLazySingleton<VendorRepository>(
      () => const VendorRepositoryImpl(),
    )
    ..registerLazySingleton<Map<PaymentMethod, PaymentProcessor>>(
      () => {
        PaymentMethod.cash: const CashPayment(),
        PaymentMethod.card: const CardPayment(),
      },
    )
    ..registerLazySingleton<SignInUseCase>(() => SignInUseCase(getIt()))
    ..registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(getIt()))
    ..registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(getIt()))
    ..registerLazySingleton<ObserveAuthStateUseCase>(
      () => ObserveAuthStateUseCase(getIt()),
    )
    ..registerLazySingleton<GetMealsUseCase>(() => GetMealsUseCase(getIt()))
    ..registerLazySingleton<WatchFavouritesUseCase>(
      () => WatchFavouritesUseCase(getIt()),
    )
    ..registerLazySingleton<ToggleFavouriteUseCase>(
      () => ToggleFavouriteUseCase(getIt()),
    )
    ..registerLazySingleton<PlaceOrderUseCase>(
      () => PlaceOrderUseCase(getIt(), getIt()),
    )
    ..registerLazySingleton<WatchOrdersUseCase>(
      () => WatchOrdersUseCase(getIt()),
    )
    ..registerLazySingleton<WatchProfilePhotoUseCase>(
      () => WatchProfilePhotoUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateProfilePhotoUseCase>(
      () => UpdateProfilePhotoUseCase(getIt()),
    )
    ..registerLazySingleton<GetVendorsUseCase>(() => GetVendorsUseCase(getIt()))
    ..registerFactory<AuthCubit>(
      () => AuthCubit(getIt(), getIt(), getIt(), getIt()),
    )
    ..registerFactory<MealsCubit>(() => MealsCubit(getIt()))
    ..registerFactory<CartBloc>(() => CartBloc(getIt()))
    ..registerFactory<ThemeBloc>(() => ThemeBloc(getIt()))
    ..registerFactory<LocaleCubit>(() => LocaleCubit(getIt()))
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(getIt(), getIt(), getIt(), getIt()),
    )
    ..registerFactoryParam<FavouritesCubit, AuthCubit, void>(
      (authCubit, _) => FavouritesCubit(getIt(), getIt(), authCubit),
    );
}
