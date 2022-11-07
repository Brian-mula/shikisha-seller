import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shikishaseller/widgets/info_text.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController phoneController = TextEditingController();
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntlPhoneField(
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
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green.shade700)),
                    onPressed: () {
                      Navigator.pushNamed(context, "/home");
                    },
                    icon: const Icon(
                      Icons.lock,
                      size: 30,
                      color: Colors.white,
                    ),
                    label: InfoText(
                      text: "Login",
                      textStyle: theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
