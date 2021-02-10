import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class FullAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasParent;

  const FullAppbar({Key key, this.title, this.hasParent}) : super(key: key);

  void _onBackPressed(){

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        margin: EdgeInsets.only(left: 8.0, right: 8.0),
        child:Padding(
          padding: EdgeInsets.all(16.0),
          child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(hasParent) IconButton(
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).primaryColor,
                  icon: Icon(Icons.arrow_back),
                  onPressed: _onBackPressed,
                  constraints: BoxConstraints(),
                ),
                hasParent ? Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(title,style: Theme.of(context).textTheme.headline6)
                ) : Text(title,style: Theme.of(context).textTheme.headline6)
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

class HomeBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String loginName = "";
  String password = "";
  bool isLoginEnabled = false;
  bool isLoginIn = false;

  void onPressedForgotPassword() {
    FocusScope.of(context).unfocus();
  }

  void onPressedRegister() {
    FocusScope.of(context).unfocus();
    //Navigator.push();
  }

  void onPressedLogin() async {
    FocusScope.of(context).unfocus();
  }

  void toggleLoginButtonEnabled() {
    if(password.isNotEmpty && password.length >= 8 && loginName.isNotEmpty) {
      isLoginEnabled = true;
    } else {
      isLoginEnabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "用户名/邮箱"
                  ),
                  onChanged: (val) {
                    setState(() {
                      loginName = val;
                      toggleLoginButtonEnabled();
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
                      labelText: "密码"
                  ),
                  onChanged: (val) {
                    setState(() {
                      password = val;
                      toggleLoginButtonEnabled();
                    });
                  },
                ),
              ),
              Row(children: [
                  TextButton(
                    onPressed: onPressedForgotPassword,
                    child: Text("忘记密码")
                  )
                ]
              )
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: onPressedRegister,
                  child: Text("注册")
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: isLoginEnabled ? onPressedLogin : null,
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


class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FullAppbar(title: "登录", hasParent: false),
      body: GestureDetector(
        onTap: () { FocusScope.of(context).unfocus(); },
        behavior: HitTestBehavior.translucent,
        child: HomeBody()
      )
    );
  }

}