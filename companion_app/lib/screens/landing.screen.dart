import 'package:elc_companion_app/providers/auth.provider.dart';
import 'package:elc_companion_app/screens/character_list.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  bool isProgressing = false;
  bool isLoggedIn = false;
  String errorMessage = '';

  @override
  void initState() {
    loginAction();
    super.initState();
  }

  setSuccessAuthState() {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
    });

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const CharacterListScreen()));
  }

  setLoadingState() {
    setState(() {
      isProgressing = true;
      errorMessage = '';
    });
  }

  Future<void> loginAction() async {
    try {
      setLoadingState();
      final bool isAuth = await ref.read(authProvider.notifier).loginUser();
      if (isAuth) {
        setSuccessAuthState();
      } else {
        setState(() {
          isProgressing = false;
        });
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          e.toString(),
        )));
      }

      setState(() {
        isProgressing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                opacity: 0.5,
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isProgressing)
                const CircularProgressIndicator()
              else if (!isLoggedIn)
                TextButton(
                  onPressed: loginAction,
                  child: const Text('Login | Register'),
                )
              else
                Text(
                  'Welcome back, Agent.',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
            ],
          ),
        ),
      ),
    );
  }
}
