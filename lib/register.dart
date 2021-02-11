import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wireless_order_system/home.dart';

class RegisterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterWidgetState();
}

class RegisterBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterBodyState();
}

class RegisterBodyState extends State<RegisterBody> {
  String _regex = r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";

  bool _nameEdited = false;
  bool _firstPasswordEdited = false;
  bool _secondPasswordEdited = false;

  String _loginNameType = "name";

  String _loginName = "";
  String _password = "";
  String _firstInputPassword = "";
  String _secondInputPassword = "";

  String _nameErrorMessage = "";
  int _firstCounter = 0;
  String _firstErrorMessage = "";
  String _secondErrorMessage = "";

  bool _isRegisterEnabled = false;

  bool _isLoading = false;

  TextEditingController _secondPasswordController = TextEditingController();

  void _onPressRegister() async {
    FocusScope.of(context).unfocus();
    _isLoading = true;
  }

  void _toggleButtonEnabled() {
    if(_firstInputPassword == _secondInputPassword && _firstInputPassword.length >= 8 && _loginName.isNotEmpty && RegExp(_regex).firstMatch(_firstInputPassword) != null) {
      _password = _firstInputPassword;
      _isRegisterEnabled = true;
    } else {
      _password = null;
      _isRegisterEnabled = false;
    }
  }

  void _checkName() {
    if(_loginName.contains(" ")) {
      _nameErrorMessage = "用户名不能包含空格";
    } else {
      _nameErrorMessage = null;
    }

    if(_loginName.contains("@")) {
      _loginNameType = "email";
    } else {
      _loginNameType = "name";
    }
  }

  void _checkFirstInputPassword() {
    _secondPasswordController.clear();
    _secondInputPassword = "";
    _secondErrorMessage = null;

    _firstCounter = _firstInputPassword.length;

    if(_firstInputPassword.length < 8 && _firstInputPassword.length > 0) {
      _firstErrorMessage = "密码长度太短";
      return;
    } else {
      _firstErrorMessage = null;
    }

    if(RegExp(_regex).firstMatch(_firstInputPassword) == null) {
      _firstErrorMessage = "密码必须是大小写字母和数字的组合";
    } else {
      _firstErrorMessage = null;
    }

    if(_firstInputPassword.length == 0){
      _firstErrorMessage = null;
      _secondErrorMessage = null;
      return;
    }
  }

  void _checkSecondInputPassword() {
    if(_firstInputPassword != _secondInputPassword) {
      _secondErrorMessage = "前后两次密码不一致";
    } else {
      _secondErrorMessage = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "用户名/邮箱",
                            helperText: "用户名不可以包括空格",
                            errorText: _nameEdited ? _nameErrorMessage : null
                        ),
                        onChanged: (val) {
                          setState(() {
                            _loginName = val;
                            _nameEdited = true;
                            _checkName();
                            _toggleButtonEnabled();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            counterText: "$_firstCounter/16",
                            labelText: "密码",
                            helperText: "密码必须大于等于8位小于16位且包含大小写和数字",
                            errorText: _firstPasswordEdited ? _firstErrorMessage : null
                        ),
                        onChanged: (val) {
                          setState(() {
                            _firstInputPassword = val;
                            _firstPasswordEdited = true;
                            _checkFirstInputPassword();
                            _toggleButtonEnabled();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                      child: TextField(
                        controller: _secondPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "确认密码",
                          helperText: "必须与密码相同",
                          errorText: _secondPasswordEdited ? _secondErrorMessage : null
                        ),
                        onChanged: (val) {
                          setState(() {
                            _secondInputPassword = val;
                            _secondPasswordEdited = true;
                            _checkSecondInputPassword();
                            _toggleButtonEnabled();
                          });
                        },
                      ),
                    ),
                  ],
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Spacer(),
                  if (_isLoading) Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: SizedBox(
                        height: 28.0,
                        width: 28.0,
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor))
                    ),
                  ),
                  ElevatedButton(
                      onPressed: _isRegisterEnabled && !_isLoading ? _onPressRegister : null,
                      child: Text("注册")
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}

class RegisterWidgetState extends State<RegisterWidget> {
  void onBackPressed(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FullAppbar(title: "注册", hasParent: true, onBackPressed: onBackPressed),
      body: GestureDetector(
          onTap: () { FocusScope.of(context).unfocus(); },
          behavior: HitTestBehavior.translucent,
          child: RegisterBody()
      )
    );
  }

}