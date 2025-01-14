import 'package:flutter/material.dart';

var _enteredTitle = '';

void _inputTitle(String inputValue) {
  _enteredTitle = inputValue;
}

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const TextField(
            onChanged: _inputTitle,
            maxLength: 50,
            decoration: InputDecoration(
              hintText: "Title",
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_enteredTitle);
                },
                child: Text("Save Expense"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
