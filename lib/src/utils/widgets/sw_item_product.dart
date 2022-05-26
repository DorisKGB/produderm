import 'package:flutter/material.dart';

import '../../../core/entities/product.dart';

class SWItemProduct extends StatefulWidget {
  const SWItemProduct({Key? key, required this.product, required this.index})
      : super(key: key);
  final Product product;
  final int index;
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
            '${widget.product.code} - ${widget.product.name} ${widget.product.presentation ?? ''}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle:
            Text('PVF: \$${widget.product.pvf}   PVP: \$${widget.product.pvp}'),
        trailing: (widget.product.isProduct == false)
            ? const Icon(
                Icons.vaccines,
                color: Colors.red,
              )
            : null,
      ),
    );
    ;
  }
}
