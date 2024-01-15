import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'items.dart';

// domain of your server
const String _baseURL = 'https://webhostwebhost186.000webhostapp.com';
// used to retrieve the key later

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  CartPage({Key? key, required this.cartItems}) : super(key: key);

  void onDeleteItem(int index) {
    // Ensure the index is valid
    if (index >= 0 && index < cartItems.length) {
      // Remove the item at the specified index
      cartItems.removeAt(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart Page'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text('Your Cart is Empty'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];

                return ListTile(
                  leading: Image.network(
                    item['imageUrl'],
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['itemName']),
                  subtitle: Text(
                      'Quantity: ${item['quantity']},Total Price: \$${item['totalPrice'].toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Call the onDeleteItem function to remove the item from the cart
                      onDeleteItem(index);

                      // Force a rebuild of the widget to reflect the changes
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
      floatingActionButton: Tooltip(
        message: 'Add Address',
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return AddAddress();
              },
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Address'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.greenAccent,
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.greenAccent,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage(
                            cartItems: cartItems,
                          )),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.list,
                color: Colors.greenAccent,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowProducts()));
              },
            )
          ],
        ),
      ),
    );
  }
}

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  // creates a unique key to be used by the form
  // this key is necessary for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerCity = TextEditingController();
  TextEditingController _controllerStreet = TextEditingController();
  // the below variable is used to display the progress bar when retrieving data
  bool _loading = false;

  @override
  void dispose() {
    _controllerPhoneNumber.dispose();
    _controllerCity.dispose();
    _controllerStreet.dispose();
    super.dispose();
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.logout))
          ],
          title: const Text('Address Form'),
          centerTitle: true,
          // the below line disables the back button on the AppBar
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Form(
          key:
              _formKey, // key to uniquely identify the form when performing validation
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerPhoneNumber,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Phone Number',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Phone Number';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerCity,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter City',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter City';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _controllerStreet,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Street',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Street';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                // we need to prevent the user from sending another request, while current
                // request is being processed
                onPressed: _loading
                    ? null
                    : () {
                        // disable button while loading
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });

                          saveAddress(
                              update,
                              int.parse(_controllerPhoneNumber.text.toString()),
                              _controllerCity.text.toString(),
                              _controllerStreet.text.toString());
                        }
                      },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              Visibility(
                  visible: _loading, child: const CircularProgressIndicator())
            ],
          ),
        ))));
  }
}

Future<void> saveAddress(
  Function(String) update,
  int phoneNumber,
  String city,
  String street,
) async {
  try {
    final url = Uri.parse('$_baseURL/addAddress.php');
    final response = await http.post(
      url,
      body: {
        'phone_number': phoneNumber.toString(),
        'city': city, // Update variable name
        'street': street, // Update variable name
      },
    );

    if (response.statusCode == 200) {
      update('Address added successfully');
    } else {
      update('Failed to add address to the database');
    }
  } catch (e) {
    update('Error occurred while processing the request');
  }
}
