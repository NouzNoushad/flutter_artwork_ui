import 'package:flutter/material.dart';
import 'package:flutter_artwork_ui/bottom_nav.dart';
import 'package:flutter_artwork_ui/db.dart';
import 'package:flutter_artwork_ui/sign_up.dart';

import 'home_page.dart';

class ArtWorkLogin extends StatefulWidget {
  const ArtWorkLogin({Key? key}) : super(key: key);

  @override
  State<ArtWorkLogin> createState() => _ArtWorkLoginState();
}

class _ArtWorkLoginState extends State<ArtWorkLogin> {
  // Form key
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // Hide passwords
  bool isPasswordObscure = true;

  // Userslist
  List<Map> usersList = [];

  // Database
  Db database = Db();

  @override
  void initState() {
    database.open();
    getUserData();
    super.initState();
  }

  void getUserData() {
    Future.delayed(const Duration(seconds: 1), () async {
      usersList = await database.db!.rawQuery("SELECT * FROM artworks");
      setState(() {});
      print(usersList);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/pink.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 370,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 232, 162, 200).withOpacity(0.6),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      emailTextFormField(),
                      passwordTextFormField(),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  loginTextFieldValidation(),
                  Container(
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Color.fromARGB(255, 232, 162, 200).withOpacity(0.5),
                      border: Border.all(width: 1.5, color: Colors.white54),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // If i click on this button navigate me to Sign up page
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const ArtworkSignUp()),
                        );
                      },
                      child: const Text(
                        "I don't have an account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginTextFieldValidation() => Container(
        height: 40,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 120, 48, 102),
                Color.fromARGB(255, 252, 172, 189),
                Color.fromARGB(255, 249, 173, 190),
              ],
            )),
        child: TextButton(
          // I need only the users who already signup to visit home page
          // I gonna grab all user data saved into my database and compare it with email
          onPressed: () {
            // compare user typed email with emails in database if he exists then i need his email, password and username
            String? email;
            String? password;
            String? username;

            var userData = usersList
                .where((user) => (user["email"] == _email.text))
                .toList();
            for (var user in userData) {
              email = user["email"];
              password = user["password"];
              username = user["username"];
            }
            print(email);
            print(password);
            print(username);

            // check all validations and if true take me to home page
            if (_formKey.currentState!.validate()) {
              // compare user typed email with email to make bit secure
              if (_email.text == email) {
                // if true i want to make sure he is using correct password
                if (_password.text == password) {
                  // if password also match then navigate to home page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ArtworkBottomNavBar(username: username!)),
                  );
                } else if (_password.text != password) {
                  // popup message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Color.fromARGB(255, 120, 48, 102),
                      content: Text(
                        "invalid password, please try again",
                        style: TextStyle(
                          color: Color.fromARGB(255, 249, 173, 190),
                        ),
                      ),
                    ),
                  );
                }
              } else if (_email.text != email) {
                // if email doesnot match i need popup message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color.fromARGB(255, 120, 48, 102),
                    content: Text(
                      "user does not exist, signup first and please try again",
                      style: TextStyle(
                        color: Color.fromARGB(255, 249, 173, 190),
                      ),
                    ),
                  ),
                );
              }
            }
          },
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget passwordTextFormField() => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: _password,
          validator: (String? value) {
            // check password field is empty
            if (value!.isEmpty) {
              return "please provide a password";
            }
            // check password character exceeds 8 characters
            else if (value.length >= 8) {
              return "password should not exceeds 8 characters";
            }
            return null;
          },
          cursorColor: Color.fromARGB(255, 120, 48, 102),
          // text style
          style: const TextStyle(
            color: Color.fromARGB(255, 120, 48, 102),
            fontSize: 13,
          ),
          obscureText: isPasswordObscure, // hide the text
          decoration: InputDecoration(
            hintText: "password",
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            // password hide icon
            // if i click on this button hide my password
            suffixIcon: GestureDetector(
              onTap: () {
                // lets use obscure property
                setState(() {
                  isPasswordObscure = !isPasswordObscure;
                });
              },
              // if obscure then hide icon or visible icon
              child: isPasswordObscure
                  ? const Icon(
                      Icons.visibility_off,
                      size: 16,
                    )
                  : const Icon(
                      Icons.visibility,
                      size: 16,
                    ),
            ),
            // remove extra padding
            isDense: true,
            // for background color
            filled: true,
            fillColor: Color.fromARGB(255, 232, 162, 200).withOpacity(0.5),
            // border
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.white54),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.white54),
            ),
            // styling error border
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
            ),
          ),
        ),
      );

  Widget emailTextFormField() => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: _email,
          // validation
          validator: (String? value) {
            // check email field is empty
            if (value!.isEmpty) {
              return "please provide an email";
            }
            // check if email consist @ symbol
            else if (!value.contains("@")) {
              return "please enter valid email address";
            }
            return null;
          },
          cursorColor: Color.fromARGB(255, 120, 48, 102),
          // text style
          style: const TextStyle(
            color: Color.fromARGB(255, 120, 48, 102),
            fontSize: 13,
          ),
          decoration: InputDecoration(
            hintText: "email",
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            // remove extra padding
            isDense: true,
            // for background color
            filled: true,
            fillColor: Color.fromARGB(255, 232, 162, 200).withOpacity(0.5),
            // border
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.white54),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.white54),
            ),
            // styling error border
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
            ),
          ),
        ),
      );
}
