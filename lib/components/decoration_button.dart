import 'package:flutter/material.dart';

ButtonStyle getHabitButtonDecorations() {
  return ButtonStyle(
    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
      vertical: 10, horizontal: 32
    )),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        
      )
    ),
     backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255))
    // Aqui você pode adicionar outras propriedades de estilo, como cor de fundo, sombra, etc.
  );
}
