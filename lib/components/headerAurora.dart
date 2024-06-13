import 'package:aurora/modals/update_user_modal.dart';
import 'package:flutter/material.dart';

AppBar headerAurora(BuildContext context) {
  return AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 25.0),
          child: SizedBox(
            child: Image.asset('assets/images/AURORA.png'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => UpdateUserModal().firstdialogBuilder(context),
            icon: const Icon(Icons.person,
                color: Color.fromRGBO(81, 185, 214, 1)),
          ),
        ],
  );
}
