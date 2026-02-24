// ignore_for_file: use_build_context_synchronously

import 'package:haptext_api/bloc/auth/cubit/auth_cubit.dart';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/utils/session_manager.dart';
import 'package:provider/provider.dart';
import 'package:haptext_api/services/chat_ui/auth_provider.dart';

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
      final storedUser = await SessionManager.getUser();
      if (storedUser != null) {
        context.read<AuthCubit>().fetchLocalUser();
        final token = await SessionManager().getToken();

        // Sync token to chat AuthProvider
        if (token != null && token.isNotEmpty) {
          final authProvider = context.read<AuthProvider>();
          authProvider.setTokenFromSession(token, storedUser.id?.toString());
        }

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
