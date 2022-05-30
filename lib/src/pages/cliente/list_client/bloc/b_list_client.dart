import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:produderm/application/repository/r_client.dart';
import 'package:produderm/core/entities/visit.dart';
import 'package:rxdart/rxdart.dart';
import 'package:produderm/core/entities/cliente.dart';
import 'package:produderm/src/bloc_application/b_application.dart';
import 'package:produderm/src/utils/bloc_pattern/bloc_base.dart';

import '../../../../router/pages.dart';
import '../../../../utils/mixin/search_mixin.dart';

class BListClient with MixSearch implements BlocBase {
  BListClient(this._bApplication, this._rClient) {
    getClients();

    initSearch(searchClient);
  }

  List<Cliente>? listOld = [];
  final BApplication _bApplication;
  final RClient _rClient;
  final BehaviorSubject<List<Cliente>> _clients =
      BehaviorSubject<List<Cliente>>(); // Se crea el stream
  Stream<List<Cliente>> get outClients => _clients.stream;
  Function(List<Cliente>) get inClients => _clients.sink.add;
  List<Cliente> get clientList => _clients.valueOrNull ?? [];

  void searchClient(String queryVar) {
    List<Cliente> lista = listOld!.where((element) {
      if (element.firstName != null) {
        return element.firstName!
            .toLowerCase()
            .contains(queryVar.toLowerCase());
      } else {
        return false;
      }
    }).toList();
    inClients(lista);
  }

  Future<void> getClients() async {
    try {
      List<Cliente> clientes = await _rClient.listClient();
      if (!_clients.isClosed) {
        listOld = clientes;
        inClients(clientes);
      }
    } catch (e, st) {
      _clients.addError(e.toString());
    }
  }

  //Agrega un cliente a la lista de cliente ya existentes
  Future<void> addClienteList(Cliente addClient) async {
    try {
      if (clientList.isEmpty) {
        inClients([addClient]);
      } else {
        inClients((clientList..add(addClient)));
      }
    } catch (e, st) {
      _clients.addError(e.toString());
    }
  }

  //Direcciona la a la vista de crear cliente
  void addClient() {
    navigator.push(Pages.createCliente.getPath(), extra: {'bloc': this});
  }

  //Enviaa la informacion del cliente para actualizar la informacion
  void viewClient(Cliente cliente) {
    navigator.push(Pages.createCliente.getPath(),
        extra: {'client': cliente, 'bloc': this});
  }

  //Si tienen pulsacion larga en la lista direcciona a la vista de crear visita
  crearVisita(Cliente cliente) {
    Visit visit = Visit();
    visit.cliente = cliente;
    navigator.push(Pages.createVisit.getPath(), extra: {'visit': visit});
    //navigator.push(Pages.createVisit.getPath());
  }

  @override
  void dispose() {
    _clients.close();
    disposeSearch();
  }

  @override
  GoRouter get navigator => _bApplication.navigator;

  @override
  AppLocalizations get translate => _bApplication.translate;
}
