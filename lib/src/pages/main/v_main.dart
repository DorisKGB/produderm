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

class _VMainState extends State<VMain>  with AutomaticKeepAliveClientMixin<VMain> {
  late List<Widget> _myPages;
  late BMain _bloc;
  late PageController _pageController;
  late int _selectedIndex;

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
        rAdmin: _bloc.rAdmin,
      )
    ];
    _selectedIndex=0;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<int>(
        stream: _bloc.outSelectedIndex, //la salida
        initialData: _bloc.selectedIndex,
        //snapshot ontiene toda la inforaci9on e la tuberia junto con los datos
        builder: (context, AsyncSnapshot<int> snapshot) {
          return Scaffold(
            body: PageView(
              controller: _pageController,
              physics: const  NeverScrollableScrollPhysics(),
              children: _myPages,
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: snapshot.data!,
                onTap: (int index){
                  _pageController.jumpToPage(index);
                  _bloc.onItemTapped(index);                  
                },
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
  
  @override
  bool get wantKeepAlive => true;
}
