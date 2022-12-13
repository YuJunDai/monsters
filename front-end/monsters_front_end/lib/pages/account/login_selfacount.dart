import 'dart:convert';
import 'dart:developer';

import 'package:adobe_xd/page_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monsters_front_end/main.dart';
import 'package:monsters_front_end/model/memberModel.dart';
import 'package:monsters_front_end/pages/account/forgetPassword/forget_psw_auth.dart';
import 'package:monsters_front_end/pages/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monsters_front_end/pages/account/login.dart';

import 'package:http/http.dart' as http;
import 'package:monsters_front_end/pages/account/signUp.dart';
import 'package:monsters_front_end/pages/settings/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/memberRepo.dart';

class Login_selfacount extends StatefulWidget {
  @override
  _Login_selfacountState createState() => _Login_selfacountState();
}

class _Login_selfacountState extends State<Login_selfacount> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final MemberRepository memberRepository = MemberRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfffffed4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //上一頁與註冊標題
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child:
                              // Adobe XD layer: 'Icon ionic-md-arrow…' (shape)
                              Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              top: 10,
                            ),
                            child: PageLink(
                              links: [
                                PageLinkInfo(
                                  transition: LinkTransition.Fade,
                                  ease: Curves.easeOut,
                                  duration: 0.3,
                                  pageBuilder: () => LoginPage(),
                                ),
                              ],
                              child: SvgPicture.string(
                                _svg_ryq30,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        //標題
                        const Center(
                          child: Text(
                            '登入',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 40,
                              color: Color.fromRGBO(160, 82, 45, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  //帳號
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    autofocus: false,
                    controller: _accountController,
                    decoration: const InputDecoration(
                      labelText: "帳號",
                      hintText: '請輸入帳號',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        ///設定邊框四個角的弧度
                        borderRadius: BorderRadius.all(Radius.circular(90)),

                        ///用來配置邊框的樣式
                        borderSide: BorderSide(
                          ///設定邊框的顏色
                          color: Color.fromRGBO(160, 82, 45, 1),
                          width: 2.0,
                        ),
                      ),
                      fillColor: Color.fromRGBO(255, 255, 255, 1),
                      filled: true,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z]|[0-9]")),
                    ],
                    validator: (value) {
                      if (value!.isNotEmpty &&
                          value.length > 5 &&
                          value.length < 21) {
                        return null;
                      } else if (value.isNotEmpty) {
                        return '帳號須為英數字混和6-20碼';
                      } else {
                        return '帳號不得空白';
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                  //密碼
                  TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _pwdController,
                      decoration: const InputDecoration(
                        labelText: "密碼",
                        hintText: '請輸入密碼',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(
                          ///設定邊框四個角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(90)),

                          ///用來配置邊框的樣式
                          borderSide: BorderSide(
                            ///設定邊框的顏色
                            color: Color.fromRGBO(160, 82, 45, 1),
                            width: 2.0,
                          ),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                      ),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z]|[0-9]")),
                      ],
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            value.length > 7 &&
                            value.length < 21) {
                          return null;
                        } else if (value.isEmpty) {
                          return '密碼不得空白';
                        } else {
                          return '密碼須為英數字混和8-20碼';
                        }
                      }),
                  const SizedBox(height: 30.0),
                  //忘記密碼
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Forget_password_Auth()));
                      },
                      child: const Text(
                        '忘記密碼',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 25,
                          color: Color.fromRGBO(160, 82, 45, 1),
                        ),
                      )),
                  const SizedBox(height: 20.0),
                  //登入
                  SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: RaisedButton(
                      color: const Color.fromRGBO(160, 82, 45, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      child: const Text(
                        '登入',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 30,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        softWrap: false,
                      ),
                      onPressed: () {
                        final isValidForm = _formKey.currentState!.validate();
                        if (isValidForm) {
                          login();
                        } else {
                          log("格式錯誤");
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  //註冊
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      child: const Text(
                        "沒有帳號嗎?  註冊",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 25,
                          color: Color.fromRGBO(160, 82, 45, 1),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    log("start login()...");
    log("try account: " + _accountController.text);
    log("try pass: " + _pwdController.text);
    final MemberRepository memberRepository = MemberRepository();
    var result = await memberRepository.login(Member(
        account: _accountController.text, password: _pwdController.text));
    if (result.contains("true")) {
      saveSelfLogin(_accountController.text);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: BackgroundColorWarm,
          content: Text(
            "登入失敗",
            style: TextStyle(color: Colors.white, fontSize: 30),
          )));
    }
  }

  void saveSelfLogin(String account) async {
    //儲存account shared preferences (後用來判斷此裝置是否登入過)
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("selfLogin", account);
    userAccount = account;
  }
}

const String _svg_ryq30 =
    '<svg viewBox="13.7 21.9 45.6 41.1" ><path transform="translate(8.07, 15.61)" d="M 47.28736877441406 22.92952919006348 L 19.54702568054199 22.92952919006348 L 30.30613327026367 13.09178352355957 C 31.84870529174805 11.54302215576172 31.84870529174805 9.040220260620117 30.30613327026367 7.491456031799316 C 28.76356315612793 5.942692756652832 26.26174545288086 5.942692756652832 24.70621109008789 7.491456031799316 L 6.791648864746094 24.09420013427734 C 6.013882637023926 24.81282615661621 5.624999046325684 25.79164695739746 5.624999046325684 26.86958694458008 L 5.624999046325684 26.91914939880371 C 5.624999046325684 27.99708938598633 6.013882637023926 28.97590446472168 6.791648864746094 29.69453430175781 L 24.69325065612793 46.29727935791016 C 26.24878120422363 47.84604263305664 28.75060272216797 47.84604263305664 30.29317092895508 46.29727935791016 C 31.83573913574219 44.74851226806641 31.83573913574219 42.2457160949707 30.29317092895508 40.69694900512695 L 19.5340633392334 30.85920524597168 L 47.27440643310547 30.85920524597168 C 49.46512222290039 30.85920524597168 51.24102020263672 29.08742141723633 51.24102020263672 26.89437294006348 C 51.25398254394531 24.66414642333984 49.47808074951172 22.92952919006348 47.28736877441406 22.92952919006348 Z" fill="#ffbb00" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';