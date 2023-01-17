import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({super.key, required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        double.parse(_amountController.text) <= 0 ||
        _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(_titleController.text,
        double.parse(_amountController.text), _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Hello',
            ),
            // onChanged: (value) {
            //   _titleInput = value;
            //   // print(_titleInput);
            // },
            controller: _titleController,
            onSubmitted: (_) => _submitData(),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              hintText: '10.00',
            ),
            // onChanged: (value) {
            //   _amountInput = value;
            //   // print(_amountInput);
            // },
            controller: _amountController,
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDate == null
                      ? 'No Date Choosen!'
                      : DateFormat.yMMMMd().format(_selectedDate as DateTime),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                TextButton(
                  onPressed: _showDate,
                  child: Text(
                    'Choose Date.',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: Text(
              'Add Transaction',
            ),
          ),
        ],
      ),
    );
  }
}
