import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 4;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    "hana",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                  const Spacer(),
                  const Icon(Icons.qr_code, size: 24),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _logout,
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.black12,
                      child: Icon(Icons.logout, size: 18),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.add, size: 18, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            const Text(
              "hana80978",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _ProfileCount(title: "Mengikuti", count: "867"),
                SizedBox(width: 24),
                _ProfileCount(title: "Pengikut", count: "24"),
                SizedBox(width: 24),
                _ProfileCount(title: "Suka", count: "0"),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Edit profil"),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Bagikan profil"),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: const Icon(Icons.person_add_alt_1, size: 16),
                ),
              ],
            ),

            const SizedBox(height: 8),
            const Text("+ Tambahkan bio"),
            const SizedBox(height: 4),
            const Text("🛍️ Pesanan Shop | Tokopedia"),

            const SizedBox(height: 12),
            const Divider(height: 1),

            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.black45,
              tabs: const [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.lock_outline)),
                Tab(icon: Icon(Icons.share)),
                Tab(icon: Icon(Icons.favorite_border)),
              ],
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildVideoGrid(),
                  _buildEmptyState("Video pribadi"),
                  _buildEmptyState("Video yang dibagikan"),
                  _buildEmptyState("Video yang disukai"),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Toko'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, color: Colors.pink),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Kotak Masuk'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_outlined, size: 64, color: Colors.black38),
          const SizedBox(height: 16),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildVideoGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: 6,
      itemBuilder:
          (_, index) => Container(
            color: Colors.grey.shade300,
            child: const Icon(Icons.play_circle_outline, color: Colors.black38),
          ),
    );
  }
}

class _ProfileCount extends StatelessWidget {
  final String count;
  final String title;
  const _ProfileCount({required this.count, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(title),
      ],
    );
  }
}
