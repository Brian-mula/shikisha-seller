import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shikishaseller/providers/user_provider.dart';
import 'package:shikishaseller/views/homepage.dart';
import 'package:shikishaseller/views/login.dart';
import 'package:shikishaseller/widgets/info_text.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
        data: (data) {
          if (data != null) return const HomeScreen();
          return const LoginPage();
        },
        error: (e, trace) => Center(
              child: InfoText(text: e.toString()),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
