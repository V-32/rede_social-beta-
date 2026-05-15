//Vítor Gabriel Gaspar de Paula N°32 e Vítor Augusto Almeida Costa N°31
import 'package:flutter/material.dart';
import 'splash_screen.dart'; 
import 'perfil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreeLogo Design Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'sans-serif',
      ),
      
      home: const LoginPage(),
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Container(
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF9C27B0), Color(0xFFF44336)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Icon(Icons.blur_on, color: Colors.white, size: 30),
                const SizedBox(width: 8),
                const Text(
                  'FreeLogo\nDesign',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    height: 0.9,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Row(
              children: [
                
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Iniciar sessão',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        _buildTextField(
                          label: 'Endereço de e-mail',
                          hint: 'exemplo@email.com',
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 20),
                        
                        _buildTextField(
                          label: 'Palavra-passe',
                          hint: '••••••••',
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),
                        
                        const SizedBox(height: 30),
                        
                       
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const SplashScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF222222),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('ENTRAR'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&q=80&w=2070'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: isPassword 
              ? IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                )
              : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}