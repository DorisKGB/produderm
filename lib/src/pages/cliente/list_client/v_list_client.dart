import 'package:flutter/material.dart';
import 'package:produderm/core/entities/cliente.dart';
import 'package:produderm/src/pages/cliente/list_client/bloc/b_list_client.dart';
import 'package:produderm/src/utils/bloc_pattern/bloc_provider.dart';
import 'package:produderm/src/utils/widgets/sw_list_view.dart';

class VListCliente extends StatefulWidget {
  const VListCliente({Key? key}) : super(key: key);

  @override
  State<VListCliente> createState() => _VListClienteState();
}

class _VListClienteState extends State<VListCliente> {
  late BListClient _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<BListClient>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: SWListView<Cliente>(
        data: _bloc.outClients,
        refresh: _bloc.getClients,
        //showDivider: true,
        scrollController: ScrollController(),
        emptyMessage: 'No hay clientes registrados',
        initialData: const [],
        currentIndex: () => 0.0,
        itemWidget: getItem,
        //getItem,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _bloc.addClient();
        },
      ),
    );
  }

  Widget getItem(Cliente cliente, int index) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(7),
      child: ListTile(
        minVerticalPadding: 12,
        //isThreeLine: true,
        title: Text(
            '${cliente.code} - ${cliente.firstName} ${cliente.lastName}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(cliente.phones!.first ?? ''),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                    '${cliente.principalAddress} - ${cliente.secondaryAddress}'),
              ],
            ),
          ],
        ),
        onTap: () {
          _bloc.viewClient(cliente);
        },
        onLongPress: () {
          _bloc.crearVisita(cliente);
        },
      ),
    );
    /*Column(
      children: [Text(cliente.firstName!)],
    );*/
  }
}
