import 'package:customer_management_system/model/users.dart';
import 'package:customer_management_system/navigation/sideMenu.dart';
import 'package:customer_management_system/services/services.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  static String access = '';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  List<User> _users = [];
  _checkCredentials(String username,String password){
    EasyLoading.show(status: 'Please wait!!');
    Services.isValidUser(username, password)
        .then((value) {
          setState(() {
            _users = value;
          });
          if(_users.length == 1) {
            Login.access = _users[0].access;
            EasyLoading.dismiss();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => SideMenu()));
          }else{
            EasyLoading.showError("username or password incorrect");
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: TextStyle(fontSize: 60),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Spacer(),
              Expanded(
                  child: Text(
                'Username',
                style: TextStyle(fontSize: 18),
              )),
              Expanded(
                  child: TextFormBox(
                    controller: usernameController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter username';
                  } else {
                    return null;
                  }
                },
                placeholder: 'Username',
              )),
              Spacer(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Spacer(),
              Expanded(
                  child: Text(
                'Password',
                style: TextStyle(fontSize: 18),
              )),
              Expanded(
                  child: TextFormBox(
                    controller: passwordController,
                obscureText: true,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter password';
                  } else {
                    return null;
                  }
                },
                placeholder: 'password',
              )),
              Spacer(),
            ],
          ),
          Button(
              child: SizedBox(
                width: 200,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              onPressed: () => {
                    if (_formKey.currentState!.validate()){
                       _checkCredentials(usernameController.text, passwordController.text),
                      }
                    else
                      {
                        EasyLoading.showError('Please enter valid data'),
                      }
                  }
                  )
        ],
      ),
    );
  }
}
