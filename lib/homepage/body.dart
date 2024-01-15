import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store/home1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Drinks.dart';
import 'food.dart';
import 'meat&chicken.dart';
import 'MilkandChese.dart';


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


class body extends StatefulWidget {
  const body({super.key});
  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  List<Item>? items;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final fetchedItems = await fetchItemsFromApi();
      setState(() {
        items = fetchedItems;
      });
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  Future<List<Item>> fetchItemsFromApi() async {
    final response = await http.get(Uri.parse('https://webhostwebhost186.000webhostapp.com/getItems.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome To Our Store',
          style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text.rich(
                      TextSpan(
                        text: 'Get 5% Off Your Purchase\n',
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: 'with Our Mobile App!',
                            style: TextStyle(color: Colors.white,
                            fontSize: 20)
                          )
                        ]
                      ),
                    ),
                  ),
                ),
              ),
              Categories(),
              const SizedBox(height: 10),
              Specialforyou(
                text: "Special for you",
                press: (){},
              ),
              const SizedBox(height: 5,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      SpecialOffers(category: "Drinks", image: "https://images.unsplash.com/photo-1613218222876-954978a4404e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          numOfBrands: 5, press: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Drinks()));
                          }),
                      SpecialOffers(category: "Food", image: "https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          numOfBrands: 12, press: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Food()));
                          }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Specialforyou(text: 'Popular Products', press: (){}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      items!.where((item) => item.CategoryID == '5').length,
                          (index) {
                        final filteredItems = items!.where((item) => item.CategoryID == '5').toList();
                        return product(items: filteredItems[index]);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Specialforyou(text: 'Take Your Order Now', press: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> const Home()));
              }),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                  ...List.generate(
                  items!.length,
                        (index) => product(items: items![index]),
                  ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class product extends StatelessWidget {
  const product({
    super.key,
    required this.items,
  });

  final Item items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        children: [
          AspectRatio(aspectRatio: 1.02,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(items.ImageURL as String,fit: BoxFit.cover,),
          ),),
          Text(
            items.ItemName,
            style: TextStyle(color: Colors.black),
            maxLines: 2,
          ),
          Text('\$${items.Price}'),
        ],
      ),
    );
  }
}

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    super.key, required this.category, required this.image, required this.numOfBrands, required this.press,
  });

  final String category,image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: SizedBox(
        width: 250,
        height: 100,
        child: GestureDetector(
         onTap: press,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(image,
                  fit: BoxFit.cover,
                width: 700,
                height: 100),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      const Color(0xff343434).withOpacity(0.4),
                      const Color(0xff343434).withOpacity(0.15),
                    ])
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(text:'$category\n',
                        style: TextStyle(fontSize: 18)
                        ),
                        TextSpan(
                          text:"Special for you"
                        )
                      ]
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
   List<Map<String,dynamic>> categories=[
     {"icon": "assets/chicken.svg", "text": "chicken"},
     {"icon": "assets/drinks.svg", "text": "drinks"},
     {"icon": "assets/food.svg", "text": "food"},
     {"icon": "assets/meat.svg", "text": "meat"},
     {"icon": "assets/milk.svg", "text": "milk"},
   ];
   return Padding(
     padding: const EdgeInsets.all(20),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
       ...List.generate(categories.length, (index) => CategoryCard(
         icon: categories[index]["icon"],
         text: categories[index]["text"],
         press: () {
           // Navigate to different screens based on the selected category
           switch (categories[index]["text"]) {
             case "chicken":
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>const Meatandchicken()),
               );
               break;
             case "drinks":
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>const Drinks()),
               );
               break;
             case "food":
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>const Food()),
               );
               break;
             case "meat":
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>const Meatandchicken()),
               );
               break;
             case "milk":
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>const Milkandchese()),
               );
               break;
             default:
             // Handle the default case or add additional cases as needed
               break;
           }
         },
       ))
       ],
     ),
   );
  }
}

class CategoryCard extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback press;

  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              onTap: press, // Call the press callback when tapped
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(icon),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Text(text, textAlign: TextAlign.center),
          const SizedBox(height:10),
        ],
      ),
    );
  }
}

class Specialforyou extends StatelessWidget {
  const Specialforyou({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style:const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: const Text('see more'),
          )
        ],
      ),
    );
  }
}

