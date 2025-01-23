import 'package:appcore/blocs/product/product_bloc.dart';
import 'package:appcore/models/product.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:appcore/utils/screen_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool? isFavorite;
  PageController? _pageController;
  int _currentPage = 0;
  String? selectedSize;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    isFavorite = context
        .read<ProductBloc>()
        .state
        .favoriteProducts
        .contains(widget.product.id);
  }

  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context);
    // final productProvider = Provider.of<ProductProvider>(context);
    // bool isFavorite = productProvider.isFavorite(widget.product.id);
    //PageController _pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Heart Icon
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: screen.percentHeight(0.4),
                  width: screen.percentWidth(0.5),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.product.imageUrls
                              .length, // Giả sử bạn chỉ có 1 ảnh cho mỗi phòng
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                              print(
                                  "==================================${_currentPage.toDouble()}");
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.product.imageUrls[
                                  index], // URL hình ảnh từ rentalProperty
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                    child: Text('Failed to load image'));
                              },
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: IconButton(
                          icon: Icon(
                            isFavorite!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (isFavorite!) {
                              context.read<ProductBloc>().add(
                                  UnFavariteProduct(id: widget.product.id));
                            } else {
                              context
                                  .read<ProductBloc>()
                                  .add(FavariteProduct(id: widget.product.id));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
                child: DotsIndicator(
              dotsCount: widget.product.imageUrls.length,
              position: _currentPage.toDouble(), // Sử dụng giá trị _currentPage
              decorator: DotsDecorator(
                activeColor: Colors.white,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            )),
            // Price and Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.product.price}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${widget.product.title}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Size Options
                  Row(
                    children: ['S', 'M', 'L'].map((size) {
                      bool isSelected =
                          selectedSize == size; // Kiểm tra size được chọn
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size; // Cập nhật size được chọn
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black, // Nền trắng nếu được chọn
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.white, // Viền đen nếu được chọn
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.white, // Chữ đen nếu được chọn
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  // Description
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 32),
                  // Checkout Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _showThankYouDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 100,
                        ),
                      ),
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(25, 22, 22, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80, // Kích thước hình tròn
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black, // Nền bên trong màu đen
                  shape: BoxShape.circle,
                  border: Border.all(
                    // Viền ngoài màu vàng
                    color: Colors.yellow,
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.check, // Biểu tượng check
                    size: 40,
                    color: Colors.yellow, // Màu vàng cho biểu tượng
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Thanks for your order',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'We will deliver it to you soon',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
