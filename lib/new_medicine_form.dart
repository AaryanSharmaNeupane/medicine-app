import 'package:flutter/material.dart';

class NewMedicine extends StatefulWidget {
  final Function addTransaction;

  const NewMedicine(this.addTransaction, {super.key});

  @override
  State<NewMedicine> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewMedicine> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredDescription = descriptionController.text;
    final enteredAmount = double.parse(priceController.text);

    if (enteredTitle.isEmpty ||
        enteredDescription.isEmpty ||
        enteredAmount < 0) {
      return;
    }
    widget.addTransaction(
      titleController.text,
      descriptionController.text,
      double.parse(priceController.text),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: titleController,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Description"),
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              maxLines: 2,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Price"),
              controller: priceController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => submitData(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: submitData,
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text("Add Medicine"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
