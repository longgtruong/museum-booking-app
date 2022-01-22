import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  login() {
    if (_loginFormKey.currentState!.validate()) {
      BlocProvider.of<UserCubit>(context)
          .login(_usernameController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoginError) {
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
            Text("Login",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 15.0,
            ),
            Form(
              key: _loginFormKey,
              child: Column(
                children: [
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
              onTap: () => login(),
              child: Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Center(child: Text("LOGIN"))),
            ),
            TextButton(
                onPressed: () =>
                    {BlocProvider.of<UserCubit>(context).emit(UserSignUp())},
                child: Text("Don't have an account? Click to sign up.",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
