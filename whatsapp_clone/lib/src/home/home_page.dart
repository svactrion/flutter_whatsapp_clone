import 'package:flutter/material.dart';
import '../models/chat_item.dart'; // ChatItem artık model klasöründe

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Alt navigasyon çubuğunda seçili sayfa indeksi
  int _currentIndex = 3; // "Sohbetler"

  // Filtre seçenekleri ("Tümü", "Okunmamış", "Gruplar", "Favoriler")
  final List<String> _filters = ['Tümü', 'Okunmamış', 'Gruplar'];
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    // Chat verisi (Map tabanlı)
    final List<Map<String, dynamic>> chats = [
      {
        'avatar': 'images/ege.png',
        'name': 'Ege Universitesi 2025',
        'message': 'Sınavlar açıklanmış.',
        'time': '09:45',
        'isFavorite': true,
        'isUnread': false,
        'isGroup': false,
      },
      {
        'avatar': 'images/ahmet.png',
        'name': 'Ahmet Tayfur',
        'message': 'Tamamdır.',
        'time': '09:37',
        'isFavorite': false,
        'isUnread': true,
        'isGroup': false,
      },
      {
        'avatar': 'images/burak.png',
        'name': 'Burak',
        'message': 'Akşam saat kaçta',
        'time': 'Dün',
        'isFavorite': false,
        'isUnread': false,
        'isGroup': true,
      },
      {
        'avatar': 'images/techca.png',
        'name': 'Flutter Bootcamp',
        'message': 'Bootcampi başarıyla tammaladınız.Tebrikler',
        'time': 'Dün',
        'isFavorite': false,
        'isUnread': false,
        'isGroup': true,
      },
      {
        'avatar': 'images/haluk.png',
        'name': 'Haluk Aktan',
        'message': 'Naber?',
        'time': 'Dün',
        'isFavorite': false,
        'isUnread': false,
        'isGroup': true,
      },
      {
        'avatar': 'images/efe.png',
        'name': 'Efe Topalak ',
        'message': 'Çok iyi olmuş',
        'time': 'Dün',
        'isFavorite': false,
        'isUnread': false,
        'isGroup': true,
      },
    ];

    // Filtreye göre gösterilecek sohbetleri belirle
    List<Map<String, dynamic>> displayedChats;
    switch (_selectedFilter) {
      case 1: // Okunmamış
        displayedChats = chats.where((c) => c['isUnread'] == true).toList();
        break;
      case 2: // Gruplar
        displayedChats = chats.where((c) => c['isGroup'] == true).toList();
        break;
      case 3: // Favoriler
        displayedChats = chats.where((c) => c['isFavorite'] == true).toList();
        break;
      default: // Tümü
        displayedChats = chats;
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],

      // Üst kısım: "Sohbetler" başlığı ve ikonlar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Sohbetler',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle,
              color: Color(0xFF25D366),
              size: 28,
            ),
          ),
        ],
      ),

      // Gövde: Filtre çipleri ve sohbet listesi
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtre çipleri
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: List.generate(_filters.length, (i) {
                  final isSelected = i == _selectedFilter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        _filters[i],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color.fromARGB(255, 81, 206, 146),
                      backgroundColor: const Color(0xFFF0F0F0),
                      onSelected: (_) {
                        setState(() => _selectedFilter = i);
                      },
                    ),
                  );
                }),
              ),
            ),

            // Sohbet öğeleri listesi
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: displayedChats.length,
                itemBuilder: (context, index) {
                  final chat = displayedChats[index];
                  return ChatItem(
                    avatarPathOrUrl: chat['avatar'] as String,
                    name: chat['name'] as String,
                    message: chat['message'] as String,
                    time: chat['time'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Alt navigasyon çubuğu
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (idx) => setState(() => _currentIndex = idx),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF25D366),
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Güncellemeler',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Aramalar',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Topluluklar',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.chat_bubble_outline),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: const Text(
                      '2',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            label: 'Sohbetler',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}
