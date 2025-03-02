import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // Adding dummy data
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Groceries',
      amount: 50.0,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'cinema',
      amount: 20.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addNewExpense),
    );
  }

  //Function to add new expense item
  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  //Function to remove an expense item
  void _removeExpense(Expense expense) {
    final _expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // Clear all snack bars before showing a new one
    ScaffoldMessenger.of(context).clearSnackBars();
    // Show snack bar message to undo the removing action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3), // duration of the message
        content: const Text(
          // message content
          "Expense removed",
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            // Using the insert method to add the removed expense back to its original index position
            // Contrary to the add method that adds the item to the end of the list
            setState(() {
              _registeredExpenses.insert(_expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Declare a widget that represents the main content
    Widget mainContent = const Center(
      child: Text(
        'No expenses added yet!',
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      setState(() {
        mainContent = width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(
                    child: ExpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: _removeExpense,
                    ),
                  ),
                ],
              )
            :
            // Chart widget gets infinity width as it gets width as much it can get
            Row(
                children: [
                  // Expanded constraints in the child (i.e, Chart) to only take as much width as available in the Row after sizing the other Row children
                  Expanded(
                    child:
                        // Chart widget gets infinity width as it gets width as much it can get
                        Chart(expenses: _registeredExpenses),
                  ),
                  Expanded(
                    child: ExpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: _removeExpense,
                    ),
                  ),
                ],
              );
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("EXpense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: mainContent,
    );
  }
}
