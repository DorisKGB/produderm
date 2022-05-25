import 'package:flutter/material.dart';
import '../../utils/bloc_pattern/bloc_provider.dart';
import '../../utils/widgets/sw_button.dart';
import '../../utils/widgets/sw_input.dart';
import 'bloc/b_login.dart';

class VLogin extends StatefulWidget {
  const VLogin({Key? key}) : super(key: key);

  @override
  State<VLogin> createState() {
    return _VLoginState();
  }
}

class _VLoginState extends State<VLogin> {
  late BLogin _bloc;

  @override
  void initState() {
    super.initState();
    // Busca en el arbol al BLogin para acceder a las propiedades de Blogin
    _bloc = BlocProvider.of<BLogin>(context);
    // mostrar el cargando
    _bloc.initActionView(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Ingrese Usuario y contraseña'),
          const SizedBox(height: 8),
          SWInput(
            outData: _bloc.outUser,
            inData: _bloc.inUser,
            labelText: 'Usuario',
          ),
          const SizedBox(height: 8),
          SWInput(
            outData: _bloc.outContrasena,
            inData: _bloc.inContrasena,
            labelText: 'Contraseña',
            obscureText: true,
          ),
          const SizedBox(height: 8),
          SWButton.elevated(
            onPressed: _bloc.login,
            streamStatus: _bloc.outButtonStatus,
            child: const Text('Iniciar Sesion'),
          )
        ],
      ),
    ));
  }
}
