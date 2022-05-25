import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../models/m_action_view.dart';

mixin MixActionViewStream {
  final viewCtrl = PublishSubject<MActionView>();

  void inView(MActionView actionView) {
    if (!viewCtrl.isClosed) {
      viewCtrl.sink.add(actionView);
    }
  }

  Stream<MActionView> get outView => viewCtrl.stream;

  StreamSubscription? listenView;

  void initActionView({dynamic context}) {
    listenView = outView.listen((event) {
      event.execute(context: context);
    });
  }

  void closeDataView() {
    viewCtrl.close();
    listenView?.cancel();
  }
}
