
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menejemen_waktu/configs_public/firebase_options.dart';
import 'package:menejemen_waktu/routes.dart';
import 'package:menejemen_waktu/src/core/controllers/user_controller.dart';
import 'package:menejemen_waktu/wrapper.dart';

import 'src/core/controllers/nav_select_controller.dart';
import 'src/core/controllers/task_controller.dart';
import 'src/core/controllers/theme_controller.dart';
import 'src/core/services/notification/config_notify_helper.dart';
import 'src/core/services/notification/notify_helper.dart';
import 'src/core/services/size_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AwesomeNotifications().setListeners(
    onNotificationDisplayedMethod:
        NotificationHelper.onNotificationDisplayedMethod,
    onActionReceivedMethod: NotificationHelper.onActionReceivedMethod,
    onDismissActionReceivedMethod:
        NotificationHelper.onDismissActionReceivedMethod,
    onNotificationCreatedMethod: NotificationHelper.onNotificationCreatedMethod,
  );
  await NotificationHelper.configureLocalTimeZone();

  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationHelper().initialize(
    null,
    channels,
    channelGroups: groups,
    debug: true,
  );

  Get.put(ThemeController());
  Get.put(NavSelectController());
  Get.put(UserController());
  Get.put(TaskController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);

    final themeProvider = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        title: 'App Time Management',
        initialRoute: initialRoute,
        getPages: getPages,
        theme: themeProvider.lightMode,
        darkTheme: themeProvider.darkMode,
        themeMode: themeProvider.themeMode(),
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        locale: const Locale('id', 'ID'),
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text('Page not found'),
              ),
            ),
          );
        },
        home: const Wrapper(),
      );
    });
  }
}
