import 'package:flutter/material.dart';
import 'items.dart';
import 'search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  bool _load = false; // used to show products list or progress bar

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      // if (!success) { // API request failed
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('error to load data')));
      // }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // It's safe to access inherited widgets or elements here
    updateProducts(update);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: !_load ? null : () {
            setState(() {
              _load = false; // show progress bar
              updateProducts(update); // update data asynchronously
            });
          }, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {
            setState(() { // open the search product page
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Search())
              );
            });
          }, icon: const Icon(Icons.search))
        ],
           title: const Text('Available Items'),
           centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        // load products or progress bar
        body: _load ? const ShowProducts() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}