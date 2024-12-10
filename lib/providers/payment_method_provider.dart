

import 'package:appcore/models/paymentmethod.dart';
import 'package:appcore/utils/data.dart';
import 'package:flutter/foundation.dart';

class PaymentMethodProvider with ChangeNotifier{
  List<PaymentMethod> paymentmethods= [];

  List<PaymentMethod> loadPaymentMethods (){
    paymentmethods= pamentmethod_data;
    return paymentmethods;
  }
  void deletePaymentMethod (String id){
    paymentmethods.removeWhere((test)=> test.id==id);
    notifyListeners();
  }

  void addPaymentMethod (PaymentMethod paymentmethod){
    paymentmethods.add(paymentmethod);
    notifyListeners();
  }
}