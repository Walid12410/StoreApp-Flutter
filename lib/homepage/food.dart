import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:store/home1.dart';

class Item {
  String ItemID;
  String ImageURL;
  String ItemName;
  String Quantity;
  String Price;
  String CategoryID;
  String category;

  Item({
    required this.ItemID,
    required this.ImageURL,
    required this.ItemName,
    required this.Quantity,
    required this.Price,
    required this.CategoryID,
    required this.category,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      ItemID: json['ItemID'],
      ImageURL: json['ImageURL'],
      ItemName: json['ItemName'],
      Quantity: json['Quantity'],
      Price: json['Price'],
      CategoryID: json['CategoryID'],
      category: json['category'],
    );
  }
}


class Food extends StatefulWidget {
  const Food({super.key});

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  List<Item>? items;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final Items = await DrinksItemsFromApi();
      setState(() {
        items = Items;
      });
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  Future<List<Item>> DrinksItemsFromApi() async {
    final response = await http.get(
        Uri.parse('use json file link/getItems.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (items == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Food'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Food'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>const Home()));
          }, icon: Icon(
            Icons.shopping_cart_checkout_outlined)
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items!.length,
              itemBuilder: (context, index) {
                print('Building item $index');
                if (items![index].CategoryID == '3') {
                  return Card(
                    child: ListTile(
                      title: Text(items![index].ItemName),
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.network(items![index].ImageURL,
                          fit: BoxFit.cover,),
                      ),
                      onTap: () {
                        // Handle item tap if needed
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
