//Vítor Gabriel Gaspar de Paula N°32 e Vítor Augusto Almeida Costa N°31
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home.dart'; 
import 'main.dart'; // <-- Importação adicionada para reconhecer a LoginPage

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final supabase = Supabase.instance.client;
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final int _selectedIndex = 1; 

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      final data = await supabase.from('profiles').select().eq('id', user.id).single();
      if (mounted) {
        setState(() {
          _nameController.text = data['full_name'] ?? "";
          _emailController.text = user.email ?? ""; 
          _phoneController.text = data['phone'] ?? "";
          _locationController.text = data['location'] ?? "";
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao carregar perfil: $e")));
      }
    }
  }

  Future<void> _saveProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      await supabase.from('profiles').update({
        'full_name': _nameController.text,
        'phone': _phoneController.text,
        'location': _locationController.text,
      }).eq('id', user.id);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Alterações salvas!")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao salvar: $e")));
      }
    }
  }

  // <-- FUNÇÃO DE LOGOUT ATUALIZADA AQUI
  Future<void> _logout() async {
    await supabase.auth.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Column(
        children: [
          _buildTopNavbar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSidebar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32.0),
                    child: _buildMainContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavbar() {
    return Container(
      height: 60,
      color: const Color(0xFF0052CC),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.blur_on, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          const Text("FreeLogo Design", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const Spacer(),
          _navbarTextButton("Mensagens"),
          _navbarTextButton("Perfil"),
          const SizedBox(width: 20),
          const Icon(Icons.notifications_none, color: Colors.white),
          const SizedBox(width: 16),
          const CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d')),
        ],
      ),
    );
  }

  Widget _navbarTextButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () {}, 
        child: Text(title, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 260,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 30),
          _sidebarItem(0, Icons.home_outlined, "Home", onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()), 
            );
          }),
          _sidebarItem(1, Icons.person_outline, "Meu Perfil", onTap: () {}),
          _sidebarItem(2, Icons.mail_outline, "Mensagens", onTap: () {}),
          _sidebarItem(3, Icons.notifications_none, "Notificações", onTap: () {}),
          const Spacer(),
          const Divider(),
          _sidebarItem(4, Icons.logout, "Sair", isLogout: true, onTap: _logout),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sidebarItem(int index, IconData icon, String label, {bool isLogout = false, required VoidCallback onTap}) {
    bool isSelected = _selectedIndex == index;
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : (isSelected ? const Color(0xFF0052CC) : Colors.black54)),
      title: Text(label, style: TextStyle(color: isLogout ? Colors.red : (isSelected ? const Color(0xFF0052CC) : Colors.black87), fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      onTap: onTap,
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Detalhes do Perfil", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))]),
          child: Column(
            children: [
              _buildEditField("Nome Completo", _nameController), 
              _buildEditField("E-mail", _emailController, isReadOnly: true), 
              _buildEditField("Telefone", _phoneController), 
              _buildEditField("Localização", _locationController), 
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft, 
                child: ElevatedButton(
                  onPressed: _saveProfile, 
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0052CC), padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), 
                  child: const Text("SALVAR ALTERAÇÕES", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                )
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditField(String label, TextEditingController controller, {bool isReadOnly = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold)),
        TextField(
          controller: controller, 
          readOnly: isReadOnly,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFDFE1E6))), 
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF0052CC)))
          ), 
          style: TextStyle(fontSize: 16, color: isReadOnly ? Colors.grey : Colors.black),
        ),
      ]),
    );
  }
}