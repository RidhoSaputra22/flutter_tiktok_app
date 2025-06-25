import 'package:flutter/material.dart';
import '../register_page.dart'; // <--- BARIS INI DIPERBAIKI! '..' berarti naik satu level folder
import 'home_page.dart';
import '../models/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final otpOrPasswordController = TextEditingController();
  bool usePassword = false;
  bool isLoading = false;

  void _toggleLoginMethod() {
    setState(() {
      usePassword = !usePassword;
      otpOrPasswordController.clear();
    });
  }

  void _checkLogin() async {
    final bool login = await AuthService.getUserId() != null;
    if (login) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  void _login() async {
    try {
      final phone = phoneController.text.trim();
      final input = otpOrPasswordController.text.trim();
      if (phone.isEmpty || input.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Mohon isi semua kolom")));
        return;
      }
      setState(() => isLoading = true);

      bool data = await AuthService.login(phone, input);

      if (data) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Gagal")));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 360,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Masuk log",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Masuk dengan alamat email atau nama pengguna",
                style: TextStyle(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixText: "ID +62 | ",
                  prefixStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.black26,
                  hintText: "Nomor telepon",
                  hintStyle: const TextStyle(color: Colors.white38),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: otpOrPasswordController,
                      obscureText: usePassword,
                      keyboardType: usePassword
                          ? TextInputType.text
                          : TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black26,
                        hintText: usePassword
                            ? "Kata sandi"
                            : "Masukkan kode 6 digit",
                        hintStyle: const TextStyle(color: Colors.white38),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  if (!usePassword) ...[
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Kode dikirim (simulasi)"),
                          ),
                        );
                      },
                      child: const Text(
                        "Kirim kode",
                        style: TextStyle(color: Colors.pinkAccent),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: _toggleLoginMethod,
                  child: Text(
                    usePassword
                        ? "Masuk dengan kode OTP"
                        : "Masuk dengan kata sandi",
                    style: const TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: isLoading ? null : _login,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Masuk log",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.white24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Belum punya akun?",
                    style: TextStyle(color: Colors.white54),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      "Daftar",
                      style: TextStyle(color: Colors.pinkAccent),
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
}
