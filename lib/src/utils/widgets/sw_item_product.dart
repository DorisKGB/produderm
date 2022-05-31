import 'package:flutter/material.dart';
import 'package:produderm/core/entities/product.dart';

class SWItemProduct extends StatefulWidget {
  const SWItemProduct({
    Key? key,
    required this.data,
    required this.index,
    this.action,
  }) : super(key: key);
  final Product data;
  final int index;
  final dynamic action;
  @override
  State<SWItemProduct> createState() => _SWItemProductState();
}

class _SWItemProductState extends State<SWItemProduct> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(7),
      child: ListTile(
        minVerticalPadding: 12,
        //isThreeLine: true,
        title: Text(
            '${widget.data.code} - ${widget.data.name} ${widget.data.presentation ?? ''}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PVF: \$${widget.data.pvf}   PVP: \$${widget.data.pvp}'),
          ],
        ),
        trailing: (widget.data.isProduct == false)
            ? const Icon(
                Icons.vaccines,
                color: Colors.red,
              )
            : null,
        onTap: widget.action,
      ),
    );
  }
}
