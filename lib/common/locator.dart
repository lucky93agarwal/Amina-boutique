
import 'package:get_it/get_it.dart';
import 'package:amin/helper/shared_preference_helper.dart';

final getIt = GetIt.instance;

void setupDependencies() {

  getIt.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper());
}