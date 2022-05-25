import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../validators/validate_all_streams.dart';
import '../widgets/sw_button.dart';

mixin ManageButton {
  late StreamSubscription subscriptionButton;
  late ValidateAllStreams _validateAllStreams;
  final buttonStatusCtrl = BehaviorSubject<ButtonStatus>();

  void inButtonStatus(ButtonStatus status) {
    if (!buttonStatusCtrl.isClosed) {
      buttonStatusCtrl.sink.add(status);
    }
  }

  Stream<ButtonStatus> get outButtonStatus => buttonStatusCtrl.stream;

  void initManageButton(List<Stream> streams) {
    _validateAllStreams = ValidateAllStreams()..listen(streams);
    subscriptionButton = _validateAllStreams.status.listen((event) {
      inButtonStatus(event ? ButtonStatus.active : ButtonStatus.inactive);
    });
  }

  void closeManageButton() {
    buttonStatusCtrl.close();
    _validateAllStreams.dispose();
    subscriptionButton.cancel();
  }
}
