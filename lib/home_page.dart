import 'package:flutter/material.dart';
import 'package:medicine_app/new_medicine_form.dart';

import 'models/medicine_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List medicines = [
    Medicine(
      id: DateTime.now().toString(),
      title: "Paracetamol",
      description: "Take whenever u get fever in gap of 6 hours",
      price: 20,
    ),
    Medicine(
      id: DateTime.now().toString(),
      title: "Aciloc",
      description: "Take 2 times in empty stomach",
      price: 100,
    ),
    Medicine(
      id: DateTime.now().toString(),
      title: "Decold",
      description: "Take it whenever u feel cold",
      price: 35.0,
    ),
  ];

  void addMedicine(String title, String description, double price) {
    final med = Medicine(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        price: price);
    setState(() {
      medicines.add(med);
    });
  }

  void deleteMedicine(String id) {
    setState(() {
      medicines.removeWhere((med) => med.id == id);
    });
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewMedicine(addMedicine),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Medicine"),
        actions: [
          IconButton(
              onPressed: () => openBottomSheet(context),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: medicines.isEmpty
          ? const Center(
              child: Text(
                "No medicines available for you!",
                style: TextStyle(fontSize: 17),
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Column(
                            children: [
                              const Text("Rs."),
                              Text(
                                  '${medicines[index].price.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      medicines[index].title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      medicines[index].description,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteMedicine(medicines[index].id),
                    ),
                  ),
                );
              },
              itemCount: medicines.length,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => openBottomSheet(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
