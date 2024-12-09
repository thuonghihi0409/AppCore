import 'package:appcore/UI/search_screen.dart';
import 'package:appcore/utils/data.dart';
import 'package:appcore/widgets/category_button.dart';
import 'package:appcore/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeSreeenState();
}

class _HomeSreeenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Theo dõi tab hiện tại

  // Danh sách các màn hình tương ứng với các tab
  final List<Widget> _screens = [
    HomeTab(),
    SearchScreen(),
    Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Hiển thị màn hình theo tab
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex, // Tab đang được chọn
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.yellow),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: '',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Cloths',
          style: TextStyle(color: Colors.white,fontFamily: 'KoHo'),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Text(
            'Collection',
            style: TextStyle(color: Colors.white),
          ),
          // Danh mục
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoryButton(label: 'All', isSelected: true),
                ...categories_data.map((element) =>
                    CategoryButton(label: element.title, isSelected: false))
              ],
            ),
          ),
          // Danh sách sản phẩm
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products_data.length,
              itemBuilder: (context, index) {
                final item = products_data[index];
                return ProductCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
