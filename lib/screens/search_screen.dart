import 'package:appcore/blocs/product/product_bloc.dart';
import 'package:appcore/blocs/search/search_bloc.dart';
import 'package:appcore/screens/home_screen.dart';
import 'package:appcore/utils/screen_size.dart';
import 'package:appcore/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context);
    return BlocProvider(
      create: (context) => SearchBloc()..add(SearchQueryChanged(query: "")),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: Container(
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
                      context.read<SearchBloc>().add(SearchQueryChanged(
                          query: query)); // Tìm kiếm khi người dùng nhập
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search product...',
                      hintStyle: TextStyle(color: Colors.grey),
                      //prefixIcon: Icon(Icons.search, color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      shrinkWrap: true,
                      physics:
                          NeverScrollableScrollPhysics(), // Tắt cuộn mặc định của GridView
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: state.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final item = state.filteredProducts[index];
                        return ProductCard(
                          item: item,
                          screen: screen,
                          index: index,
                        ); // Hiển thị sản phẩm theo kết quả tìm kiếm
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
