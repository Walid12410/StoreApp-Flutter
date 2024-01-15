import 'package:flutter/material.dart';
import 'package:store/LoginSignup/thankyoupage.dart';
import 'login.dart';
import 'package:http/http.dart'as http;


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  String R = '';

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _retpyepasswordController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();

  void AddUser() {
    String password = _passwordController.text;
    String retypepassword = _retpyepasswordController.text;
    String fullname = _fullnameController.text;
    String username = _usernameController.text;

    if (password != retypepassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password Not Match'),
          duration: Duration(seconds: 3),),
      );
    } else if (password.isEmpty || username.isEmpty || retypepassword.isEmpty
        || fullname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fill all field'),
            duration: Duration(seconds: 4),)
      );
    } else {
      AddUsers(_fullnameController.text.toString(), _usernameController.text.toString(),
          _passwordController.text.toString());
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _retpyepasswordController.dispose();
    _fullnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

void update(String t){
    setState(() {
      R = t;
      if(R== 'Address added successfully'){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const thankyoupage()));
      }
    });
}
  String _baseURL = 'https://webhostwebhost186.000webhostapp.com';

  Future<void> AddUsers(String name, String username, String password) async {
    try {
      final url = Uri.parse('$_baseURL/signup.php');
      final response = await http.post(
        url,
        body: {
          'Name': name,
          'Username': username,
          'Password': password,
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


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff1acb4d),
                    Color(0xff184b28),
                  ])),
              child:const Padding(
                padding: EdgeInsets.all(40.0),
                child:Text(
                  'Create Your\n Account',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                decoration:const  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _fullnameController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Full Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1acb4d),
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'UserName',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1acb4d),
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: (){
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          label:const Text(
                            'password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1acb4d),
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _retpyepasswordController,
                        obscureText: _isObscureConfirm,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscureConfirm ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: (){
                              setState(() {
                                _isObscureConfirm = !_isObscureConfirm;
                              });
                            },
                          ),
                          label: const Text(
                            'Comfirm password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1acb4d),
                            ),
                          ),
                        ),
                      ),
                      Text('$R'),
                      const SizedBox(height: 40),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(colors: [
                              Color(0xff1acb4d),
                              Color(0xff184b28),
                            ])),
                        child: TextButton(
                          onPressed: () {
                            AddUser();
                          },
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Already Have Account',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>Login()));
                                },
                                child:const  Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
