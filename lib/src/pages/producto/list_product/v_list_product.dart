import 'package:flutter/material.dart';
import 'package:produderm/core/entities/product.dart';
import 'package:produderm/src/utils/widgets/sw_item_product.dart';

import '../../../utils/bloc_pattern/bloc_provider.dart';
import '../../../utils/widgets/sw_list_view.dart';
import 'bloc/b_list_product.dart';

class VListProduct extends StatefulWidget {
  const VListProduct({Key? key}) : super(key: key);

  @override
  State<VListProduct> createState() => _VListProductState();
}

class _VListProductState extends State<VListProduct> {
  late BListProduct _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<BListProduct>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: SWListView<Product>(
        data: _bloc.outProducts,
        refresh: _bloc.getProducts,
        //showDivider: true,
        scrollController: ScrollController(),
        emptyMessage: 'No hay productos registrados',
        initialData: const [],
        currentIndex: () => 0.0,
        itemWidget: getItem,
        //getItem,
      ),
    );
  }

  Widget getItem(Product product, int index) {
    return SWItemProduct(product: product, index: index);

    /*Card(
      elevation: 3,
      margin: const EdgeInsets.all(7),
      child: ListTile(
        minVerticalPadding: 12,
        //isThreeLine: true,
        title: Text(
            '${product.code} - ${product.name} ${product.presentation ?? ''}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text('PVF: \$${product.pvf}   PVP: \$${product.pvp}'),
        trailing: (product.isProduct == false)
            ? const Icon(
                Icons.vaccines,
                color: Colors.red,
              )
            : null,
      ),
    );*/
  }
}
