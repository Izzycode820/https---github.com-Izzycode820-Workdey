import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/auth/auth_provider.dart';
import 'package:workdey_frontend/features/auth/auth_state.dart';
import 'package:workdey_frontend/features/auth/auth_text_field_widget.dart';
import 'package:workdey_frontend/features/auth/auth_utils.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // No need for post-frame callback here
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Add the listener directly in build where we have access to context
    ref.listen<AuthState>(authStateProvider, (_, next) {
      next.whenOrNull(
        authenticated: (_) async {
          debugPrint('\n🔐 Login successful - verifying token storage');
          
          // Verify token storage
          final verifiedToken = await AuthUtils.verifyToken();
          if (verifiedToken == null) {
            debugPrint('❌ Critical: Token verification failed during navigation');
          } else {
            debugPrint('✅ Token verified during navigation');
          }
  
          // Add a small delay to ensure token propagation
          await Future.delayed(const Duration(milliseconds: 100));

          if (mounted) {
            debugPrint("🏠 Navigating to home screen");
            Navigator.pushReplacementNamed(context, '/home').then((_) {
              debugPrint("🏠 Home screen navigation complete");
              // Verify token after navigation
              AuthUtils.verifyToken();
            });
          }
        },
        error: (message) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          }
        },
      );
    });
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Welcome to Workdey', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Find your perfect job in Cameroon',
                  style: theme.textTheme.bodyMedium),
              const SizedBox(height: 32),
              
              AuthTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your email';
                  if (!value!.contains('@')) return 'Please enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              AuthTextField(
                controller: _passwordController,
                label: 'Password',
                obscureText: _obscurePassword,
                icon: Icons.lock,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your password';
                  if (value!.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword 
                      ? Icons.visibility_off 
                      : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                  child: const Text('Forgot Password?'),
                ),
              ),
              
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading 
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await ref.read(authStateProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }
}