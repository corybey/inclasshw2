import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../home/boards_home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final _userService = UserService();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _roleController = TextEditingController(text: 'student');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _error;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final cred = await _authService.register(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = AppUser(
        uid: cred.user!.uid,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        role: _roleController.text.trim(),
        registeredAt: DateTime.now(),
      );

      await _userService.createUser(user);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, BoardsHomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message;
      });
    } catch (e) {
      setState(() {
        _error = 'Registration failed. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _roleController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_error != null)
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(labelText: 'First Name'),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Enter your first name'
                          : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Enter your last name'
                          : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _roleController,
                      decoration: const InputDecoration(labelText: 'Role'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => val == null || val.isEmpty
                          ? 'Enter your email'
                          : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (val) => val == null || val.length < 6
                          ? 'Password must be at least 6 characters'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Register'),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
