import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'addToCart.dart';
import 'home1.dart';
// main URL for REST pages
const String _baseURL = 'put your json file link';

// class to represent a row from the products table
// note: cid is replaced by category name
class Item {
  int _Iid;
  String _URL;
  String _name;
  double _price;

  Item(this._Iid, this._URL, this._name, this._price);

  @override
  String toString() {
    return 'Item{_Iid: $_Iid, _URL: $_URL, _name: $_name, _price: $_price}';
  }
}

List<Item> _items = [];

void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getItems.php');
    final response = await http.get(url).timeout(const Duration(seconds: 20));
    _items.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      // print('JSON Response: $jsonResponse');
      for (var row in jsonResponse) {
        int? itemId = int.tryParse(row['ItemID'] ?? '');
        String imageUrl = row['ImageURL'] ?? '';
        String itemName = row['ItemName'] ?? '';
        double price = double.tryParse(row['Price']?.replaceAll(',', '') ?? '') ?? 0.0;

        // Check if the extracted fields are valid
        if (itemId != null && imageUrl.isNotEmpty && itemName.isNotEmpty) {
          Item item = Item(itemId, imageUrl, itemName, price);
          _items.add(item);
        } else {
          print('Invalid data for item: $row');
          // Handle the error, e.g., skip the item or provide default values
        }
      }
      update(true);
    }
  } catch (e) {
    print('Error: $e');
    update(false);
  }
}




// searches for a single product using product pid
void searchProduct(Function(String text) update, int ItemID) async {
  try {
    final url = Uri.https(_baseURL, 'searchProduct.php', {'ItemID':'$ItemID'});
    final response = await http.get(url).timeout(const Duration(seconds: 50));
    _items.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Item I = Item(
        int.parse(row['ItemID']),
        row['ImageURL'],
        row['ItemName'],
        double.parse(row['Quantity']),


      );

      _items.add(I);
      update(I.toString());
    }
  }
  catch(e) {
    print('$e');
    update("can't load data");
  }
}

// shows products stored in the _products list as a ListView

class CartItem {
  final String name;
  final String imageURL;
  final double price;
  final int quantity;
  final double totalPrice;

  CartItem({
    required this.name,
    required this.imageURL,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });
}


class ShowProducts extends StatefulWidget {
  const ShowProducts({Key? key}) : super(key: key);

  @override
  _ShowProductsState createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  List<int> quantities = List.generate(_items.length, (index) => 0);
  List<double> totalPrices = List.generate(_items.length, (index) => 0.0);
  List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                double itemPrice = _items[index]._price;
                double totalPrice = totalPrices[index];
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        width: 200, // Set a fixed width for the image container
                        child: Image.network(
                          _items[index]._URL,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _items[index]._name,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Price: \$${itemPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (quantities[index] > 0) {
                                    setState(() {
                                      quantities[index]--;
                                      totalPrices[index] = quantities[index] * itemPrice;
                                    });
                                  }
                                },
                              ),
                              Text('${quantities[index]}'),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    quantities[index]++;
                                    totalPrices[index] = quantities[index] * itemPrice;
                                  });
                                },
                              ),
                            ],
                          ),
                          Text(
                            'Total: \$${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                          IconButton(
                            icon: Icon(Icons.shopping_cart, color: Colors.green),
                            onPressed: () {
                              CartItem newItem = CartItem(
                                name: _items[index]._name,
                                imageURL: _items[index]._URL,
                                price: itemPrice,
                                quantity: quantities[index],
                                totalPrice: totalPrice,
                              );

                              cartItems.add({
                                'itemName': newItem.name,
                                'imageUrl': newItem.imageURL,
                                'totalPrice': newItem.totalPrice,
                                'quantity': newItem.quantity,
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartPage(cartItems: cartItems),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.greenAccent),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.greenAccent),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(cartItems: cartItems)));
              },
            ),
            IconButton(
              icon: Icon(Icons.list, color: Colors.greenAccent),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowProducts()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
