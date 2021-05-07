import 'dart:async';

import 'package:flutter/material.dart';

import 'home.dart';

class ForgotPassWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgotPassWordState();
}

class ForgotPassWordBody extends StatefulWidget {
  final String? loginName;

  const ForgotPassWordBody({Key? key, this.loginName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgotPassWordBodyState();
}

class _ForgotPassWordBodyState extends State<ForgotPassWordBody> {
  String? _loginName = "";
  String _verificationCode = "";
  bool _isNextEnabled = false;

  String? _nameErrorMessage;
  String? _verificationCodeErrorMessage;

  bool _isLoading = false;
  int _countDown = 0;

  Timer? _timer;

  TextEditingController _textEditingController = TextEditingController();

  @override void initState() {
    super.initState();
    if(widget.loginName != null) {
      if (widget.loginName!.isNotEmpty) {
        _loginName = widget.loginName;
      }
    }
  }

  @override void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void _countDownSentTime() {
    if(_countDown == 0) {
      setState(() {
        _countDown = 60;
      });
      const oneSec = const Duration(seconds: 1);

      var callback = (timer) => {
        setState(() {
          if(_countDown < 1) {
            _timer!.cancel();
          } else {
            _countDown = _countDown - 1;
          }
        })
      };

      _timer = Timer.periodic(oneSec, callback);
    }
  }

  void _onPressSendVerificationCode() async {
    _countDownSentTime();
  }

  void _onPressNext() async {
    FocusScope.of(context).unfocus();
    _isLoading = true;
    _isNextEnabled = false;
    //TODO: 网络请求验证身份
  }

  void toggleButtonEnabled() {
    _nameErrorMessage = null;
    _verificationCodeErrorMessage = null;

    if(_loginName!.isNotEmpty && _verificationCode.isNotEmpty) {
      _isNextEnabled = true;
    } else {
      _isNextEnabled = false;
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
              child: SingleChildScrollView (
                child: Column(
                  children: [
                    if(widget.loginName == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "用户名/邮箱",
                              errorText: _nameErrorMessage
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
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: _textEditingController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "验证码",
                                  errorText: _verificationCodeErrorMessage
                              ),
                              onChanged: (val) {
                                setState(() {
                                  if(val.length > 4) {
                                    _textEditingController.text = _verificationCode;
                                    _textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: _textEditingController.text.length));
                                  } else _verificationCode = val;
                                  toggleButtonEnabled();
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: ElevatedButton(
                              onPressed: _countDown == 0 ? _onPressSendVerificationCode : null,
                              child: _countDown == 0 ? Text("发送验证码") : Text("请等 $_countDown 秒")
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
                      onPressed: _isNextEnabled ? _onPressNext : null,
                      child: Text("下一步")
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}

class ForgotPassWordState extends State<ForgotPassWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FullAppbar(title: "忘记密码", hasParent: true, onBackPressed: () {Navigator.pop(context);}),
        body: GestureDetector(
            onTap: () { FocusScope.of(context).unfocus(); },
            behavior: HitTestBehavior.translucent,
            child: ForgotPassWordBody()
        )
    );
  }
}