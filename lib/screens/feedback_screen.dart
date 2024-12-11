import 'package:flutter/material.dart';

class FeedbackData {
  late String fullName;
  late String emailAddress;
  late String feedbackMessage;
}

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FeedbackData _feedbackData = FeedbackData();

  Widget _buildFormField({
    required String label,
    required String hint,
    required IconData icon,
    required Function(String?) onSaved,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
        
        ),
        keyboardType: keyboardType,
      
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (keyboardType == TextInputType.emailAddress &&
              !value.contains('@')) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //TODO: Submit feedback data to the server
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback submitted successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Share Your Feedback',
                  style: theme.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildFormField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  icon: Icons.person_outline_rounded,
                  keyboardType: TextInputType.name,
                  onSaved: (value) => _feedbackData.fullName = value!,
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  label: 'Email',
                  hint: 'Enter your email address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _feedbackData.emailAddress = value!,
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  label: 'Message',
                  hint: 'Enter your feedback message',
                  icon: Icons.chat_bubble_outline,
                  maxLines: 5,
                  onSaved: (value) => _feedbackData.feedbackMessage = value!,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.send_rounded),
                  label: const Text('Submit Feedback'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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