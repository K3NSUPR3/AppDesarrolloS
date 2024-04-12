import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart'; //desde la terminal se importa flutter pub add uuid

final formatter = DateFormat.yMd(); //ano mes y dia
const uuid = Uuid();

//personalization
enum Category { Cultivo, Transporte, Computacion, Trabajo }

const categoryIcons = {
  //editar los iconos con la informacion oficial
  Category.Cultivo: Icons.local_florist,
  Category.Transporte: Icons.car_crash_rounded,
  Category.Computacion: Icons.computer,
  Category.Trabajo: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); // genera un unico id de un pluging tercero

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; //leisure

  String get formmatedDate {
    return formatter.format(date);
  }
}

//grafico
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // suma de las cuentas
    }
    return sum;
  }
}
