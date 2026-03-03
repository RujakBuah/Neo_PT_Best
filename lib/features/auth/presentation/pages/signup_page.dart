import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pt_best/core/common/widgets/loader.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/core/utils/show_snackbar.dart';
import 'package:pt_best/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pt_best/features/auth/presentation/pages/login_page.dart';
import 'package:pt_best/features/auth/presentation/widgets/auth_chip.dart';
import 'package:pt_best/features/auth/presentation/widgets/auth_field.dart';
import 'package:pt_best/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  // ignore: strict_top_level_inference
  static route() => MaterialPageRoute(builder: (context) => const SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
        } else if (state is AuthSuccess) {
          context.go('/');
        }
      },
      child: Scaffold(
        // Single Scaffold — owns the gradient via body decoration
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppPalette.surfaceDark, AppPalette.primaryDark],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero / branding area ───────────────────────────
                const Spacer(),
                Padding(
                  padding: const EdgeInsetsGeometry.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.app_badge,
                        size: 60,
                        color: AppPalette.primaryLight,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Create your \n',
                          style: Theme.of(context).textTheme.displayLarge,
                          children: [
                            TextSpan(
                              text: 'account.\n',
                              style: Theme.of(context).textTheme.displayLarge!
                                  .copyWith(color: AppPalette.primary),
                            ),
                            TextSpan(
                              text: 'Join thousands of workers today!\n',
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .copyWith(
                                    color: AppPalette.textSecondaryOnDark,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Form sheet ────────────────────────────────────
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Loader();
                        }
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            AuthChip(
                              initialIndex: 0,
                              onTabChanged: (index) {
                                if (index == 1) {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => LoginPage(),
                                      transitionsBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            child,
                                          ) {
                                            const begin = Offset(-1.0, 0.0);
                                            const end = Offset.zero;
                                            const curve = Curves.ease;
                                            final tween = Tween(
                                              begin: begin,
                                              end: end,
                                            );
                                            final curvedAnimation =
                                                CurvedAnimation(
                                                  parent: animation,
                                                  curve: curve,
                                                );
                                            return SlideTransition(
                                              position: tween.animate(
                                                curvedAnimation,
                                              ),
                                              child: child,
                                            );
                                          },
                                    ),
                                  );
                                }
                              },
                            ),
                            Expanded(
                              child: PageView(
                                controller: _pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Builder(
                                    builder: (context) => Form(
                                      key: formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AuthField(
                                              hintText: 'Name',
                                              controller: nameController,
                                              prefixIcon: CupertinoIcons.person,
                                            ),
                                            const SizedBox(height: 20),
                                            AuthField(
                                              hintText: 'Email',
                                              controller: emailController,
                                              prefixIcon: CupertinoIcons.mail,
                                            ),
                                            const SizedBox(height: 20),
                                            AuthField(
                                              hintText: 'Password',
                                              controller: passwordController,
                                              isObscureText: true,
                                              prefixIcon: CupertinoIcons.lock,
                                            ),
                                            const SizedBox(height: 30),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 50.0,
                                                  ),
                                              child: AuthGradientButton(
                                                buttonText:
                                                    'Sign Up →', // use an arrow to indicate progression to next step
                                                onPressed: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    context.read<AuthBloc>().add(
                                                      AuthSignUp(
                                                        email: emailController
                                                            .text
                                                            .trim(),
                                                        password:
                                                            passwordController
                                                                .text
                                                                .trim(),
                                                        name: nameController
                                                            .text
                                                            .trim(),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
