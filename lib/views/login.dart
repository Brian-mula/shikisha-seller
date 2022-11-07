import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: IntlPhoneField(
          controller: phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          initialCountryCode: 'KE',
          onChanged: (phone) {
            print(phone.completeNumber);
          },
        ),
      ),
    );
  }
}
