import 'package:flutter/material.dart';
// import 'dart:math' as math;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('images/Lion.avif'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary.withOpacity(0.7),
                    BlendMode.overlay,
                  ),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'The Lion of Judah',
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          shadows: [
                            Shadow(
                              offset: const Offset(2, 2),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                  
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
