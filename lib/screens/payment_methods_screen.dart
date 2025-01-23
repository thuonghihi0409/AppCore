import 'package:appcore/screens/add_payment_methods_screen.dart';
import 'package:appcore/models/paymentmethod.dart';
import 'package:appcore/providers/payment_method_provider.dart';
import 'package:appcore/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentMethodsScreen extends StatefulWidget {
  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<PaymentMethod> paymentmethods = [];

  // Hàm để ẩn số thẻ và chỉ hiển thị 4 số cuối
  String maskCardNumber(String cardNumber) {
    return "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final paymentmethodProvider = context.read<PaymentMethodProvider>();
    paymentmethods = paymentmethodProvider.loadPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    final paymentMethodProvider = Provider.of<PaymentMethodProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: Text(
          "Payment method",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_circle_outline_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddPaymentScreen(paymentMethodProvider: paymentMethodProvider,)));
              // Thêm logic thêm thẻ mới
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: paymentmethods.length,
          itemBuilder: (context, index) {
            final method = paymentmethods[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey[850],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                title: Text(
                  maskCardNumber(method.stk!),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  DateFormat('MM/yy').format(method.dateTime),
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
                trailing: IconButton(
                  icon:
                      Icon(Icons.delete_rounded, color: Colors.white, size: 20),
                  onPressed: () {
                    _showAskDeleteDialog(context, method.id);
                    // Thêm logic xóa thẻ
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showAskDeleteDialog(BuildContext context1, String id) {
    final screen = ScreenSize(context1);
    showDialog(
      context: context1,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(25, 22, 22, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Waring",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Are you sure you want to delete this payment?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: screen.percentWidth(0.15),
                  height: screen.percentHeight(0.03),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius:
                        BorderRadius.circular(screen.percentHeight(0.01)),
                  ),
                  child: InkWell(
                    child: Center(child: Text("Oke")),
                    onTap: () {
                      final paymentMethodProvider =
                          context1.read<PaymentMethodProvider>();
                      paymentMethodProvider.deletePaymentMethod(id);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context1).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Container(
                                width: screen.percentWidth(0.04),
                                // Kích thước hình tròn
                                height: screen.percentWidth(0.04),
                                decoration: BoxDecoration(
                                  color: Colors.black, // Nền bên trong màu đen
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    // Viền ngoài màu vàng
                                    color: Colors.yellow,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check, // Biểu tượng check
                                    size: screen.percentWidth(0.02),
                                    color: Colors
                                        .yellow, // Màu vàng cho biểu tượng
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screen.percentWidth(0.04),
                              ),
                              Text("Deleted"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: screen.percentWidth(0.15),
                  height: screen.percentHeight(0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(screen.percentHeight(0.01)),
                  ),
                  child: InkWell(
                    child: Center(child: Text("Cancel")),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
