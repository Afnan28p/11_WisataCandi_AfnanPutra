import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
// TODO: 1.Deklarasi variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _isSignedIn = false;
  bool _obsecurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO : 2. Pasang Appbar
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      //TODO : 3. Pasang body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                child: Column(
              //TODO : 4. Atur MainAxisAlignment dan croosAxisAlignment
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //TODO: 5.Pasang TextFormField Nama Pengguna
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Pengguna',
                    border: OutlineInputBorder(),
                  ),
                ),
                //TODO: 6. Pasang TextFormField Password
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: _errorText.isNotEmpty ? _errorText : null,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecurePassword = !_obsecurePassword;
                        });
                      },
                      icon: Icon(_obsecurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  obscureText: _obsecurePassword,
                ),
                //TODO: 7.Pasang ElevatedButton Sign In
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Sign In')),
                //TODO: 8.Pasang ElevatedButton Sign Up
                SizedBox(
                  height: 20,
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: const Text('Belum Punya Akun? Sign Up'),
                // ),
                RichText(
                  text: TextSpan(
                    text: 'Belum Punya Akun? ',
                    style: const TextStyle(
                      color: Colors.deepPurple,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
