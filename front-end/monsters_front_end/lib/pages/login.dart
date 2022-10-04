import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:monsters_front_end/pages/firtTime_editUserInfo.dart';
import 'package:monsters_front_end/pages/home.dart';
import 'package:monsters_front_end/pages/login_selfacount.dart';
import 'package:monsters_front_end/pages/signUp.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/google_sign_in_API.dart';
import '../model/memberModel.dart';
import '../repository/memberRepo.dart';
import 'package:date_format/date_format.dart';

class LoginPage extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<LoginPage> {
  //生日
  DateTime date = DateTime.now();
  final MemberRepository memberRepository = MemberRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffed4),
      body: Stack(
        children: <Widget>[
          //LOGO圖
          Pinned.fromPins(
            Pin(start: 42.0, end: 42.0),
            Pin(size: 312.0, start: 93.0),
            child:
                // Adobe XD layer: 'logo' (shape)
                Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/image/icon_main.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          //登入
          Align(
            alignment: Alignment(0.005, 0.139),
            child: SizedBox(
              width: 225.0,
              height: 39.0,
              child: RaisedButton(
                  color: Color.fromRGBO(216, 185, 99, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  child: const Text(
                    '登入',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 20,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    softWrap: false,
                  ),
                  onPressed: () {
                    checkSelfLogin();
                  }),
            ),
          ),
          //註冊
          Align(
            alignment: Alignment(0.005, 0.283),
            child: SizedBox(
              width: 225.0,
              height: 39.0,
              child: RaisedButton(
                  color: Color.fromRGBO(216, 185, 99, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  child: const Text(
                    '註冊',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 20,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    softWrap: false,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  }),
            ),
          ),
          //Google
          Align(
            alignment: Alignment(0.005, 0.426),
            child: SizedBox.fromSize(
              size: Size(225, 39),
              child: Material(
                color: const Color.fromRGBO(216, 185, 99, 1),
                borderRadius: BorderRadius.circular(7.0),
                child: InkWell(
                  onTap: () => signIn(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Ink.image(
                          image:
                              const AssetImage('assets/image/icon_google.png'),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        "從Google登入",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 20,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<GoogleSignInAccount?> signIn() async {
    final user = await GoogleSignInApi.signin();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("googleLogin");
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('從Google登入失敗'),
      ));
    } else {
      //先判斷上次是否登入過，if val != user.email => 新帳號 or 與上次登入之帳號不同
      if (val != user.email) {
        //判斷資料庫有無此帳號(帳號不一定等於Google登入時的mail)
        //if有 => 進行登入
        print("已登出或第一次開啟");
        //if無 => 註冊並前往初次設定資料
        memberRepository.createMember(
          Member(
            account: user.email,
            birthday: formatDate(date, [yyyy, '-', mm, '-', dd]).toString(),
            gender: 0,
            mail: user.email,
            name: user.displayName!,
            nickName: "",
            password: "",
          ),
        );
        pageRoute(user.email);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => FirstTime_editUserInfo(user: user)));
      } else {
        //val = user.email，無登出且與上次同帳號登入，直接前往主頁面
        print("已登入過，Google帳號:" + user.email);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    }
  }

  void pageRoute(String account) async {
    //儲存account shared preferences (後用來判斷此裝置是否登入過)
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("googleLogin", account);
  }

  void checkSelfLogin() async {
    //check if user already login or credential already available or not
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("selfLogin");
    if (val != null) {
      print("已登入過，帳號:" + val);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      print("已登出或第一次開啟");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login_selfacount()));
    }
  }
}
