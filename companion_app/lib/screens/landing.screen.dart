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
  final usernameController = TextEditingController();

  @override
  void initState() {
    loginAction();
    super.initState();
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
      final LoginStatus status =
          await ref.read(authProvider.notifier).loginUser();

      if (context.mounted) {
        if (status == LoginStatus.loggedIn) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const CharacterListScreen()));
        } else if (status == LoginStatus.newUser) {
          setState(() {
            isLoggedIn = true;
          });
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }

    setState(() {
      isProgressing = false;
    });
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
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.primary,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Please enter a callsign, Agent.'),
                        TextField(
                          decoration:
                              const InputDecoration(label: Text('Username')),
                          controller: usernameController,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            setLoadingState();

                            final wasRegistered = await ref
                                .read(authProvider.notifier)
                                .registerUser(usernameController.text);

                            setState(() {
                              isProgressing = false;
                            });

                            if (wasRegistered && context.mounted) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const CharacterListScreen()));
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
