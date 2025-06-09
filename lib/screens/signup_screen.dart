import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/signup/signup_model.dart';
import 'package:workdey_frontend/core/providers/signup_provider.dart';
import 'package:workdey_frontend/features/auth/signup/signup_state.dart';
import 'package:workdey_frontend/shared/components/text_field_widget.dart';
import 'package:workdey_frontend/shared/utils/phone_formatter.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
  
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController(text: '+237');
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _obscurePassword = true;
  String _getCompressedPhoneNumber() {
    return _phoneController.text.replaceAll(' ', '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final signupState = ref.watch(signupProvider);

 ref.listen<SignupState>(signupProvider, (previous, current) {
    current.maybeWhen(
       success: () {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Signup successful!', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.green,
    ),
  );
  Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
},
      error: (errorMessage) {
        final message = errorMessage ?? 'Registration failed';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red[700],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              left: 20,
              right: 20,
            ),
            duration: Duration(seconds: 3),
          )
        );
      },
      orElse: () {},
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
              Text('Create Account', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Join Workdey to find your perfect job',
                  style: theme.textTheme.bodyMedium),
              const SizedBox(height: 32),
              
              CustomTextField(
                controller: _firstNameController,
                label: 'First Name',
                icon: Icons.person,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.givenName],
                helperText: 'As it appears on your ID card',
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your first name';
                  if (value!.length < 2) return 'Name is too short';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                controller: _lastNameController,
                label: 'Last Name',
                icon: Icons.person,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.givenName],
                helperText: 'As it appears on your ID card',
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your first name';
                  if (value!.length < 2) return 'Name is too short';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone, 
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    CameroonPhoneFormatter(),
                    LengthLimitingTextInputFormatter(17), // +237 6 XX XX XX XX
                  ],
                  autofillHints: const [AutofillHints.telephoneNumber],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter phone number';
                    if (!RegExp(r'^\+237 [6-9]\d{2}( \d{2}){3}$').hasMatch(value)) {
                      return 'Enter a valid format: +237 6xx xx xx xx';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

              CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your email';
                  if (value!.length < 6) return 'wrong email length';
                  return null;
                },
                ),
                const SizedBox(height: 16),

              //Password field
              CustomTextField(
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
              
              // Other fields (last name, email, phone, password)...
              
              const SizedBox(height: 24),
              FilledButton(
                onPressed: signupState.maybeWhen(
                loading: () => null,
                orElse: () => _submit,
              ),
              child: signupState.maybeWhen(
                loading: () => const CircularProgressIndicator(),
                orElse: () => const Text('Sign Up'),
              ),
            ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final signup = Signup(
        email: _emailController.text.trim(),
        phone: _getCompressedPhoneNumber(),
        password: _passwordController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
      );
      await ref.read(signupProvider.notifier).register(signup);
    }
  }
}