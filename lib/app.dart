import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_providers.dart';
import 'package:gaia/shared/core/infrastructure/auth/auth_state_provider.dart';
import 'package:gaia/shared/core/infrastructure/network/config_provider.dart';
import 'package:gaia/shared/core/infrastructure/notifications/notification_routers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:gaia/shared/core/infrastructure/routes/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(appRouterProvider);
    final cfg = ref.watch(appConfigProvider); // injected in main()
    final brand =
        ref.watch(brandPaletteProvider); // built from cfg.colors (or defaults)
            final authAsync = ref.watch(authStateProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only flush when auth is not loading.
      // If user is logged out, flushing will navigate but redirect will send to /login.
      // If user is logged in, it will go to the target screen.
      if (!authAsync.isLoading) {
        NotificationRouters.instance.flushPendingIfAny();
      }
    });

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: cfg.appName, // <- from JSON/config
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              // seed from brand
              seedColor: brand.primary,
            ),
            extensions: <ThemeExtension<dynamic>>[
              brand, // <- makes context.brand.* available
            ],
          ),
          routerConfig: routerConfig,
        );
      },
    );
  }
}
