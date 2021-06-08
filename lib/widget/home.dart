import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wireless_order_system/widget/register.dart';
import 'package:wireless_order_system/wos_network.dart';

import '../me.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class FullAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? hasParent;
  final Function? onBackPressed;

  const FullAppbar({Key? key, this.title, this.hasParent, this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      Card(
          color: Colors.white,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child:Padding(
            padding: EdgeInsets.all(16.0),
            child:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(hasParent!) IconButton(
                    onPressed: onBackPressed as void Function()?,
                    padding: EdgeInsets.zero,
                    color: Theme.of(context).primaryColor,
                    icon: Icon(Icons.arrow_back),
                    constraints: BoxConstraints()
                  ),
                  hasParent! ? Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(title!,style: Theme.of(context).textTheme.headline6)
                  ) : Text(title!,style: Theme.of(context).textTheme.headline6)
                ]
            ),
          )
      )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(118.0);

}

class _HomeBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  String? _loginName;
  String? _password;
  bool _isLoginEnabled = false;

  String? _nameErrorMessage; //show error in text field when request failed
  String? _passwordErrorMessage; //show error in text field when request failed

  bool _isLoading = false; //control the loading indicator

  void onPressRegister() {
    FocusScope.of(context).unfocus();
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => RegisterWidget()
    ));
  }

  Future<void> onPressLogin() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
      _isLoginEnabled = false;
    });
    if(_loginName == null || _password == null) return;
    await WOSNetwork.instance.post("/auth/login",
        json.encode({
          "username": _loginName,
          "password": _password
        }), (response) async {
      if(response != null) {
        log(response.toString());
        Map<String, dynamic> map = json.decode(json.encode(response));
        Me.getInstance()
            .userId = map["id"];
        Me.getInstance()
            .username = map["username"];
        Me.getInstance()
            .token = map["token"];
        await Me.getInstance().save();
        await Me.getInstance().load();
        if(Me.getInstance().isEmpty()) {
          Fluttertoast.showToast(msg: "保存失败");
          return;
        }
        Navigator.pushReplacementNamed(context, '/start');
      } else {
        setState(() {
          _isLoginEnabled = true;
          _isLoading = false;
        });
      }
    });
  }

  void toggleButtonEnabled() {
    _nameErrorMessage = null;
    _passwordErrorMessage = null;

    if(_password != null && _password!.length >= 8 && _loginName != null) {
      _isLoginEnabled = true;
    } else {
      _isLoginEnabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded (
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "用户名",
                        errorText: _nameErrorMessage,
                        suffixIcon: _nameErrorMessage != null ? Icon(Icons.error_outline, color: Colors.red) : null
                    ),
                    onChanged: (val) {
                      setState(() {
                        _loginName = val;
                        toggleButtonEnabled();
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
                        labelText: "密码",
                        errorText: _passwordErrorMessage,
                        suffixIcon: _passwordErrorMessage != null ? Icon(Icons.error_outline, color: Colors.red) : null
                    ),
                    onChanged: (val) {
                      setState(() {
                        _password = val;
                        toggleButtonEnabled();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: onPressRegister,
                  child: Text("注册")
                ),
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
                    onPressed: _isLoginEnabled ? onPressLogin : null,
                    child: Text("登录")
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Me.getInstance().load().then((future){
      log("登录信息："+Me.getInstance().isEmpty().toString());
      if(!Me.getInstance().isEmpty()) {
        Navigator.pushReplacementNamed(context, '/start');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FullAppbar(title: "登录", hasParent: false),
      body: GestureDetector(
        onTap: () { FocusScope.of(context).unfocus(); },
        behavior: HitTestBehavior.translucent,
        child: _HomeBody()
      )
    );
  }
}