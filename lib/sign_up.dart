import 'package:flutter/material.dart';
import 'package:flutter_artwork_ui/db.dart';

import 'login.dart';

class ArtworkSignUp extends StatefulWidget {
  const ArtworkSignUp({Key? key}) : super(key: key);

  @override
  State<ArtworkSignUp> createState() => _ArtworkSignUpState();
}

class _ArtworkSignUpState extends State<ArtworkSignUp> {
  // Form Key
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  // Hide passwords
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  // Database
  Db database = Db();

  @override
  void initState() {
    database.open();
    super.initState();
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
          height: 480,
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
                "Sign up",
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
                      nameTextFormField(),
                      emailTextFormField(),
                      passwordTextFormField(),
                      confirmPasswordTextFormField(),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  signupTextFormValidation(),
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
                        // If i click on this button navigate me to Login page
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const ArtWorkLogin()),
                        );
                      },
                      child: const Text(
                        "I have an account",
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

  Widget signupTextFormValidation() => Container(
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
          // Lets make it bit more powerful by using database
          onPressed: () async {
            // when i click on sign up button it checks all the validations, then direct me to login page
            if (_formKey.currentState!.validate()) {
              // insert user data inside database
              await database.db!.rawInsert(
                  "INSERT INTO artworks(username, email, password) VALUES (?, ?, ?);",
                  [
                    _username
                        .text, // username saved in textFormField controller
                    _email.text,
                    _password.text,
                  ]);

              // popup message using snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color.fromARGB(255, 120, 48, 102),
                  content: Text(
                    "user data added to database",
                    style: TextStyle(
                      color: Color.fromARGB(255, 249, 173, 190),
                    ),
                  ),
                ),
              );

              // navigate to login page
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ArtWorkLogin()),
              );

              // I need my textFormField empty, so when i come back don't need to show earlier user datas
              _username.text = "";
              _email.text = "";
              _password.text = "";
              _confirmPassword.text = "";
            }
          },
          child: const Text(
            "Sign up",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget confirmPasswordTextFormField() => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: _confirmPassword,
          validator: (String? value) {
            // check confirm password empty
            if (value!.isEmpty) {
              return "please confirm your password";
            }
            // check if confirm password matches with password
            else if (_password.text != _confirmPassword.text) {
              return "password do not match, please try again.";
            }
            return null;
          },
          cursorColor: Color.fromARGB(255, 120, 48, 102),
          // text style
          style: const TextStyle(
            color: Color.fromARGB(255, 120, 48, 102),
            fontSize: 13,
          ),
          obscureText: isConfirmPasswordObscure,
          decoration: InputDecoration(
            hintText: "confirm password",
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            // password hide icon
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isConfirmPasswordObscure = !isConfirmPasswordObscure;
                });
              },
              child: isConfirmPasswordObscure
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

  Widget nameTextFormField() => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          // Lets do some validations, I need controller first to store my text
          controller: _username,
          // validations
          validator: (String? value) {
            if (value!.isEmpty) {
              return "please provide a name"; // checks if name field is empty
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
            hintText: "username",
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
