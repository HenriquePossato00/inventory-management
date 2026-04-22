import 'package:flutter/material.dart';
import 'package:inventory_management/features/auth/viewModel/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext contex) {
    final vm = contex.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Senha"),
            ),
            SizedBox(height: 20),

            if (vm.error !=null) 
              Text(vm.error!, style:  TextStyle(color: Colors.red)),

            SizedBox(height: 10),

            vm.isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                onPressed: () async {
                  final sucsses = await vm.login(
                    emailController.text,
                    passwordController.text
                    );

                  if(sucsses) {
                    Navigator.pushReplacementNamed(context, "/home");
                  }
                },
                child: Text("Entrar"),
                ),
          ],
        ), 
        ),
    );
  }
}