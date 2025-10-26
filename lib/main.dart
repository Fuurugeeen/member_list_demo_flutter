import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'services/auth_service.dart';
import 'screens/auth_screen.dart';
import 'screens/member_list_screen.dart';
import 'screens/member_edit_screen.dart';
import 'models/member.dart';
import 'theme/business_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          final mode = AppMode.fromString(state.uri.queryParameters['mode']);
          return AppWrapper(mode: mode);
        },
      ),
      GoRoute(
        path: '/edit',
        builder: (context, state) {
          final member = state.extra as Member?;
          return MemberEditScreen(member: member);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Member List Demo',
      theme: BusinessTheme.lightTheme,
      routerConfig: _router,
    );
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key, required this.mode});

  final AppMode mode;

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  final _authService = AuthService();
  bool _isAuthenticated = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final isAuth = await _authService.isAuthenticated(widget.mode);
    setState(() {
      _isAuthenticated = isAuth;
      _isLoading = false;
    });
  }

  void _onAuthenticated() {
    setState(() {
      _isAuthenticated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (!_isAuthenticated) {
      return AuthScreen(
        mode: widget.mode,
        onAuthenticated: _onAuthenticated,
      );
    }

    return MemberListScreen(mode: widget.mode);
  }
}