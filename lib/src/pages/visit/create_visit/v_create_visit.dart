import 'package:flutter/material.dart';
import 'package:produderm/src/utils/widgets/sw_button.dart';
import 'package:produderm/src/utils/widgets/sw_input.dart';

import '../../../../core/entities/details_activity.dart';
import '../../../utils/bloc_pattern/bloc_provider.dart';
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
    _bloc.initActionView(context: context);
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
          title: Text('${_bloc.nameLabel} visita'),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  registrarVisita(),
                  registrerProducts(),
                ],
              ),
            ),
            SWButton.elevated(
              streamStatus: _bloc.outButtonStatus,
              onPressed: _bloc.createDeleteVisit,
              child: Text('${_bloc.nameLabel} visita'),
            )
          ],
        ),
      ),
    );
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
            outData: _bloc.outNombre,
            inData: _bloc.inNombre,
            labelText: 'Nombre',
            textInputType: TextInputType.name,
            isEnable: false,
          ),
          const SizedBox(height: 16),
          SWInput(
            outData: _bloc.outTotalCharge,
            inData: _bloc.inTotalCharge,
            labelText: 'Total Cobro  (opcional)',
            textInputType: TextInputType.number,
            isEnable: _bloc.idIsNull(),
          ),
          const SizedBox(height: 16),
          SWInput(
            outData: _bloc.outTotalSales,
            inData: _bloc.inTotalSales,
            labelText: 'Total Ventas  (opcional)',
            textInputType: TextInputType.number,
            isEnable: _bloc.idIsNull(),
          ),
          const SizedBox(height: 16),
          SWInput(
            outData: _bloc.outCommentary,
            inData: _bloc.inCommentary,
            labelText: 'Comentarios  (opcional)',
            textInputType: TextInputType.name,
            isEnable: _bloc.idIsNull(),
          ),
        ],
      ),
    );
  }

  Widget registrerProducts() {
    return Scaffold(
      body: SWListView<DetailsVisit>(
        data: _bloc.outDetailVisit,
        refresh: () async => {},
        //showDivider: true,
        scrollController: ScrollController(),
        emptyMessage: 'No hay productos ingresadaos',
        initialData: const [],
        currentIndex: () => 0.0,
        itemWidget: getItem,
        //getItem,
      ),
      floatingActionButton: _bloc.idIsNull() ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _bloc.addProduct();
        },
      ) : null,
    );
  }

  Widget getItem(DetailsVisit detailVisit, int index) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(7),
      child: Column(
        children: [
          ListTile(
            minVerticalPadding: 12,
            //isThreeLine: true,
            title: Text('${detailVisit.product?.name}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            subtitle: Text('Cantidad: ${detailVisit.quantity}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (_bloc.idIsNull()) _bloc.removeDetailVisit(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
