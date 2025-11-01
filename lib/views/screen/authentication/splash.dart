// ignore_for_file: use_build_context_synchronously

import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/utils/session_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));
      if (await SessionManager.getUser() != null) {
        context.read<AuthCubit>().fetchLocalUser();
        await SessionManager().getToken();
        context.go(RouteName.bottomNav.path);
      } else {
        context.go(RouteName.login.path);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/hapz_logo.png",
            height: size.height * 0.1, width: size.height * 0.1),
      ),
    );
  }
}
