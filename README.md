# 💲 Expense tracker app:
## Description:
- It is an application that allows the user to register their expenses by allowing them to choose the expense category, date of expense, amount, and title. It also allows the user to view their expenses in both list and chart formats. The project goes beyond the basic concepts and dives more deeper into dart and flutter features such as asynchronous programming, adding interactivity, apply global theming to the entire app, using modal overlays & dialogs, handling baisc user inputs, ensuring valid user input, and handling user choice by formatting the date in readable format after allowing the user to pick up a date.

## Table of contents:
- [Features](#features)
- [Key concepts](#key-concepts)

### Features 
- Displays the expenses in both chart and list views.
- Enables the user to add a new expenses with the ability to enter its title, amount, and choosing its catgory and date of expense.
### Key concepts
- #### Showing snackbar:
  It is used to inform users when certain actions take place. In our case, it is used to inform the user that an expense deleted with giving the user the option to undo the action. It is used in `expenses.dart` file in the `_removeExpense` function.
  
- #### Asynchronous programming & Handling basic user inputs:
  - `_presentDatePicker()` function to handle user date picker:
  ---
    ````
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
  ````
     - `async` keyword refers to an asynchronous function which is a function that will wait until a certain action happens before its execution without affecting the flow of entire program.
       - In asynchronous programming, tasks can be initiated and executed concurrently, and the program doesn’t have to wait for the completion of each task. Instead, it can continue executing other tasks or operations while waiting for the results of the asynchronous tasks.
       - `async` keyword allows the function to use the `await` keyword inside it. `await` keyword is used to pause the execution of the asynchronous function until a particular asynchronous operation is completed. `await` suspends the asynchronous function and passes the control to the caller until the awaited operation completes. Once the awaited operation finishes, the function resumes execution from where it left off.
     - `showDatePicker` function:
       - showDatePicker function returns a `Future` DateTime object. `Future` represents a value that may not be available yet. It encapsulates an asynchronous operation and provides a way to handle the result or error when it becomes available. 
       - context: is an object which provides information about the current widget's location in the widget tree.
       - firstDate: is set to be the last year in the same day.
       - lastDate & firstDate is set to be now.
     - `_submitNewExpense()` function:
       This function is to validate and submit a new expense entry.
       #### Description:
         - Retrieves the user input for title, entered amound.
         - Ensures if the entered amount is a valid number or greater than zero.
         - Checks if the title, amount, date fields are not empty.
         - Shows alert dialog if one of the entered fields is invalid or empty.
         - if the validation passes, a new expenses is added to the list then the dialog closes.
---

