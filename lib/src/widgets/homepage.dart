import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix/global/cummon/toast.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/forest.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 45.0,
                      ),
                      child: Text(
                        'Hi, Welcome to\nHiky',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text(
                        'Browse Categories',
                        style: TextStyle(fontSize: 21, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    print('User Berhasil Log out');
                    Navigator.pushNamed(context, '/login');
                    showToast(message: 'User signed out');
                  },
                ),
                backgroundColor:
                    Colors.transparent, // Warna latar belakang transparan
                elevation: 0, // Tidak menampilkan bayangan di bawah app bar
              ),
            ),
          ),
          // Menambahkan baris gambar dengan posisi yang sudah ditentukan
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Baris pertama gambar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Gambar kedua
                      InkWell(
                        onTap: () {
                          // Tambahkan aksi yang ingin dilakukan saat gambar diklik
                          Navigator.pushNamed(context, "/mountain");
                          print('Mountain button clicked!');
                          // Tambahkan navigasi atau tindakan lain sesuai kebutuhan
                        },
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/mountain_circle.jpg',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('Mountain',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ],
                        ),
                      ),
                      SizedBox(width: 50),
                      // Gambar ketiga
                      InkWell(
                        onTap: () {
                          // Tambahkan aksi yang ingin dilakukan saat gambar diklik
                          print('Forest button clicked!');
                          // Tambahkan navigasi atau tindakan lain sesuai kebutuhan
                        },
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/forest_circle.jpg',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('Forest',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Baris kedua gambar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Gambar keempat
                      InkWell(
                        onTap: () {
                          // Tambahkan aksi yang ingin dilakukan saat gambar diklik
                          print('Beach button clicked!');
                          // Tambahkan navigasi atau tindakan lain sesuai kebutuhan
                        },
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/beach_circle.jpg',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('Beach',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: const Color.fromARGB(188, 0, 0, 0),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color.fromARGB(181, 180, 193, 0),
            gap: 6,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
                switch (_currentIndex) {
                  case 0:
                    Navigator.pushNamed(context, '/homepage');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/cardview');
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/bio');
                    break;
                }
              });
            },
            padding: EdgeInsets.all(16),
            selectedIndex: _currentIndex,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.data_exploration_outlined,
                text: 'Data',
              ),
              GButton(
                icon: Icons.person_outline_outlined,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
