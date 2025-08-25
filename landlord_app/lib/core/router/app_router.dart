import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../features/kyc/presentation/kyc_gate_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'kyc_gate',
      builder: (context, state) => const KycGateScreen(),
    ),
  ],
);

