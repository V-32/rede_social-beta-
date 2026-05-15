import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final TextEditingController _nameController = TextEditingController(text: "Seu Nome");
  final TextEditingController _emailController = TextEditingController(text: "seuemail@gmail.com");
  final TextEditingController _phoneController = TextEditingController(text: "+55 11 99999-9999");
  final TextEditingController _locationController = TextEditingController(text: "Brasil");

  int _selectedIndex = 1; // Começa selecionado no Perfil

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Column(
        children: [
          // NAVBAR ATUALIZADA
          _buildTopNavbar(),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MENU LATERAL ATUALIZADO (Home, Perfil, Mensagens, Notificações)
                _buildSidebar(),

                // CONTEÚDO PRINCIPAL
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
          const Text(
            "FreeLogo Design",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          
          // Novos botões da Navbar
          _navbarTextButton("Mensagens"),
          _navbarTextButton("Perfil"),
          
          const SizedBox(width: 20),
          const Icon(Icons.notifications_none, color: Colors.white),
          const SizedBox(width: 16),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
          ),
        ],
      ),
    );
  }

  Widget _navbarTextButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
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
          _sidebarItem(0, Icons.home_outlined, "Home"),
          _sidebarItem(1, Icons.person_outline, "Meu Perfil"),
          _sidebarItem(2, Icons.mail_outline, "Mensagens"),
          _sidebarItem(3, Icons.notifications_none, "Notificações"),
          const Spacer(),
          const Divider(),
          _sidebarItem(4, Icons.logout, "Sair", isLogout: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sidebarItem(int index, IconData icon, String label, {bool isLogout = false}) {
    bool isSelected = _selectedIndex == index;
    return ListTile(
      leading: Icon(
        icon, 
        color: isLogout ? Colors.red : (isSelected ? const Color(0xFF0052CC) : Colors.black54)
      ),
      title: Text(
        label, 
        style: TextStyle(
          color: isLogout ? Colors.red : (isSelected ? const Color(0xFF0052CC) : Colors.black87),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        )
      ),
      onTap: () => setState(() => _selectedIndex = index),
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Detalhes do Perfil", 
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 24),
        
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05), 
                blurRadius: 15, 
                offset: const Offset(0, 5)
              )
            ],
          ),
          child: Column(
            children: [
              _buildEditField("Nome Completo", _nameController),
              _buildEditField("E-mail", _emailController),
              _buildEditField("Telefone", _phoneController),
              _buildEditField("Localização", _locationController),
              const SizedBox(height: 40),
              
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Alterações salvas!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0052CC),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Text(
                    "SALVAR ALTERAÇÕES", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label, 
            style: const TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold)
          ),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFDFE1E6))),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF0052CC))),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}