
import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:monsters_front_end/model/answerbookModel.dart';
import 'package:monsters_front_end/pages/settings/style.dart';
import 'package:monsters_front_end/repository/answerBookRepo.dart';

class AnswerbookPage extends StatefulWidget {
  @override
  _AnswerbookPageState createState() => _AnswerbookPageState();
}

class _AnswerbookPageState extends State<AnswerbookPage> {
  final AnswerbookRepository answerbookRepository = AnswerbookRepository();
  String answer = '歡迎來到解答之書，請\n閉上眼睛並深呼吸，心\n中想著現在的煩惱或疑\n問，準備好就可以按下\n解答的按鈕獲得答案。';
  bool pressed = false;
  Future<Answerbook> getAnswer() {
    Future<Answerbook> answers = answerbookRepository
        .searchAnswerbook()
        .then((value) => Answerbook.fromMap(value));
    return answers;
  }

  @override
  Widget build(BuildContext context) {
    getAnswer().then((value) => answer = value.content);
    return Scaffold(
      backgroundColor: BackgroundColorLight,
      appBar: secondAppBar("解答之書"),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    const AssetImage('assets/image/background_answerBook.png'),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.45), BlendMode.dstIn),
              ),
            ),
          ),
          //取得解答按鈕
          Pinned.fromPins(
            Pin(size: 136.0, middle: 0.5),
            Pin(size: 64.0, end: 73.0),
            child: Stack(
              children: <Widget>[
                //解答按鈕
                Pinned.fromPins(
                  Pin(size: 136.0, middle: 0.5),
                  Pin(size: 64.0, end: 73.0),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    color: const Color.fromRGBO(255, 237, 151, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999.0)),
                    onPressed: () {
                      pressed = true;
                      setState(() {
                        Future<Answerbook> answers = getAnswer();
                        answers.then((value) => answer = value.content);
                      });
                    },
                    //是否第一次按(按鈕文字)
                    child: pressed == false
                        ? const Text(
                            '解答',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 30,
                              color: Color(0xffa0522d),
                            ),
                            softWrap: false,
                          )
                        : const Text(
                            '再一次',
                            style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 30,
                              color: Color(0xffa0522d),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          //提示框
          Pinned.fromPins(
            Pin(start: 32.0, end: 31.0),
            Pin(size: 251.0, middle: 0.32),
            child: Container(
              color: const Color(0xc9ffffff),
            ),
          ),
          //是否第一次按(提示框內容再次取得解答)
          pressed == false
              ? Pinned.fromPins(
                  Pin(start: 52.0, end: 52.0), Pin(size: 185.0, middle: 0.34),
                  child: Center(
                    child: Text(
                      answer,
                      style: const TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 25,
                        color: Color(0xffa0522d),
                      ),
                      softWrap: false,
                    ),
                  ))
              : Pinned.fromPins(
                  Pin(start: 50.0, end: 50.0), Pin(size: 185.0, middle: 0.35),
                  child: Center(
                    child: Text(
                      answer,
                      style: const TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 27,
                        color: BackgroundColorWarm,
                      ),
                      softWrap: false,
                    ),
                  )),
          //書圖
          Pinned.fromPins(
            Pin(start: 64.0, end: 64.0),
            Pin(size: 154.0, middle: 0.726),
            child:
                // Adobe XD layer: 'book-png-transparen…' (shape)
                Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/image/background_answerBook_logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_ryq30 =
    '<svg viewBox="13.7 21.9 45.6 41.1" ><path transform="translate(8.07, 15.61)" d="M 47.28736877441406 22.92952919006348 L 19.54702568054199 22.92952919006348 L 30.30613327026367 13.09178352355957 C 31.84870529174805 11.54302215576172 31.84870529174805 9.040220260620117 30.30613327026367 7.491456031799316 C 28.76356315612793 5.942692756652832 26.26174545288086 5.942692756652832 24.70621109008789 7.491456031799316 L 6.791648864746094 24.09420013427734 C 6.013882637023926 24.81282615661621 5.624999046325684 25.79164695739746 5.624999046325684 26.86958694458008 L 5.624999046325684 26.91914939880371 C 5.624999046325684 27.99708938598633 6.013882637023926 28.97590446472168 6.791648864746094 29.69453430175781 L 24.69325065612793 46.29727935791016 C 26.24878120422363 47.84604263305664 28.75060272216797 47.84604263305664 30.29317092895508 46.29727935791016 C 31.83573913574219 44.74851226806641 31.83573913574219 42.2457160949707 30.29317092895508 40.69694900512695 L 19.5340633392334 30.85920524597168 L 47.27440643310547 30.85920524597168 C 49.46512222290039 30.85920524597168 51.24102020263672 29.08742141723633 51.24102020263672 26.89437294006348 C 51.25398254394531 24.66414642333984 49.47808074951172 22.92952919006348 47.28736877441406 22.92952919006348 Z" fill="#ffbb00" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';


