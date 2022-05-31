import 'package:flutter/material.dart';
import 'package:produderm/core/entities/visit.dart';
import 'package:produderm/src/pages/visit/list_visit/bloc/b_list_visit.dart';

import '../../../utils/bloc_pattern/bloc_provider.dart';
import '../../../utils/widgets/sw_input.dart';
import '../../../utils/widgets/sw_list_view.dart';

class VListVisit extends StatefulWidget {
  const VListVisit({Key? key}) : super(key: key);

  @override
  State<VListVisit> createState() => _VListVisitState();
}

class _VListVisitState extends State<VListVisit> with AutomaticKeepAliveClientMixin {
  late BListVisit _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<BListVisit>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitas'),
        actions: [
          IconButton(onPressed: _selectDate, icon: const Icon(Icons.date_range))
        ],
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
            child: SWListView<Visit>(
              data: _bloc.outVisits,
              refresh: () => _bloc.getVisits(_bloc.date),
              //showDivider: true,
              scrollController: ScrollController(),
              emptyMessage: 'No hay visitas registradas registrados',
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

  Widget getItem(Visit visit, int index) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(7),
      child: ListTile(
          minVerticalPadding: 12,
          //isThreeLine: true,
          title: Text(
              '${visit.cliente?.firstName} ${visit.cliente?.lastName ?? ''}',
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${visit.comment}'),
              Text('Productos Entregados: ${(visit.details?.length)}'),
            ],
          ),
          trailing: Text(_bloc.dateFormat.format(_bloc.date)),
          onTap: () => {_bloc.viewVisit(visit)}),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _bloc.date,
      firstDate: _bloc.firstDate,
      lastDate: DateTime.now(),
      fieldLabelText: 'Fecha de visita',
    );
    if (picked != null) {
      _bloc.filterByDate(picked);
    }
  }
  
  @override
  bool get wantKeepAlive => true;
}
