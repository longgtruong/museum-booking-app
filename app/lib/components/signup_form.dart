import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  signUp() {
    if (_signUpFormKey.currentState!.validate()) {
      User user = new User(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          username: _usernameController.text,
          password: _passwordController.text);
      BlocProvider.of<UserCubit>(context).signUp(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserSignUpError) {
          final msg = state.msg;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(msg),
            backgroundColor: Colors.red[100],
          ));
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Sign Up",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 15.0,
            ),
            Form(
              key: _signUpFormKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "First name required";
                      }
                    },
                    controller: _firstNameController,
                    decoration: InputDecoration(
                        hintText: "First name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        contentPadding: EdgeInsets.all(15.0)),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Last name required";
                      }
                    },
                    controller: _lastNameController,
                    decoration: InputDecoration(
                        hintText: "Last name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        contentPadding: EdgeInsets.all(15.0)),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username required";
                      }
                    },
                    controller: _usernameController,
                    decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        contentPadding: EdgeInsets.all(15.0)),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password required";
                      }
                    },
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        contentPadding: EdgeInsets.all(15.0)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: () => {signUp()},
              child: Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Center(child: Text("SIGN UP"))),
            ),
            TextButton(
                onPressed: () =>
                    {BlocProvider.of<UserCubit>(context).emit(UserLogin())},
                child: Text("Have an account? Click to login.",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
