import 'package:flutter/material.dart';

class SWButtonReload extends StatelessWidget {
  const SWButtonReload(
      {Key? key,
      required this.refresh,
      this.size = 24,
      this.color = Colors.black54,
      this.iconData = Icons.refresh})
      : super(key: key);

  final Function() refresh;
  final double size;
  final Color color;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.black26)),
          child: IconButton(
              icon: Icon(iconData, size: size, color: color),
              onPressed: refresh),
        ),
      ),
    );
  }
}
