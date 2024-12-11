import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String username;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
    );
  }
}

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  late Future<List<UserProfile>> _userProfiles;

  Future<List<UserProfile>> _fetchUserProfiles() async {
    final uri = Uri.parse('https://random-data-api.com/api/v2/users?size=20');
    
    try {
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => UserProfile.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load user profiles');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _userProfiles = _fetchUserProfiles();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: FutureBuilder<List<UserProfile>>(
        future: _userProfiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: theme.colorScheme.error,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading data:\n${snapshot.error}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary,
                      child: Text(
                        '${user.firstName[0]}${user.lastName[0]}',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: theme.textTheme.titleMedium,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          style: theme.textTheme.bodyLarge,
                        ),
                        Text(
                          '@${user.username}',
                          style: theme.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'No data available',
                style: theme.textTheme.bodyLarge,
              ),
            );
          }
        },
      ),
    );
  }
}
