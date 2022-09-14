

import 'package:flutter/material.dart';

class FormRow extends StatelessWidget {

  final Widget content;
  final int flex;

  const FormRow({Key? key, required this.content, this.flex = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Container(),
      ),
      Expanded(
          flex: flex,
          child: content
      ),
      Expanded(
        child: Container(),
      ),
    ]);
  }




}