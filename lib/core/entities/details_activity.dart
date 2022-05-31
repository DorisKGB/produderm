import 'package:produderm/core/entities/product.dart';

class DetailsVisit {
  String? id;
  Product? product;
  int? quantity;
  String? promotion;

  double getTotalSales(){
    if( quantity != null){
      return (product!.pvf! * quantity!);
    }
    return 0.0;
  }
}
