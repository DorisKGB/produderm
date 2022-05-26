import 'package:flutter/material.dart';
import 'package:produderm/src/utils/widgets/sw_input.dart';

import '../../../../core/entities/product.dart';
import '../../../utils/bloc_pattern/bloc_provider.dart';
import '../../../utils/widgets/sw_button.dart';
import '../../../utils/widgets/sw_list_view.dart';
import 'bloc/b_create_visit.dart';

class VCreateVisit extends StatefulWidget {
  const VCreateVisit({Key? key}) : super(key: key);

  @override
  State<VCreateVisit> createState() => _VCreateVisitState();
}

class _VCreateVisitState extends State<VCreateVisit> {
  late BCreateVisit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<BCreateVisit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.shopping_cart)),
              Tab(icon: Icon(Icons.medical_services)),
            ],
          ),
          title: const Text('Registro actividad'),
        ),
        body: TabBarView(
          children: [
            registrarVisita(),
            registrerProducts(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _bloc.addProduct();
          },
        ),
      ),
    );

    /*Scaffold(
      appBar: AppBar(title: Text('Registro actividad')),
      body: registrarVisita(),
    );*/
  }

  Widget registrarVisita() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const SizedBox(height: 16),
          SWInput(
            outData: _bloc.outDate,
            inData: _bloc.inDate,
            labelText: 'Fecha',
            textInputType: TextInputType.datetime,
            isEnable: false,
          ),
          const SizedBox(height: 16),
          SWInput(
            outData: _bloc.outTotalCharge,
            inData: _bloc.inTotalCharge,
            labelText: 'Nombre',
            textInputType: TextInputType.name,
            isEnable: false,
          ),
          const SizedBox(height: 16),
          SWInput(
            outData: _bloc.outTotalCharge,
            inData: _bloc.inTotalCharge,
            labelText: 'Total Cobro',
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          SWInput(
            outData: _bloc.outTotalSales,
            inData: _bloc.inTotalSales,
            labelText: 'Total Ventas',
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          SWInput(
            outData: _bloc.outCommentary,
            inData: _bloc.inCommentary,
            labelText: 'Comentarios',
            textInputType: TextInputType.name,
          ),
        ],
      ),
    );
  }

  Widget registrerProducts() {
    return SWListView<Product>(
      data: _bloc.outProducts,
      refresh: _bloc.getProducts,
      //showDivider: true,
      scrollController: ScrollController(),
      emptyMessage: 'No hay productos registrados',
      initialData: const [],
      currentIndex: () => 0.0,
      itemWidget: getItem,
      //getItem,
    );
  }

  Widget getItem(Product product, int index) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(7),
      child: ListTile(
        minVerticalPadding: 12,
        //isThreeLine: true,
        title: Text(
            '${product.code} - ${product.name} ${product.presentation ?? ''}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: [
            Expanded(
              child: Text('PVF: \$${product.pvf}   PVP: \$${product.pvp}'),
              flex: 4,
            ),
            Expanded(
              child: SizedBox(
                height: 30,
                child: SWInput(
                  outData: _bloc.outNumProduct,
                  inData: _bloc.inNumProduct,
                  labelText: '',
                ),
              ),
              flex: 1,
            )
          ],
        ),
        /*trailing: Column(
            children: [
              (product.isProduct == false)
                  ? const Icon(
                      Icons.vaccines,
                      color: Colors.red,
                    )
                  : const Text(''),
            ],
          ),*/
      ),
    );
  }
}
