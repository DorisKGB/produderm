import 'package:flutter/material.dart';
import 'package:produderm/core/entities/product.dart';
import 'package:produderm/src/utils/widgets/sw_input.dart';
import 'package:produderm/src/utils/widgets/sw_item_product.dart';

import '../../../utils/bloc_pattern/bloc_provider.dart';
import '../../../utils/widgets/sw_list_view.dart';
import 'bloc/b_select_product.dart';

class VSelectProduct extends StatefulWidget {
  const VSelectProduct({Key? key}) : super(key: key);

  @override
  State<VSelectProduct> createState() => _VSelectProductState();
}

class _VSelectProductState extends State<VSelectProduct> {
  late BSelectProduct _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<BSelectProduct>(context);
    _bloc.initActionView(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccinar Productos'),
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
              scrollController: ScrollController(),
              emptyMessage: 'No hay productos registrados',
              initialData: const [],
              currentIndex: () => 0.0,
              itemWidget: getItem,
            ),
          ),
        ],
      ),
    );
  }

  Widget getItem(Product product, int index) {
    return SWItemProduct(
      data: product,
      index: index,
      action: () async {
        bool? result = await viewDialog(product);
        //para que no guarde nada cuando presione cancelar
        if (result != null) _bloc.addDetailVisit(product, result);
      },
    );
  }

  Future<bool?> viewDialog(Product product) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('${product.name}'),
        content: SWInput(
            inData: _bloc.inNumProduct,
            outData: _bloc.outNumProduct,
            labelText: 'Ingrese cantidad',
            textInputType: TextInputType.number),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              if (_bloc.validateInput()) Navigator.pop(context, false),
            },
            child: const Text('Agregar mas....'),
          ),
          TextButton(
            onPressed: () => {
              if (_bloc.validateInput()) Navigator.pop(context, true),
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
