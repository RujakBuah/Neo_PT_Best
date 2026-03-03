import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pt_best/core/common/cubit/app_user_cubit.dart';
import 'package:pt_best/core/common/widgets/main_shell.dart';
import 'package:pt_best/features/auth/presentation/pages/login_page.dart';
import 'package:pt_best/features/jobs/presentation/pages/add_job_page.dart';
import 'package:pt_best/features/jobs/presentation/pages/job_listing_page.dart';
import 'package:pt_best/features/jobs/presentation/pages/order_page.dart';

final appRouter = GoRouter(
  redirect: (context, state) {
    final isLoggedIn = context.read<AppUserCubit>().state is AppUserLoggedIn;
    final isAuthRoute = state.uri.toString() == '/login';

    if (!isLoggedIn && !isAuthRoute) return '/login';
    if (isLoggedIn && isAuthRoute) return '/';
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/', builder: (_, _) => const JobListingPage()),
        GoRoute(path: '/orders', builder: (_, _) => const OrderPage()),
        GoRoute(path: '/add-job', builder: (_, _) => const AddJobPage()),
      ],
    ),
  ],
);
