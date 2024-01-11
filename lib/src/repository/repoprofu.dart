// repository.dart
import 'package:fix/src/models/profilu.dart';

class Repository {
  Future<User?> getUserData() async {
    try {
      // Simulasikan pengambilan data dari sumber eksternal
      await Future.delayed(Duration(seconds: 2));

      return User(
        id: '1',
        name: 'Muhammad Rangga',
        email: 'MuhammadRangga@gmail.com',
        profileImage: 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/513.jpg',
      );
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
