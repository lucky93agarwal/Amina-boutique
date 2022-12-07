import 'package:amin/common/locator.dart';
import 'package:amin/screen/splash.dart';
import 'package:amin/utils/theme.dart';
import 'package:amin/utils/theme_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

/*  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );*/

  setupDependencies();
  await Firebase.initializeApp();

/*  runApp(const MyApp());*/
  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('ar', 'AR'),
      Locale('es', 'ES')
    ],
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
    useOnlyLangCode: true,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeBloc>(
        create: (_) => ThemeBloc(),
        child: Consumer<ThemeBloc>(builder: (_, mode, child) {
          return /*MultiProvider(
              providers: [

              ],
              child:*/
              MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Amina Boutique',
            theme: ThemeModel().lightTheme,
            darkTheme: ThemeModel().darkTheme,
            themeMode: mode.darkTheme == false
                ? ThemeMode.dark
                : ThemeMode.light /*ThemeMode.system*/,
            home: SplashScreen(),
          ) /*)*/;
        }));
  }
}
