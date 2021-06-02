import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projeto_tres/helpers/ligar_telefone.dart';
import 'package:projeto_tres/helpers/service_locator.dart';

import '../helpers/date_helper.dart';
import '../models/stuff_model.dart';

class StuffCard extends StatelessWidget {
  final StuffModel stuff;
  final Function onUpdate;
  final Function onDelete;

  const StuffCard({
    Key key,
    this.stuff,
    this.onUpdate,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.50,
      child: _buildCard(),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Excluir',
          color: Colors.red,
          icon: Icons.delete_forever,
          onTap: onDelete,
        ),
        IconSlideAction(
          caption: 'Telefonar',
          color: Colors.greenAccent,
          icon : Icons.smartphone_rounded,
          onTap: () => _tLigando(stuff.phone),
        ),
      ],
    );
  }

  _buildCard() {
    return InkWell(
      onTap: onUpdate,
      child: Container(
        child: ListTile(
          title: Text(stuff.description ?? ''),
          subtitle: Text(stuff.contactName ?? ''),
          trailing: Container(
            padding: const EdgeInsets.only(top: 8),
            height: double.infinity,
            child: Text(DateHelper.relative(stuff.date)),
          ),
          leading: CircleAvatar(
            backgroundImage:
                stuff.hasPhoto ? FileImage(File(stuff.photoPath)) : null,
            child: stuff.hasPhoto ? null : Text(stuff.description[0]),
          ),
        ),
      ),
    );
  }

  _tLigando(String number){
    final LigarTelefone _services = locator<LigarTelefone>();
    _services.call(number);
  }
}
