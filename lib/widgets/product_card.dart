import 'package:appcore/UI/product_detail_screen.dart';
import 'package:appcore/models/product.dart';
import 'package:appcore/providers/product_provider.dart';
import 'package:appcore/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product item;
  final ScreenSize screen;
  final int index;

  const ProductCard(
      {Key? key, required this.item, required this.screen, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    // Kiểm tra xem sản phẩm có trong danh sách yêu thích không
    bool isFavorite = productProvider.isFavorite(item.id);

    return Center(
      child: InkWell(
        child: Container(
          width: screen.percentWidth(0.3),
          height: screen.percentHeight(0.4),
          decoration: BoxDecoration(
            //color: Colors.grey[900],
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (index%2==1) ? SizedBox(height: screen.percentHeight(0.025),) :SizedBox(height: 1,),
              Container(
                width: screen.percentWidth(0.3),
                height: screen.percentHeight(0.25),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        child: Image.network(
                          width: screen.percentWidth(0.3),
                          height: screen.percentHeight(0.25),
                          item.imageUrls[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Thêm hoặc xóa sản phẩm khỏi danh sách yêu thích
                          if (isFavorite) {
                            productProvider.removeFromFavorites(item.id);
                          } else {
                            productProvider.addToFavorites(item);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '\$${item.price}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child:Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  maxLines: 2,  // Giới hạn số dòng hiển thị là 2
                  overflow: TextOverflow.fade,  // Ẩn phần văn bản thừa mà không hiển thị dấu ba chấm
                )

              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: item)));
        },
      ),
    );
  }
}
