//Vítor Gabriel Gaspar de Paula N°32 e Vítor Augusto Almeida Costa N°31
import 'package:flutter/material.dart';
import 'perfil.dart'; 
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();
  int _selectedIndex = 0; 

  final List<Map<String, dynamic>> _posts = [
    {
      "user": "Ana Silva",
      "time": "2h atrás",
      "content": "Acabei de finalizar o novo design do projeto! O que acharam?",
      "likes": 12,
      "comments": 3,
      "isLiked": false,
    },
    {
      "user": "Carlos Eduardo",
      "time": "5h atrás",
      "content": "Alguém sabe como resolver um bug de overflow no Flutter? 😅",
      "likes": 8,
      "comments": 15,
      "isLiked": true,
    },
  ];

  void _addPost() {
    if (_postController.text.isNotEmpty) {
      setState(() {
        _posts.insert(0, {
          "user": "Seu Nome",
          "time": "Agora mesmo",
          "content": _postController.text,
          "likes": 0,
          "comments": 0,
          "isLiked": false,
        });
        _postController.clear();
      });
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
                    child: Column(
                      children: [
                        _buildCreatePostCard(),
                        const SizedBox(height: 24),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _posts.length,
                          itemBuilder: (context, index) => _buildPostItem(_posts[index], index),
                        ),
                      ],
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
          _sidebarItem(0, Icons.home, "Home", onTap: () {}),
          _sidebarItem(1, Icons.person_outline, "Meu Perfil", onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PerfilPage()),
            );
          }),
          _sidebarItem(2, Icons.mail_outline, "Mensagens", onTap: () {}),
          _sidebarItem(3, Icons.notifications_none, "Notificações", onTap: () {}),
          const Spacer(),
          const Divider(),
          _sidebarItem(4, Icons.logout, "Sair", isLogout: true, onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }),
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

  Widget _buildCreatePostCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
      child: Column(
        children: [
          TextField(
            controller: _postController,
            maxLines: 3,
            decoration: const InputDecoration(hintText: "O que você está pensando?", border: InputBorder.none),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _addPost,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0052CC)),
                child: const Text("Publicar", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostItem(Map<String, dynamic> post, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFDFE1E6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Colors.blueGrey, child: Icon(Icons.person, color: Colors.white)),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(post['user'], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(post['time'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
            ],
          ),
          const SizedBox(height: 16),
          Text(post['content'], style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 16),
          const Divider(),
          Row(
            children: [
              IconButton(
                icon: Icon(post['isLiked'] ? Icons.favorite : Icons.favorite_border, color: post['isLiked'] ? Colors.red : Colors.grey),
                onPressed: () => setState(() => post['isLiked'] = !post['isLiked']),
              ),
              Text("${post['likes']}"),
              const SizedBox(width: 24),
              const Icon(Icons.chat_bubble_outline, size: 20, color: Colors.grey),
              const SizedBox(width: 8),
              Text("${post['comments']}"),
            ],
          ),
        ],
      ),
    );
  }
}