import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:produderm/application/repository/r_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:produderm/core/entities/cliente.dart';
import 'package:produderm/src/bloc_application/b_application.dart';
import 'package:produderm/src/utils/bloc_pattern/bloc_base.dart';

import '../../../../router/pages.dart';

class BListClient implements BlocBase {
  BListClient(this._bApplication, this._rClient) {
    getClients();
  }
  final BApplication _bApplication;
  final RClient _rClient;
  final BehaviorSubject<List<Cliente>> _clients =
      BehaviorSubject<List<Cliente>>(); // Se crea el stream
  Stream<List<Cliente>> get outClients => _clients.stream; // salida
  Function(List<Cliente>) get inClients => _clients.sink.add;

  Future<void> getClients() async {
    try {
      List<Cliente> clientes = await _rClient.listClient();
      if (!_clients.isClosed) {
        inClients(clientes);
      }
    } catch (e, st) {
      _clients.addError(e.toString());
    }
  }

  void addClient() {
    navigator.push(Pages.createCliente.getPath());
  }

  @override
  void dispose() {
    _clients.close();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
