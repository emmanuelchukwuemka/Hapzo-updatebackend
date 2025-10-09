import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/bloc/home/cubit/home_cubit.dart';
import 'package:haptext_api/bloc/people/cubit/people_cubit.dart';
import 'package:haptext_api/bloc/profile/cubit/profile_cubit.dart';
import 'package:haptext_api/config/page_route/route.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/repository/auth_repo/auth_repo.dart';
import 'package:haptext_api/repository/home_repo/home_repo.dart';
import 'package:haptext_api/repository/people_repo/people_repo.dart';
import 'package:haptext_api/repository/profile_repo/profile_repo.dart';
import 'common/theme/dark_theme.dart';
import 'common/theme/light_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(AuthRepo())),
          BlocProvider(create: (context) => HomeCubit(HomeRepo())),
          BlocProvider(create: (context) => ProfileCubit(ProfileRepo())),
          BlocProvider(create: (context) => PeopleCubit(PeopleRepo())),
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
                themeMode: ThemeMode.dark,
                builder: (context, child) {
                  return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: const TextScaler.linear(1.0)),
                      child: child!);
                })));
  }
}
