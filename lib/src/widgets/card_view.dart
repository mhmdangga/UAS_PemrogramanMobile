import 'package:fix/src/models/model.dart'; // Sesuaikan dengan nama proyek Anda
import 'package:fix/src/repository/repository.dart'; // Import repository yang telah dibuat
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyCardView extends StatefulWidget {
  const MyCardView({Key? key}) : super(key: key);

  @override
  _MyCardViewState createState() => _MyCardViewState();
}

class _MyCardViewState extends State<MyCardView> {
  int _currentIndex = 1;
  List<Data> dataList = [];
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    fetchData();
    print(dataList.length);
  }

  Future<void> fetchData() async {
    try {
      final repository = Repository();
      List<Data> newDataList = await repository.getData();
      setState(() {
        dataList = newDataList;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF265073),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Get API Public',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return CardItem(data: dataList[index]);
              },
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

class CardItem extends StatelessWidget {
  final Data data;

  CardItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'ID: ${data.id}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Nama: ${data.nama}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${data.email}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Kota: ${data.kota}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            // Displaying the image using Image.network
            Image.network(
              data.gambar,
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
            ),
          ],
        ),
      ),
    );
  }
}
