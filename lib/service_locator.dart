import 'package:fruti_express_jahr/providers/auth_provider.dart';
import 'package:fruti_express_jahr/services/SyncService.dart';
import 'package:get_it/get_it.dart';
import 'data/local/database.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AppDatabase>(() => AppDatabase.instance);
  locator.registerLazySingleton<AuthProvider>(() => AuthProvider());

  locator.registerLazySingleton<SyncService>(
    () => SyncService(locator<AppDatabase>(), locator<AuthProvider>()),
  );
}
