import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_best/core/common/widgets/loader.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/core/utils/show_snackbar.dart';
import 'package:pt_best/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pt_best/features/auth/presentation/widgets/auth_field.dart';
import 'package:pt_best/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
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
                        return Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                AuthField(
                                  hintText: 'Name',
                                  controller: nameController,
                                  prefixIcon: CupertinoIcons.person,
                                ),
                                const SizedBox(height: 15),
                                AuthField(
                                  hintText: 'Email',
                                  controller: emailController,
                                  prefixIcon: CupertinoIcons.mail,
                                ),
                                const SizedBox(height: 15),
                                AuthField(
                                  hintText: 'Password',
                                  controller: passwordController,
                                  isObscureText: true,
                                  prefixIcon: CupertinoIcons.lock,
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0,
                                  ),
                                  child: AuthGradientButton(
                                    buttonText:
                                        'Sign Up →', // use an arrow to indicate progression to next step
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(
                                          AuthSignUp(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim(),
                                            name: nameController.text.trim(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
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
