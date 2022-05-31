import 'package:flutter/material.dart';
import 'package:produderm/core/entities/admin.dart';

import '../../utils/bloc_pattern/bloc_provider.dart';
import '../../utils/widgets/sw_button.dart';
import 'bloc/b_admin.dart';

class VAdmin extends StatefulWidget {
  const VAdmin({Key? key}) : super(key: key);

  @override
  State<VAdmin> createState() => _VAdminState();
}

class _VAdminState extends State<VAdmin>  with AutomaticKeepAliveClientMixin{
  late BAdmin _bloc;

  @override
  void initState() {
    super.initState();
    // Busca en el arbol al BLogin para acceder a las propiedades de Blogin
    _bloc = BlocProvider.of<BAdmin>(context);
    _bloc.initActionView(context: context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      elevation: 12,
      margin: const EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 100),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            StreamBuilder<Admin>(
                stream: _bloc.outAdmin,
                initialData: _bloc.admin,
                builder: (context, snapshot) {
                  return Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 70,
                      ),
                      const SizedBox(height: 20),
                      itemAdmin('Usuario', snapshot.data?.userName,
                          Icons.account_circle),
                      const SizedBox(height: 12),
                      itemAdmin('Nombre', snapshot.data?.name, Icons.badge),
                      const SizedBox(height: 12),
                      itemAdmin('Correo electrónico', snapshot.data?.email,
                          Icons.email),
                      const SizedBox(height: 12),
                      itemAdmin('Rol', snapshot.data?.role,
                          Icons.admin_panel_settings),
                      const SizedBox(height: 12),
                      SWButton.elevated(
                        onPressed: _bloc.closeSesion,
                        child: const Text('Cerrar Sesion'),
                      ),
                    ],
                  );
                }),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Power by DARHU',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.6)
                          //fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemAdmin(String titulo, String? subtitulo, IconData icono) {
    return Row(
      children: [
        Icon(icono, color: Colors.grey),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(subtitulo ?? '')
          ],
        ),
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
