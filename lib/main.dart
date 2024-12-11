import 'package:flutter/material.dart';
import 'package:flutter_app2/screens/home_screen.dart';
import 'package:flutter_app2/screens/analytics_screen.dart';
import 'package:flutter_app2/screens/feedback_screen.dart';


void main() {
  runApp(const AppEntryPoint());
}

class NavigatorConfig {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
}

class AppThemeConfig {
  static ColorScheme lightTheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF1A5F7A),
      onPrimary: Color(0xFFE1F4FF),
      secondary: Color(0xFF9C27B0),
      onSecondary: Color(0xFF2A0934),
      error: Color(0xFFD32F2F),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFADE2FF),
      onSurface: Color(0xFF001F2A),
    );
  }
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App 2',
      navigatorKey: NavigatorConfig.navKey,
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A5F7A),
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A5F7A),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A5F7A),
          ),
        ),
        colorScheme: AppThemeConfig.lightTheme(),
        useMaterial3: true,
      ),
      home: const MainAppScaffold(),
    );
  }
}

class MainAppScaffold extends StatefulWidget {
  const MainAppScaffold({super.key});

  @override
  State<MainAppScaffold> createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AnalyticsScreen(),
    const FeedbackScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.onPrimary,
        elevation: 2,
        shadowColor: appColors.primary.withOpacity(0.3),
        title: Text(
          'Flutter App 2',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: _pages[_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: appColors.onPrimary,
        elevation: 3,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) => setState(() => _currentPageIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics_rounded),
            label: 'Analytics',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            selectedIcon: Icon(Icons.chat_bubble_rounded),
            label: 'Feedback',
          ),
        ],
      ),
    );
  }
}
