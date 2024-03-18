import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventas_facil/models/venta/persona_contacto.dart';
import 'package:ventas_facil/models/venta/socio_negocio.dart';
import 'package:ventas_facil/ui/widgets/app_bar_widget.dart';

class PersonaContactoPage extends StatefulWidget {
  final SocioNegocio socioNegocio;
  const PersonaContactoPage({super.key, required this.socioNegocio });

  @override
  State<PersonaContactoPage> createState() => _PersonaContactoPageState();
}

class _PersonaContactoPageState extends State<PersonaContactoPage> {
  PersonaContacto contactoSeleccionado = PersonaContacto();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'Socios de Negocio'),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     GoRouter.of(context).pop(contactoSeleccionado);
      //   }, 
      //   label: const Text('Seleccionar'),
      //   icon: const Icon(Icons.check),
      // ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          PersonaContacto contacto = widget.socioNegocio.contactosEmpleado![index];
          bool isSelected = widget.socioNegocio.personaContacto == contacto.nombreCliente;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.surface,
              // backgroundColor: isSelected ? Colors.green : Colors.yellowAccent,
              child: isSelected 
                ? const Icon(Icons.check) 
                : const Icon(Icons.info_outline),
            ),
            selected: isSelected,
            title: Text(contacto.nombreContacto!),
            onTap: () {
              contactoSeleccionado = contacto;
              isSelected = true;
              setState(() {});
              GoRouter.of(context).pop(contacto);
            },
            trailing: const Icon(Icons.touch_app),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: widget.socioNegocio.contactosEmpleado!.length,
      ),
    );
  }
}