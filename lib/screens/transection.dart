import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/db_helper.dart';

class AddTransection extends StatefulWidget {
  const AddTransection({Key? key}) : super(key: key);

  @override
  State<AddTransection> createState() => _AddTransectionState();
}

class _AddTransectionState extends State<AddTransection> {
  DateTime selectedDate = DateTime.now();
  bool type = false;
  int? amount;
  String note = "Expence";
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        title: const Text('Adding Transaction'),
      ),
      body: ListView(padding: const EdgeInsets.all(12), children: [
        Text('Enter Spend amount'),
        SizedBox(
          height: 30,
        ),
        Text(
          'Enter the amount that you have spend without using zero balance. ',
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
              padding: EdgeInsets.all(
                12.0,
              ),
              child: Icon(
                Icons.attach_money,
                size: 24.0,
                // color: Colors.grey[700],
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "0",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
                onChanged: (val) {
                  try {
                    amount = int.parse(val);
                  } catch (e) {
                    // show Error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(
                          seconds: 2,
                        ),
                        content: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              "Enter only Numbers as Amount",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
              padding: EdgeInsets.all(
                12.0,
              ),
              child: Icon(
                Icons.description,
                size: 24.0,
                // color: Colors.grey[700],
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Note on Transaction",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 20.0,
                ),
                onChanged: (val) {
                  note = val;
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
              padding: EdgeInsets.all(
                12.0,
              ),
              child: Icon(
                Icons.attach_money,
                size: 24.0,
                // color: Colors.grey[700],
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            ChoiceChip(
              label: Text(
                "Income",
                style: TextStyle(
                  fontSize: 18.0,
                  color: type == false? Colors.white : Colors.black,
                ),
              ),
              selectedColor: Colors.blue,
              onSelected: (val) {
                if (val) {
                  setState(() {
                    type = false;
                    if (note.isEmpty || note == "Expense") {
                      note = 'Income';
                    }
                  });
                }
              },
              selected: type == false ? true : false,
            ),
            SizedBox(
              width: 8.0,
            ),
            ChoiceChip(
              label: Text(
                "Expense",
                style: TextStyle(
                  fontSize: 18.0,
                  color: type == true ? Colors.white : Colors.black,
                ),
              ),
              selectedColor: Colors.blue,
              onSelected: (val) {
                if (val) {
                  setState(() {
                    type = true;

                    if (note.isEmpty || note == "Income") {
                      note = 'Expense';
                    }
                  });
                }
              },
              selected: type == true ? true : false,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50.0,
          child: TextButton(
            onPressed: () {
              _selectDate(context);
              //
              // to make sure that no keyboard is shown after selecting Date
              FocusScope.of(context).unfocus();
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.zero,
              ),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.date_range,
                    size: 24.0,
                    // color: Colors.grey[700],
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  "${selectedDate.day} ${months[selectedDate.month - 1]}",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
       SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                if (amount != null) {
                  DbHelper dbHelper = DbHelper();
                  dbHelper.addData(amount!, selectedDate, type, note);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[700],
                      content: Text(
                        "Please enter a valid Amount !",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
              child: Text(
                "Add",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ]),
    );
  }
}
