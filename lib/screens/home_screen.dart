import 'package:appcore/screens/profile_screen.dart';
import 'package:appcore/screens/search_screen.dart';
import 'package:appcore/utils/data.dart';
import 'package:appcore/utils/screen_size.dart';
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
    ProfileScreen(),
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
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle
              ),
                child: Padding(

                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.search, color: Colors.black),
                )),
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

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'All'; // Lưu trạng thái của danh mục được chọn

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Cloths',
          style: TextStyle(color: Colors.white, fontFamily: "KoHo", fontSize: 46),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 20),
              Text(
                'Collection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  fontFamily: 'KoHo',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          // Danh mục
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Nút 'All'
                CategoryButton(
                  label: 'All',
                  isSelected: selectedCategory == 'All',
                  onTap: () {
                    setState(() {
                      selectedCategory = 'All';
                    });
                  },
                ),
                // Các danh mục từ `categories_data`
                ...categories_data.map((element) => CategoryButton(
                  label: element.title,
                  isSelected: selectedCategory == element.title,
                  onTap: () {
                    setState(() {
                      selectedCategory = element.title;
                    });
                  },
                )),
              ],
            ),
          ),
          // Danh sách sản phẩm
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products_data.length,
              itemBuilder: (context, index) {
                final item = products_data[index];
                // Lọc sản phẩm dựa trên danh mục được chọn
                if (selectedCategory != 'All' &&
                    item.category != selectedCategory) {
                  return const SizedBox.shrink(); // Ẩn sản phẩm không phù hợp
                }
                return ProductCard(item: item, screen: screen, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

