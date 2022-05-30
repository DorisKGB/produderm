import 'package:flutter/material.dart';
import 'package:produderm/core/entities/product.dart';
import 'package:produderm/src/utils/widgets/sw_item_product.dart';

import '../../../utils/bloc_pattern/bloc_provider.dart';
import '../../../utils/widgets/sw_input.dart';
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
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SWInput(
              outData: _bloc.outQuery,
              inData: _bloc.inQuery,
              labelText: 'Buscar..',
            ),
          ),
          Expanded(
            child: SWListView<Product>(
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
          ),
        ],
      ),
    );
  }

  Widget getItem(Product product, int index) {
    return SWItemProduct(data: product, index: index);
  }
}
