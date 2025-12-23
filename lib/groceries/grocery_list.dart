import 'package:flutter/material.dart';
import 'package:w12/models/grocery.dart';
import '../data/mock_grocery_repository.dart';
import 'grocery_form.dart';
class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {

// TODO-4 - Navigate to the form screen using the Navigator push 
    void onCreate(BuildContext context) async {
    final newItem = await Navigator.of(context).push<Grocery>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem != null) {
      setState(() {
        dummyGroceryItems.add(newItem);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {

        content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (context, index) 
         {
          return GroceryTile(grocery: dummyGroceryItems[index]);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () => onCreate(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
   Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: grocery.category.color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      title: Text(grocery.name),
      trailing: Text(
        grocery.quantity.toString(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () {
        // tappable (required by challenge)
      },
    );
  }
}