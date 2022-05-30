import 'dart:async';

import 'package:rxdart/rxdart.dart';

mixin MixSearch {
  final BehaviorSubject<String> _query =
      BehaviorSubject<String>(); // Se crea el stream
  Stream<String> get outQuery => _query.stream; // salida
  Function(String) get inQuery => _query.sink.add;
  StreamSubscription? _listenQuery;

  void initSearch(Function(String) search) {
    _listenQuery = outQuery.listen((queryVar) {
      search(queryVar);
    });
  }

  void disposeSearch() {
    _listenQuery?.cancel();
    _query.close();
  }
}
