  import 'package:flutter/material.dart';
  // Import halaman yang sudah dibuat
  import 'dashboard.dart';
  import 'InformasiPage.dart';
  import 'AgendaPage.dart';
  import 'GalleryPage.dart';
  // import 'KategoriPage.dart';
  import 'ProfilePage.dart';

  class DashboardScreen extends StatefulWidget {
    const DashboardScreen({super.key});

    @override
    State<DashboardScreen> createState() => _DashboardScreenState();
  }

  class _DashboardScreenState extends State<DashboardScreen> {
    final int agendaCount = 10;
    final int informasiCount = 5;
    final int galleryCount = 8;

    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });

      // Navigasi ke halaman yang sesuai
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InformasiPage()),
          );
          break;
        case 2:
          // Navigator.push(
          //   // context,
          //   // MaterialPageRoute(builder: (context) => AgendaPage()),
          // );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GalleryScreen()),
          );
          
          break;
        case 4:
          // Navigator.push(
          //   // context,
          //   // MaterialPageRoute(builder: (context) => KategoriPage()),
          // );
          break;
        case 5:
          // Navigator.push(
          //   // context,
          //   // MaterialPageRoute(builder: (context) => ProfilePage()),
          // );
          break;
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCard(
                      color: Colors.blue,
                      title: 'Agenda',
                      count: agendaCount,
                      icon: Icons.calendar_today,
                    ),
                    _buildCard(
                      color: Colors.green,
                      title: 'Informasi',
                      count: informasiCount,
                      icon: Icons.info,
                    ),
                    _buildCard(
                      color: Colors.orange,
                      title: 'Gallery',
                      count: galleryCount,
                      icon: Icons.photo,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Informasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Agenda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'Gallery',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Kategori',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      );
    }

    Widget _buildCard({
      required Color color,
      required String title,
      required int count,
      required IconData icon,
    }) {
      return Expanded(
        child: Card(
          color: color.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Jumlah $title: $count',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
