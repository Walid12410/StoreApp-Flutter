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


class Meatandchicken extends StatefulWidget {
  const Meatandchicken({super.key});

  @override
  State<Meatandchicken> createState() => _MeatandchickenState();
}

class _MeatandchickenState extends State<Meatandchicken> {
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
        Uri.parse('json file link/getItems.php'));

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
          title: Text('Meat&chciken'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    print('Items length: ${items!.length}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Meat&chciken'),
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
                if (items![index].CategoryID == '5') {
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

