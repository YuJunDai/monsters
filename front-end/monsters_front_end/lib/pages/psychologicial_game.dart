import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Psychologicial_game extends StatefulWidget {
  @override
  _Psychologicial_gameState createState() => _Psychologicial_gameState();
}

class _Psychologicial_gameState extends State<Psychologicial_game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('心理小遊戲')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () => launch(
                'https://girlstyle.com/tw/article/278283/%E5%BF%83%E7%90%86%E6%B8%AC%E9%A9%97-%E4%BA%BA%E6%A0%BC-%E6%BD%9B%E6%84%8F%E8%AD%98-%E6%A3%AE%E6%9E%97-%E5%B0%8F%E6%9C%A8%E5%B1%8B-%E8%8A%B1-%E5%8B%95%E7%89%A9-%E5%80%8B%E6%80%A7'),
            child: new Text('森林'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
            ),
          ),
          TextButton(
            onPressed: () => launch(
                'https://m.click108.com.tw/psychictest/index.php?PT_Type=L'),
            child: new Text('愛情'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
            ),
          ),
          TextButton(
            onPressed: () => launch('https://www.popdaily.com.tw/korea/741531'),
            child: new Text('煩惱'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
            ),
          ),
          TextButton(
            onPressed: () => launch('https://www.beauty321.com/post/47206'),
            child: new Text('社交'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ],
      ),
    );
  }
}
