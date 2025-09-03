import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodey/core/theme/app_colors.dart';
import 'package:foodey/core/data/registration_state.dart';
import 'package:foodey/core/utils/local_storage.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class RegisterOtpScreen extends StatefulWidget {
  const RegisterOtpScreen({super.key});

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  Timer? _timer;
  int _secondsLeft = 120;
  final ValueNotifier<int> _secondsLeftNotifier = ValueNotifier<int>(120);
  @override
  void initState() {
    super.initState();
    // If provider email is null, try to restore from local storage
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final container = ProviderScope.containerOf(context);
      final current = container.read(registrationEmailProvider);
      if (current == null) {
        try {
          final saved = await LocalStorage.getString(
            LocalStorage.registrationEmailKey,
          );
          if (!mounted) return;
          container.read(registrationEmailProvider.notifier).state = saved;
          setState(() {});
        } catch (_) {}
      }
    });
    _startTimer();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _focusNodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    _secondsLeftNotifier.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = 120);
    _secondsLeftNotifier.value = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (_secondsLeft <= 0) {
        t.cancel();
        setState(() => _secondsLeft = 0);
        _secondsLeftNotifier.value = 0;
      } else {
        setState(() => _secondsLeft = _secondsLeft - 1);
        _secondsLeftNotifier.value = _secondsLeft;
      }
    });
  }

  void _onChanged(int index, String value) {
    if (value.length == 1) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
      setState(() {});
    }
  }

  void _onKey(int index, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      // Clear previous box and focus it so one backspace removes a digit
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].selection = TextSelection.fromPosition(
        TextPosition(offset: _controllers[index - 1].text.length),
      );
      setState(() {});
    }
  }

  String get _otp => _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
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

              Align(
                alignment: Alignment.center,
                child: Text(
                  'Verify your new account',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              // Show the email captured from previous screen
              Consumer(
                builder: (context, ref, _) {
                  final email = ref.watch(registrationEmailProvider);
                  return Column(
                    children: [
                      Text(
                        email != null
                            ? "Enter the verification code sent to your email " +
                                  email
                            : 'no-email@missing',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF60655C),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),

              // OTP inputs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (i) {
                  return SizedBox(
                    width: 70,
                    height: 70,
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (e) => _onKey(i, e),
                      child: TextField(
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFFCFDFC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFE8EBE6),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFE8EBE6),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        onChanged: (v) {
                          // Always keep cursor at the end
                          _controllers[i].selection = TextSelection.collapsed(
                            offset: _controllers[i].text.length,
                          );
                          _onChanged(i, v);
                        },
                        onTap: () {
                          // Force caret to end; disallow placing before the digit
                          _controllers[i].selection = TextSelection.collapsed(
                            offset: _controllers[i].text.length,
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),

              // Timer and Resend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't received the code? ",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: _secondsLeftNotifier,
                    builder: (context, value, _) {
                      return Text(
                        _formatTime(value),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _secondsLeft == 0
                        ? () {
                            for (final c in _controllers) c.clear();
                            _focusNodes.first.requestFocus();
                            _startTimer();
                          }
                        : null,
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _secondsLeft == 0
                            ? AppColors.primary
                            : Colors.grey.shade400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _otp.length == 4 ? _onVerifyPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _otp.length == 4
                        ? AppColors.primary
                        : const Color(0xFFE8F5E8),
                    foregroundColor: _otp.length == 4
                        ? Colors.white
                        : const Color(0xFF5CAB1A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final mm = (seconds ~/ 60).toString().padLeft(2, '0');
    final ss = (seconds % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  void _onVerifyPressed() {
    _showAlert(title: 'Verification', message: 'Code entered: ' + _otp);
  }

  void _showAlert({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
