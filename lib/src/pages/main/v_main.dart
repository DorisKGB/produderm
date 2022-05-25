import 'package:flutter/material.dart';
import 'package:produderm/src/pages/main/bloc/b_main.dart';
import 'package:produderm/src/utils/bloc_pattern/bloc_provider.dart';

import '../admin/bloc/p_admin.dart';
import '../cliente/list_client/bloc/p_list_client.dart';
import '../producto/list_product/bloc/p_list_product.dart';
import '../visit/list_visit/bloc/p_list_visit.dart';

class VMain extends StatefulWidget {
  const VMain({Key? key}) : super(key: key);

  @override
  State<VMain> createState() => _VMainState();
}

class _VMainState extends State<VMain> {
  late List<Widget> _myPages;
  late BMain _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<BMain>(context);
    _myPages = <Widget>[
      PListCliente(
        bApplication: _bloc.bApplication,
        rClient: _bloc.rClient,
      ),
      PListProduct(
        bApplication: _bloc.bApplication,
        rProduct: _bloc.rProduct,
      ),
      PListVisit(bApplication: _bloc.bApplication, rVisit: _bloc.rVisit),
      PAdmin(
        bApplication: _bloc.bApplication,
        rUserLocal: _bloc.rUserLocal,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _bloc.outSelectedIndex, //la salida
        initialData: _bloc.selectedIndex,
        //snapshot ontiene toda la inforaci9on e la tuberia junto con los datos
        builder: (context, AsyncSnapshot<int> snapshot) {
          return Scaffold(
            body: _myPages[snapshot.data!],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: snapshot.data!,
                onTap: _bloc.onItemTapped,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.domain),
                    label: 'Clientes',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.medication),
                    label: 'Productos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Visitas',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Admin',
                  ),
                ]),
          );
        });
  }
}
