import 'package:appcore/UI/home_screen.dart';
import 'package:appcore/providers/search_Provider.dart';
import 'package:appcore/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10, right: 20),
          child: Consumer<SearchProvider>(
            builder: (context, provider, child) {
              return Container(
                height: 41,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  onChanged: (query) {
                    provider.searchProducts(query);  // Tìm kiếm khi người dùng nhập
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search product...',
                    hintStyle: TextStyle(color: Colors.grey),
                    //prefixIcon: Icon(Icons.search, color: Colors.white),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(  // Bọc toàn bộ Column trong SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              // Danh sách sản phẩm tìm kiếm được
              Consumer<SearchProvider>(
                builder: (context, provider, child) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    shrinkWrap: true,  // Đảm bảo GridView không chiếm toàn bộ không gian
                    physics: NeverScrollableScrollPhysics(),  // Tắt cuộn mặc định của GridView
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: provider.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final item = provider.filteredProducts[index];
                      return ProductCard(item: item);  // Hiển thị sản phẩm theo kết quả tìm kiếm
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
