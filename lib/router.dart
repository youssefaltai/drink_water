import 'package:go_router/go_router.dart';

import 'features/tracking/screens/home.screen.dart';

final router = GoRouter(
  initialLocation: HomeScreen.route,
  routes: [
    GoRoute(
      path: HomeScreen.route,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
