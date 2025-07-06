// Fixed login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/login_provider.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/auth/login/login_state.dart';
import 'package:workdey_frontend/shared/components/text_field_widget.dart';
import 'package:workdey_frontend/features/auth/login/login_utils.dart';

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
    // Clear any previous form data when login screen opens
    _emailController.clear();
    _passwordController.clear();
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
    
    // 🎯 FIXED: Remove navigation from here - let App widget handle it
    ref.listen<AuthState>(authStateProvider, (_, next) {
      next.whenOrNull(
        authenticated: (_) async {
          debugPrint('\n🔐 Login successful - letting App widget handle navigation');
          
          // Verify token storage
          final verifiedToken = await AuthUtils.verifyToken();
          if (verifiedToken == null) {
            debugPrint('❌ Critical: Token verification failed during navigation');
          } else {
            debugPrint('✅ Token verified during navigation');
          }
  
          // 🎯 KEY CHANGE: Don't navigate manually - App widget will handle this
          // The App widget watches authStateProvider and will automatically
          // switch to MainApp when state becomes 'authenticated'
        },
        error: (message) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        loading: () {
          // Handle loading state if needed
          setState(() => _isLoading = true);
        },
        initial: () {
          // Reset loading state when back to initial
          if (mounted) {
            setState(() => _isLoading = false);
          }
        },
      );
    });
    
    return Scaffold(
      // 🎯 FIXED: Don't add back button on login screen after logout
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false, // This removes the back button
        title: const Text(
          'Welcome Back',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E8728),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Logo or app branding
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF3E8728).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.work,
                  size: 60,
                  color: Color(0xFF3E8728),
                ),
              ),
              const SizedBox(height: 32),
              
              Text(
                'Welcome to Workdey', 
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFF3E8728),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Find your perfect job in Cameroon',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 48),
              
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email,
                enabled: !_isLoading, // Disable during loading
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your email';
                  if (!value!.contains('@')) return 'Please enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                obscureText: _obscurePassword,
                icon: Icons.lock,
                enabled: !_isLoading, // Disable during loading
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your password';
                  if (value!.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword 
                      ? Icons.visibility_off 
                      : Icons.visibility),
                  onPressed: _isLoading ? null : () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _isLoading ? null : () => Navigator.pushNamed(context, '/forgot-password'),
                  child: const Text('Forgot Password?'),
                ),
              ),
              
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF3E8728),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading 
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Logging in...'),
                          ],
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.pushNamed(context, AppRoutes.signup),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF3E8728),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
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
        // Don't manually set _isLoading = false here
        // Let the auth state listener handle UI updates
      } catch (e) {
        // Only reset loading state on error
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }
}