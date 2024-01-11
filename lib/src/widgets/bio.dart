
// user_profile_page.dart
import 'package:flutter/material.dart';
import 'package:fix/src/models/profilu.dart';
import 'package:fix/src/repository/repoprofu.dart'; // Import the Repository class
import 'package:google_nav_bar/google_nav_bar.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late User? user; // Change type to User?

  int _currentIndex = 2;
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final User? fetchedUser = await repository.getUserData();
      setState(() {
        user = fetchedUser;
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        automaticallyImplyLeading: false,
      ),
      body: user != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      user!.profileImage,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Name: ${user!.name}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ${user!.email}',
                    style: TextStyle(fontSize: 18),
                  ),
                  // Add other information as needed
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
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
                    // Do nothing since we are already on the profile page
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

