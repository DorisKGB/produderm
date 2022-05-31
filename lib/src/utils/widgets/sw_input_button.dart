import 'package:flutter/material.dart';

class SWInputButton<T> extends StatelessWidget {
  final Stream<T> outData;
  final String hint;
  final dynamic action;
  final IconData? icon;
  const SWInputButton(
      {Key? key, required this.outData, required this.hint, this.action, this.icon = Icons.arrow_drop_down})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: outData,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _getInputButton(error: snapshot.error.toString());
        }
        if (snapshot.hasData) {
          return _getInputButton(
              texto: snapshot.data.toString(), hasdata: true);
        } else {
          return _getInputButton(texto: hint);
        }
      },
    );
  }

  Widget _getInputButton({String? texto, bool hasdata = false, String? error}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
            onPressed: () => action(),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 19, horizontal: 8)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: (error != null && error.isNotEmpty)
                              ? Colors.red.shade700
                              : Colors.black38,
                          width: (error != null && error.isNotEmpty) ? 2 : 1))),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child:
                      Text(hasdata ? texto! : hint, style: getStyle(hasdata)),
                )),
                Icon(icon, color: Colors.grey)
              ],
            )),
        if (error != null && error.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(error,
                style: TextStyle(fontSize: 12, color: Colors.red.shade700)),
          )
      ],
    );
  }

  getStyle(bool hasdata) {
    if (hasdata) {
      return const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal);
    } else {
      return const TextStyle(
          fontSize: 18, color: Colors.black54, fontWeight: FontWeight.normal);
    }
  }
}
