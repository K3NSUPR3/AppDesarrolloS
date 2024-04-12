import 'package:first_app/widgets/chart/chart.dart';
import 'package:first_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:first_app/widgets/expenses_list/expenses_list.dart';
//importaciones de paginas desde la consola
import 'package:first_app/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key}); //  clase de maestro

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Presupuesto Trabajo Desarrollo', //seccion 109
      amount: 827714.42,
      date: DateTime.now(),
      category: Category.Trabajo,
    ),
    Expense(
      title: 'Equipo de computo',
      amount: 98411.9, //slots de ejemplo
      date: DateTime.now(),
      category: Category.Computacion,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense); //llamado del metodo
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); // remueve el anterior y muestra el nuevo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3), //tiempo de espera
        content: const Text('Borrando...'),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
          'No se ha encontrado presupuestos gastados, Comienza añadiendo algo!'),
      //center
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('CRIZS GASTOS'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          //barra de herramientas
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
