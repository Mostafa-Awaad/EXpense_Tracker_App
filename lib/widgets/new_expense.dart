import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/material.dart';


class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // TextEditingController is a class that is used to control the text field
  // Creating _titleController object from TextEditingController class
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitNewExpense() {
    final _enteredTitle =
        _titleController.text.trim(); // using trim() to remove white spaces
    // double.tryParse('Hello') => null, double.tryParse('11.2') => 11.2
    final _enteredAmount = double.tryParse(_amountController.text);
    final _AmountInvalid = _enteredAmount == null || _enteredAmount <= 0;

    if (_enteredTitle.isEmpty || _AmountInvalid || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content:
              const Text('Please enter valid title, amount, date and category'),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.pop(ctx);
              },
            )
          ],
        ),
      );
      return;
    }
    // Save the new expense
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: _enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    // Make the overlay closes automatically after adding a new expense
    Navigator.pop(context);
  }

  // dispose method is from the stateful widget methods that is called when the widget is
  // about to be removed from the widget tree
  // otherwise it will cause memory leak, because the controller will still be in memory
  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitNewExpense,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 242, 220, 245)),
                ),
                child: Text("Save Expense"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
