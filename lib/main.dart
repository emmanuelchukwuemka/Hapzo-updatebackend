import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/config/page_route/route.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/repository/auth_repo/auth_repo.dart';

import 'common/theme/dark_theme.dart';
import 'common/theme/light_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(AuthRepo()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: MediaQuery.sizeOf(context),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
            routerConfig: AppRoute.router,
            debugShowCheckedModeBanner: false,
            title: 'Hapztext',
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: ThemeMode.system,
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!);
            }),
      ),
    );
  }
}
