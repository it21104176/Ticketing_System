import 'package:bus_hub/constants/colors.dart';
import 'package:flutter/material.dart';

const TextStyle greet = TextStyle(
  fontSize: 20,
  color: textLight,
  fontWeight: FontWeight.w400,
);
const TextStyle descStyle = TextStyle(
  fontSize: 16,
  color: textLight,
  fontWeight: FontWeight.w400,
);
const TextStyle descBStyle = TextStyle(
  fontSize: 24,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const txtInputDeco = InputDecoration(
  hintText: "Email",
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
);

const txtInputDeco2 = InputDecoration(
  labelText: 'Email',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const buttonBorderRadius = BorderRadius.all(Radius.circular(20.0));

const buttonDeco = BoxDecoration(
  borderRadius: buttonBorderRadius,
  gradient: LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
);
