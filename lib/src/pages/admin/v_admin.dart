import 'package:flutter/material.dart';

import '../../utils/bloc_pattern/bloc_provider.dart';
import '../../utils/widgets/sw_button.dart';
import 'bloc/b_admin.dart';

class VAdmin extends StatefulWidget {
  VAdmin({Key? key}) : super(key: key);

  @override
  State<VAdmin> createState() => _VAdminState();
}

class _VAdminState extends State<VAdmin> {
  late BAdmin _bloc;

  @override
  void initState() {
    super.initState();
    // Busca en el arbol al BLogin para acceder a las propiedades de Blogin
    _bloc = BlocProvider.of<BAdmin>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: const EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 100),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            itemAdmin('Usuario', 'cmino', Icons.account_circle),
            const SizedBox(height: 12),
            itemAdmin('Nombre', 'Cristian Miño', Icons.badge),
            const SizedBox(height: 12),
            itemAdmin(
                'Correo electrónico', 'cristian.mino@iclound.com', Icons.email),
            const SizedBox(height: 12),
            itemAdmin('Rol', 'Admin', Icons.admin_panel_settings),
            const SizedBox(height: 12),
            SWButton.elevated(
              onPressed: _bloc.closeSesion,
              child: const Text('Cerrar Sesion'),
            )
          ],
        ),
      ),
    );
  }

  Widget itemAdmin(String titulo, String subtitulo, IconData icono) {
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
            Text(subtitulo)
          ],
        ),
      ],
    );
  }
}
