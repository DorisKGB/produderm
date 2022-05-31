import 'package:flutter/material.dart';
import 'package:produderm/core/entities/speciality.dart';
import 'package:produderm/src/pages/cliente/create/bloc/b_create_cliente.dart';
import 'package:produderm/src/utils/bloc_pattern/bloc_provider.dart';
import 'package:produderm/src/utils/widgets/sw_input.dart';

import '../../../../core/catalog/enum/c_cliente_type.dart';
import '../../../../core/catalog/enum/c_pharmacy_type.dart';
import '../../../utils/widgets/sw_button.dart';
import '../../../utils/widgets/sw_input_button.dart';

class VCreateClente extends StatefulWidget {
  const VCreateClente({Key? key}) : super(key: key);

  @override
  State<VCreateClente> createState() => _VCreateClenteState();
}

class _VCreateClenteState extends State<VCreateClente> {
  late BCreateCliente _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<BCreateCliente>(context);
    _bloc.initActionView(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _bloc.idIsNull()
              ? const Text('Crear Cliente')
              : const Text('Actualizar Cliente'),
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          //margin: EdgeInsets.all(8.0),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              SWInput(
                outData: _bloc.outCodigo,
                inData: _bloc.inCodigo,
                labelText: 'Codigo',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              SWInput(
                outData: _bloc.outRepresentante,
                inData: _bloc.inRepresentante,
                labelText: 'Farmacia (opcional)',
              ),
              const SizedBox(height: 16),
              SWInput(
                outData: _bloc.outNombre,
                inData: _bloc.inNombre,
                labelText: 'Nombres',
              ),
              const SizedBox(height: 16),
              SWInput(
                outData: _bloc.outApellido,
                inData: _bloc.inApellido,
                labelText: 'Apellidos (opcional)',
              ),
              const SizedBox(height: 16),
              SWInput(
                outData: _bloc.outCallePrincipal,
                inData: _bloc.inCallePrincipal,
                labelText: 'Calle principal',
              ),
              const SizedBox(height: 16),
              SWInput(
                outData: _bloc.outCalleSecundaria,
                inData: _bloc.inCalleSecundaria,
                labelText: 'Calle secundaria',
              ),
              const SizedBox(height: 16),
              SWInput(
                outData: _bloc.outEmail,
                inData: _bloc.inEmail,
                labelText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              SWInput(
                outData: _bloc.outTelefono,
                inData: _bloc.inTelefono,
                labelText: 'Teléfono',
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              SWInputButton<String>(
                outData: _bloc.outBirthdayDate
                    .map((e) => _bloc.dateFormat.format(e)),
                hint: "Fecha de cumpleaños",
                action: _selectDate,
                icon: Icons.date_range,
              ),
              const SizedBox(height: 16),
              Row(
                children: CTypeClient.values
                    .map((e) => Expanded(child: getSWRadioBtn(e)))
                    .toList(),
              ),
              StreamBuilder<CTypeClient>(
                  stream: _bloc.outClientType,
                  initialData: _bloc.clientType,
                  builder: (context, snapshot) {
                    if (snapshot.data == CTypeClient.farmacia) {
                      return Row(
                        children: CPharmacyType.values
                            .map((e) => Expanded(child: getSWRadioBtn2(e)))
                            .toList(),
                      );
                    } else {
                       return  SWInputButton<String>(
                        outData: _bloc.outSpeciality.map((event) => event.name??''),
                        hint: 'Especialidad',
                        action: onSelectSpeciality,
                      );
                    }
                  }),
              const SizedBox(height: 16),
              SWButton.elevated(
                onPressed: _bloc.guardarCliente,
                streamStatus: _bloc.outButtonStatus,
                child: _bloc.idIsNull()
                    ? const Text('Crear Cliente')
                    : const Text('Actualizar Cliente'),
              ),
            ],
          ),
        ));
  }

  Widget getSWRadioBtn(CTypeClient cTypeClient) {
    return StreamBuilder<CTypeClient>(
        stream: _bloc.outClientType, //salida
        initialData: _bloc.clientType,
        builder: (context, snapshot) {
          return ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              cTypeClient.getLabel(),
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis
            ),
            leading: Radio<CTypeClient>(
              value: cTypeClient,
              groupValue: snapshot.data,
              onChanged: (CTypeClient? value) {
                _bloc.inClientType(value!);
              },
            ),
          );
        });
  }

  Widget getSWRadioBtn2(CPharmacyType pharmacyType) {
    return StreamBuilder<CPharmacyType>(
        stream: _bloc.outPharmacyType, //salida
        initialData: _bloc.pharmacyType,
        builder: (context, snapshot) {
          return ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(pharmacyType.getLabel(),
                style: const TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis),
            leading: Radio<CPharmacyType>(
              value: pharmacyType,
              groupValue: snapshot.data,
              onChanged: (CPharmacyType? value) {
                _bloc.inPharmacyType(value!);
              },
            ),
          );
        });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _bloc.initialDate,
      firstDate: _bloc.firstDate,
      lastDate: _bloc.lastDate,
      fieldLabelText: 'Fecha de cumpleaños',
    );
    if (picked != null && picked != _bloc.selectedDate) {
      _bloc.inBirthdayDate(picked); // = picked;
    }
  }

  void onSelectSpeciality() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder<List<Speciality>>(
            initialData: const [],
            stream: _bloc.outSpecialities,
            builder: (context, snapshot) {
              return SimpleDialog(
                title: const Text('Selecione una especialidad'),
                children: snapshot.data!
                    .map<Widget>((Speciality item) => TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(vertical: 16))),
                        onPressed: () {
                          _bloc.inSpeciality(item);
                          Navigator.pop(context);
                        },
                        child: Text(
                          item.name?? '',
                        )))
                    .toList(),
              );
            }
          );
        });
  }
}
