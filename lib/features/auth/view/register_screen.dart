import 'package:flutter/material.dart';
import 'package:foodey/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _agreeToTerms = false;

  // Validation methods
  bool get _isEmailValid {
    final email = _emailController.text.trim();
    return email.isNotEmpty &&
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool get _isPasswordValid {
    final password = _passwordController.text;
    return password.length >= 6; // Minimum 6 characters
  }

  bool get _canProceed {
    return _isEmailValid && _isPasswordValid && _agreeToTerms;
  }

  // Registration function
  void _handleRegistration() {
    if (_canProceed) {
      // Handle registration logic here
      // You can add API calls, validation, etc.
      context.go('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _emailController.removeListener(_onFieldChanged);
    _passwordController.removeListener(_onFieldChanged);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {
      // Trigger rebuild to update validation state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Foodey",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontFamily: 'Arial',
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Create a new account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // Email field
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'email address',
                  hintStyle: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFCFDFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _emailController.text.isNotEmpty && !_isEmailValid
                          ? Colors.red
                          : Color(0xFFF5F5F5),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: _emailController.text.isNotEmpty
                      ? Icon(
                          _isEmailValid ? Icons.check_circle : Icons.error,
                          color: _isEmailValid ? Colors.green : Colors.red,
                        )
                      : null,
                ),
              ),

              const SizedBox(height: 16),

              // Password field
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'password',
                  hintStyle: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFCFDFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color:
                          _passwordController.text.isNotEmpty &&
                              !_isPasswordValid
                          ? Colors.red
                          : Color(0xFFF5F5F5),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // if (_passwordController.text.isNotEmpty)
                      //   Icon(
                      //     _isPasswordValid ? Icons.check_circle : Icons.error,
                      //     color: _isPasswordValid ? Colors.green : Colors.red,
                      //   ),
                      IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFF60655C),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Terms & Conditions checkbox
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (_isEmailValid && _isPasswordValid)
                        ? (value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          }
                        : null,
                    activeColor: AppColors.primary,
                    checkColor: Colors.white,
                    side: BorderSide(
                      color: (_isEmailValid && _isPasswordValid)
                          ? Color(0xFF60655C)
                          : Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'I agree to terms & conditions',
                      style: TextStyle(
                        fontSize: 16,
                        color: (_isEmailValid && _isPasswordValid)
                            ? Color(0xFF363A33)
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Create Account button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canProceed ? _handleRegistration : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _canProceed
                        ? AppColors.primary
                        : const Color(0xFFE8F5E8),
                    foregroundColor: _canProceed
                        ? Colors.white
                        : const Color(0xFF5CAB1A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Back to login
              Center(
                child: TextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(
                        color: Color(0xFF60655C),
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
