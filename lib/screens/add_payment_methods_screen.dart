import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Thêm thư viện này để xử lý định dạng
import 'package:provider/provider.dart';
import 'package:appcore/models/paymentmethod.dart';
import 'package:appcore/providers/payment_method_provider.dart';
import 'package:appcore/utils/screen_size.dart';

class AddPaymentScreen extends StatelessWidget {
  final PaymentMethodProvider paymentMethodProvider;
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountDateController = TextEditingController();
  final TextEditingController securityCodeController = TextEditingController();

  AddPaymentScreen({super.key, required this.paymentMethodProvider});

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(''), // Để thanh AppBar trống
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Quay lại màn hình trước
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Số tài khoản
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: accountNumberController,
                decoration: InputDecoration(
                  labelText: '0000 0000 0000 0000',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 16),

            // Tháng/Năm và CVC
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: accountDateController,
                      decoration: InputDecoration(
                        labelText: 'MM/YY',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.yellow, width: 2.0),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4), // Tối đa 4 ký tự
                        _CardDateFormatter() // Custom formatter
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: securityCodeController,
                      decoration: InputDecoration(
                        labelText: 'CVC/CVV',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.yellow, width: 2.0),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      obscureText: true, // Ẩn ký tự nhập vào
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Nút "Add payment"
            Center(
              child: Container(
                width: screen.percentWidth(0.8),
                height: screen.percentWidth(0.15),
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      // Phân tích chuỗi MM/YY
                      print("=================${accountDateController.text}");
                      final dateParts = accountDateController.text
                          .split('/'); // Phân tách bằng "/"
                      if (dateParts.length != 2) throw FormatException();

                      final month = int.parse(dateParts[0]); // Lấy tháng
                      final year = int.parse(dateParts[1]); // Lấy năm
                      if (month < 1 || month > 12) throw FormatException();

                      // Tạo phương thức thanh toán
                      PaymentMethod paymentMethod = PaymentMethod(
                          id: "0${paymentMethodProvider.paymentmethods.length + 1}",
                          stk: accountNumberController.text,
                          dateTime: DateTime(year, month));
                      paymentMethodProvider.addPaymentMethod(paymentMethod);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Payment Method Added Successfully')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid Expiry Date')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  child: Text(
                    'Add payment',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

// Định dạng tháng/năm
class _CardDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // Nếu không có gì, trả về giá trị mới
    if (text.isEmpty) return newValue;

    // Đảm bảo rằng ký tự '/' luôn được giữ ở vị trí thứ 3
    if (text.length == 2 && !text.contains('/')) {
      text += '/'; // Thêm dấu "/" sau khi nhập tháng
    } else if (text.length > 2 && !text.contains('/')) {
      // Nếu người dùng nhập trực tiếp năm mà không có dấu "/"
      text = text.substring(0, 2) + '/' + text.substring(2);
    }

    // Giới hạn độ dài của chuỗi chỉ tối đa là 5 ký tự (MM/YY)
    if (text.length > 5) {
      text = oldValue.text; // Giữ nguyên giá trị cũ
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
