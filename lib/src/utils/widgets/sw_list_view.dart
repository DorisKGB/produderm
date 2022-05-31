import 'package:flutter/material.dart';
import 'sw_button.dart';
import 'sw_button_reload.dart';

class SWListView<T> extends StatefulWidget {
  const SWListView(
      {Key? key,
      required this.data,
      this.loadMorData,
      required this.refresh,
      required this.scrollController,
      required this.itemWidget,
      required this.emptyMessage,
      this.actionEmpty,
      this.showDivider = false,
      required this.initialData,
      required this.currentIndex})
      : super(key: key);

  final Stream<Iterable<T>?> data;
  final Stream<bool>? loadMorData;
  final double Function() currentIndex;
  final Widget Function(T, int index) itemWidget;
  final Future<void> Function() refresh;
  final ScrollController scrollController;
  final String emptyMessage;
  final SWButton? actionEmpty;
  final bool showDivider;
  final Iterable<T> initialData;

  @override
  State<SWListView<T>> createState() => _SWListViewState<T>();
}

class _SWListViewState<T> extends State<SWListView<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<Iterable<T>?>(
              stream: widget.data,
              initialData: widget.initialData,
              builder:
                  (BuildContext context, AsyncSnapshot<Iterable<T>?> snapshot) {
                if (snapshot.hasError) {
                  return simpleHasError(snapshot.error.toString());
                }

                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return simpleWaiting();
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return simpleNoneData();
                }

                return RefreshIndicator(
                  onRefresh: widget.refresh,
                  child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: ScrollController(
                          initialScrollOffset: widget.currentIndex()),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        if (widget.showDivider) {
                          return const Divider(
                            color: Colors.black12,
                            thickness: 1,
                          );
                        } else {
                          return Container();
                        }
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return widget.itemWidget(
                            snapshot.data!.elementAt(index), index);
                      }),
                );
              }),
        ),
        StreamBuilder<bool>(
            stream: widget.loadMorData,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.data!) {
                return Container();
              } else {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 24,
                    width: 24,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
            })
      ],
    );
  }

  Widget simpleHasError(String error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[SWButtonReload(refresh: widget.refresh), Text(error)],
    );
  }

  Widget simpleWaiting() {
    return const Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  Widget simpleNoneData() {
    return RefreshIndicator(
        onRefresh: widget.refresh,
        child: ListView(
          children: <Widget>[
            const Icon(
              Icons.sim_card_alert_outlined,
              size: 150,
            ),
            const SizedBox(height: 16.0),
            Text(widget.emptyMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14.0)),
            const SizedBox(height: 16.0),
            if (widget.actionEmpty != null) Center(child: widget.actionEmpty!)
          ],
        ));
  }
}
