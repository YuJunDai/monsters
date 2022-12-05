// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_const_constructors

import 'dart:async';
import 'dart:math';
import 'dart:developer' as dv;
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monsters_front_end/model/annoyanceModel.dart';
import 'package:monsters_front_end/pages/annoyanceChat.dart';
import 'package:monsters_front_end/pages/history/history_diaryChat.dart';
import 'package:monsters_front_end/pages/settings/monsters_information.dart';
import 'package:monsters_front_end/pages/diaryChat.dart';
import 'package:monsters_front_end/pages/history/history_annoyanceChat.dart';
import 'package:monsters_front_end/pages/home.dart';
import 'package:monsters_front_end/pages/interaction.dart';
import 'package:monsters_front_end/pages/manual/manual.dart';
import 'package:monsters_front_end/pages/history/moodLineChart.dart';
import 'package:monsters_front_end/pages/social.dart';
import 'package:monsters_front_end/pages/settings/style.dart';
import 'package:monsters_front_end/repository/historyRepo.dart';
import 'package:monsters_front_end/state/drawer.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  //新增的浮出按鈕動畫用
  late AnimationController animationController;
  late Animation degOneTranslationAnimation, degTwoTranslationAnimation;
  late Animation rotationAnimation;
  StateSetter? animationState;

  //控制標籤
  //1:全部 2:煩惱 3:日記
  int selectionTab_type = 1;
  //當selectedSolve開啟已解決標籤
  int selectionTab_solve = 0;
  //當selectionTab_solve_enabled解鎖後兩個標籤
  bool selectionTab_solve_enabled = false;

  late Future _future;
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKEy = GlobalKey<ScaffoldState>();
    _future = getHistoryMapByAccount();
    setState(() {});
    //TODO: Level 1
    //計算不同歷史類別的數量
    /*
    int itemCounter 
    int annoyanceCounter 
    int diaryCounter 

    iterate the History and doing so =>
    itemCounter:
      在搜尋到一個History時加一，計算總數
    annoyanceCounter & diaryCounter:
      在搜尋到一個History後annoyance時++，否則diaryCounter++
    */

    //畫面呈現
    return Scaffold(
      backgroundColor: const Color(0xfffffed4),
      endDrawer: GetDrawer(context),
      key: _scaffoldKEy,
      body: Stack(
        children: <Widget>[
          //抽屜
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              iconSize: 60.0,
              icon: const Icon(Icons.menu_rounded),
              color: const Color(0xffffbb00),
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 5),
              onPressed: () => _scaffoldKEy.currentState?.openEndDrawer(),
            ),
          ),
          //整體布局
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //標題 完成
              Expanded(
                  flex: 10,
                  child: Stack(children: [
                    mainAppBarTitleContainer("歷史記錄"),
                    GestureDetector(
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 0, 15),
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: BackgroundColorWarm,
                                  width: 2,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/image/barChart.png'),
                                    fit: BoxFit.scaleDown,
                                  ),
                                )),
                          )),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoodLineChart())),
                    ),
                  ])),
              //標籤
              Expanded(
                  flex: 5,
                  child: Center(
                      child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Wrap(
                      spacing: 7,
                      //標籤設定
                      children: [
                        //全部標籤  selectionTab_type == 1
                        InkWell(
                            child: Container(
                              width: 50,
                              decoration: BoxDecoration(
                                color: selectionTab_type == 1
                                    ? const Color(0xffa0522d)
                                    : const Color(0xffffed97),
                                borderRadius: const BorderRadius.all(
                                    Radius.elliptical(9999.0, 9999.0)),
                              ),
                              child: Text(
                                '全部',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 20,
                                    color: selectionTab_type == 1 //點按後更新文字顏色
                                        ? const Color(0xffffffff)
                                        : const Color(0xffa0522d)),
                              ),
                            ),
                            onTap: () {
                              if (selectionTab_type != 1) {
                                selectionTab_type = 1;
                                selectionTab_solve_enabled = false;
                                selectionTab_solve = 0;
                                setState(() {});
                              }
                            }),
                        //煩惱標籤 selectionTab_type == 2
                        InkWell(
                            child: Container(
                              width: 50,
                              decoration: BoxDecoration(
                                color: selectionTab_type == 2
                                    ? const Color(0xffa0522d)
                                    : const Color(0xffffed97),
                                borderRadius: const BorderRadius.all(
                                    Radius.elliptical(100.0, 100.0)),
                              ),
                              child: Text(
                                '煩惱',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 20,
                                    color: selectionTab_type == 2 //點按後更新文字顏色
                                        ? const Color(0xffffffff)
                                        : const Color(0xffa0522d)),
                              ),
                            ),
                            onTap: () {
                              if (selectionTab_type != 2) {
                                selectionTab_type = 2;
                                selectionTab_solve_enabled = true;
                                selectionTab_solve = 1;
                                setState(() {});
                              }
                            }),
                        //日記標籤 selectionTab_type == 3
                        InkWell(
                            child: Container(
                              width: 50,
                              decoration: BoxDecoration(
                                color: selectionTab_type == 3
                                    ? const Color(0xffa0522d)
                                    : const Color(0xffffed97),
                                borderRadius: const BorderRadius.all(
                                    Radius.elliptical(100.0, 100.0)),
                              ),
                              child: Text(
                                '日記',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 20,
                                    color: selectionTab_type == 3 //點按後更新文字顏色
                                        ? const Color(0xffffffff)
                                        : const Color(0xffa0522d)),
                              ),
                            ),
                            onTap: () {
                              if (selectionTab_type != 3) {
                                
                              
                                selectionTab_type = 3;
                                selectionTab_solve_enabled = false;
                                selectionTab_solve = 0;
                                setState(() {
                              });
                              }
                            }),
                        //未解決標籤 selectionTab_solve == 1
                        InkWell(
                            child: Container(
                              width: 70,
                              decoration: BoxDecoration(
                                color: selectionTab_solve == 1
                                    ? const Color(0xffa0522d)
                                    : const Color(0xffffed97),
                                borderRadius: const BorderRadius.all(
                                    Radius.elliptical(100.0, 100.0)),
                              ),
                              child: Text(
                                '未解決',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 20,
                                    color: selectionTab_solve == 1 //點按後更新文字顏色
                                        ? const Color(0xffffffff)
                                        : const Color(0xffa0522d)),
                              ),
                            ),
                            onTap: () {
                              if (selectionTab_solve_enabled == true &&
                                  selectionTab_solve != 1) {
                                selectionTab_solve = 1;
                                setState(() {});
                              }
                            }),
                        //已解決標籤 selectionTab_solve == 2
                        InkWell(
                            child: Container(
                              width: 70,
                              decoration: BoxDecoration(
                                color: selectionTab_solve == 2
                                    ? const Color(0xffa0522d)
                                    : const Color(0xffffed97),
                                borderRadius: const BorderRadius.all(
                                    Radius.elliptical(100.0, 100.0)),
                              ),
                              child: Text(
                                '已解決',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 20,
                                    color: selectionTab_solve == 2 //點按後更新文字顏色
                                        ? const Color(0xffffffff)
                                        : const Color(0xffa0522d)),
                              ),
                            ),
                            onTap: () {
                              if (selectionTab_solve_enabled == true &&
                                  selectionTab_solve != 2) {
                                selectionTab_solve = 2;
                                setState(() {});
                              }
                            }),
                      ],
                    ),
                  ))),
              //歷史清單
              Expanded(
                  flex: 75,
                  child: FutureBuilder<dynamic>(
                      future: _future,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                              child: Text(
                            "Loading...",
                            style: TextStyle(fontSize: 30),
                          ));
                        }
                        return ListView.builder(
                          itemCount: snapshot.data["itemCounter"],
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                width: 1.0,
                                color: BackgroundColorWarm,
                              )),
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              height: 180,
                              alignment: Alignment.center,
                              child: ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(vertical: 3),
                                  leading: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xffa0522d)),
                                    ),
                                    child: CircleAvatar(
                                      minRadius: 40,
                                      backgroundImage: AssetImage(
                                          getMonsterAvatarPath(monsterNamesList[
                                              snapshot.data["result $index"]
                                                  ["monsterId"]])),
                                      child: (snapshot.data["result $index"]
                                                  ["solve"] ==
                                              1)
                                          ? Container(
                                              alignment: Alignment.bottomRight,
                                              child: CircleAvatar(
                                                radius: 13,
                                                backgroundImage: AssetImage(
                                                    'assets/image/done.png'),
                                              ),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                  title: Text(
                                    snapshot.data["result $index"]["content"],
                                    style: TextStyle(fontSize: BodyTextSize),
                                    textAlign: TextAlign.left,
                                  ),
                                  trailing: (snapshot.data["result $index"]
                                                  ["type"]
                                              .toString()
                                              .length <
                                          1)
                                      ? Container(
                                          width: 55,
                                          child: Center(
                                            child: Text(
                                              snapshot.data["result $index"]
                                                      ["time"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: BackgroundColorWarm),
                                            ),
                                          ),
                                        )
                                      : Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                                flex: 59,
                                                child: Container(
                                                  width: 55,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 174, 108, 32),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.elliptical(
                                                                10.0, 10.0)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      snapshot
                                                          .data["result $index"]
                                                              ["type"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)),
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 5,
                                              child: SizedBox(),
                                            ),
                                            Expanded(
                                              flex: 39,
                                              child: Container(
                                                width: 55,
                                                child: Center(
                                                  child: Text(
                                                      snapshot
                                                          .data["result $index"]
                                                              ["time"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              BackgroundColorWarm)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  onTap: () async {
                                    if (snapshot.data["result $index"]
                                            ["solve"] !=
                                        null) {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  historyAnnoyanceChat(
                                                      data: snapshot.data[
                                                          "result $index"])));
                                    } else {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  historyDiaryChat(
                                                      data: snapshot.data[
                                                          "result $index"])));
                                    }

                                    setState(() {});
                                  }),
                            ),
                          ),
                        );
                      })),
              //底部
              Expanded(
                  flex: 10,
                  child: Container(
                    color: BackgroundColorSoft,
                  )),
            ],
          ),
          //互動
          Pinned.fromPins(
            Pin(size: 69.0, start: 9.0),
            Pin(size: 68.0, end: 5.0),
            child:
                // Adobe XD layer: 'interactive' (group)
                PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => InteractionPage(),
                ),
              ],
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      // color: BackgroundColorWarm,
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 24.0, middle: 0.5111),
                    Pin(size: 16.0, end: 9.0),
                    child: Text(
                      '互動',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 12,
                        color: const Color(0xffa0522d),
                        //color: Colors.white,
                      ),
                      softWrap: false,
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.008, -0.415),
                    child: SizedBox(
                      width: 29.0,
                      height: 29.0,
                      child:
                          // Adobe XD layer: 'Icon material-gamep…' (shape)
                          SvgPicture.string(
                        _svg_a3julx,
                        // color:Colors.white,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //圖鑑
          Pinned.fromPins(
            Pin(size: 69.0, middle: 0.2624),
            Pin(size: 68.0, end: 5.0),
            child:
                // Adobe XD layer: 'book' (group)
                PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => Manual(),
                ),
              ],
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.015, -0.398),
                    child: SizedBox(
                      width: 24.0,
                      height: 27.0,
                      child:
                          // Adobe XD layer: 'Icon awesome-book' (shape)
                          SvgPicture.string(
                        _svg_i02mi2,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 24.0, middle: 0.4889),
                    Pin(size: 16.0, end: 9.0),
                    child: Text(
                      '圖鑑',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 12,
                        color: const Color(0xffa0522d),
                      ),
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //歷史記錄
          Pinned.fromPins(
            Pin(size: 69.0, middle: 0.7347),
            Pin(size: 68.0, end: 5.0),
            child:
                // Adobe XD layer: 'book' (group)
                PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => MainPage(),
                ),
              ],
              child:
                  // Adobe XD layer: 'history' (group)
                  Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: BackgroundColorWarm,
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 48.0, end: 9.0),
                    Pin(size: 16.0, end: 9.0),
                    child: Text(
                      '歷史記錄',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 12,
                          color: Colors.white),
                      softWrap: false,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.073, -0.408),
                    child: SizedBox(
                      width: 28.0,
                      height: 28.0,
                      child:
                          // Adobe XD layer: 'Icon awesome-history' (shape)
                          SvgPicture.string(
                        _svg_uat9w,
                        color: Colors.white,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //社群
          Pinned.fromPins(
            Pin(size: 69.0, end: 10.0),
            Pin(size: 68.0, end: 5.0),
            child:
                // Adobe XD layer: 'social' (group)
                PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => Social(),
                ),
              ],
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 24.0, middle: 0.5111),
                    Pin(size: 16.0, end: 9.0),
                    child: Text(
                      '社群',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 12,
                        color: const Color(0xffa0522d),
                      ),
                      softWrap: false,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(start: 17.0, end: 17.0),
                    Pin(size: 22.3, middle: 0.3217),
                    child:
                        // Adobe XD layer: 'Icon material-people' (shape)
                        SvgPicture.string(
                      _svg_kzt9m,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //新增
          Pinned.fromPins(
            Pin(size: 150.0, middle: 0.5),
            Pin(size: 150.0, end: 5.0),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              animationState = setState;
              return Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Positioned(
                      child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      IgnorePointer(
                        child: Container(
                          color: Colors.transparent,
                          height: 150.0,
                          width: 150.0,
                        ),
                      ),
                      Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value)),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          width: 70,
                          height: 70,
                          icon: const Icon(
                            Icons.add_rounded,
                            color: Color.fromRGBO(255, 187, 0, 1),
                            size: 50,
                          ),
                          onClick: () {
                            if (animationController.isCompleted) {
                              animationController.reverse();
                            } else {
                              animationController.forward();
                              animationController.addListener(() {
                                animationState!(() {});
                              });
                            }
                          },
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(235),
                            degOneTranslationAnimation.value * 80),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degOneTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            color: Colors.blueAccent,
                            width: 70,
                            height: 70,
                            icon: const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.white,
                              size: 40,
                            ),
                            onClick: () {
                              animationController.reverse();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AnnoyanceChat()));
                            },
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(305),
                            degTwoTranslationAnimation.value * 80),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degTwoTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            color: Colors.orangeAccent,
                            width: 70,
                            height: 70,
                            icon: const Icon(
                              Icons.import_contacts,
                              color: Colors.white,
                              size: 40,
                            ),
                            onClick: () {
                              animationController.reverse();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => diaryChat()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<Map> getHistoryMapByAccount() async {
    //1:全部 2:煩惱 3:日記
    //selectionTab_type = 1;
    int type = 1;
    final HistoryRepository historyRepository = HistoryRepository();
    if (selectionTab_type == 2) {
      if (selectionTab_solve == 1) {
        type = 4;
      }
      if (selectionTab_solve == 2) {
        type = 5;
      }
    }
    if (selectionTab_type == 3) {
      type = selectionTab_type;
    }

    Future<Data> histories = historyRepository
        .searchHistoryByType(type)
        .then((value) => Data.fromJson(value!));
    Map historyResult = {};

    await histories.then((value) async {
      await historyResult.putIfAbsent(
        "itemCounter",
        () => min(value.data.length, 20),
      );

      for (int index = 0; index < min(value.data.length, 20); index++) {
        String type = "";
        switch (value.data.elementAt(index).type) {
          case 1:
            type = "課業";
            break;
          case 2:
            type = "事業";
            break;
          case 3:
            type = "愛情";
            break;
          case 4:
            type = "友情";
            break;
          case 5:
            type = "親情";
            break;
          case 6:
            type = "其他";
            break;
          default:
            break;
        }

        historyResult.putIfAbsent(
          "result $index",
          () => {
            'id': value.data.elementAt(index).id,
            'avatar': value.data.elementAt(index).monsterId,
            'content': value.data.elementAt(index).content,
            'type': type,
            'monsterId': value.data.elementAt(index).monsterId,
            'time': value.data.elementAt(index).time,
            'solve': value.data.elementAt(index).solve?.toInt(),
            'mood': value.data.elementAt(index).mood,
            'index': value.data.elementAt(index).index,
            'share': value.data.elementAt(index).share,
          },
        );
      }
    });
    return historyResult;
  }

  //介面設計
  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  //初始化
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    _future = getHistoryMapByAccount();
    super.initState();
  }

  //關閉
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final void Function() onClick;

  CircularButton(
      {required this.color,
      required this.width,
      required this.height,
      required this.icon,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, onPressed: onClick, enableFeedback: true),
    );
  }
}

const String _svg_i02mi2 =
    '<svg viewBox="112.3 717.3 23.7 27.1" ><path transform="translate(112.33, 717.32)" d="M 23.66897201538086 19.01971054077148 L 23.66897201538086 1.267980933189392 C 23.66897201538086 0.5653080940246582 23.10366439819336 0 22.40099143981934 0 L 5.071923732757568 0 C 2.271798849105835 0 0 2.271798849105835 0 5.071923732757568 L 0 21.97833633422852 C 0 24.7784595489502 2.271798849105835 27.05025482177734 5.071923732757568 27.05025482177734 L 22.40099143981934 27.05025482177734 C 23.10366439819336 27.05025482177734 23.66897201538086 26.48495101928711 23.66897201538086 25.78227424621582 L 23.66897201538086 24.93695259094238 C 23.66897201538086 24.54071044921875 23.48405838012695 24.18144989013672 23.19876289367676 23.94898414611816 C 22.97686576843262 23.13536262512207 22.97686576843262 20.81601715087891 23.19876289367676 20.00239562988281 C 23.48405838012695 19.77521514892578 23.66897201538086 19.41595458984375 23.66897201538086 19.01971054077148 Z M 6.762563705444336 7.079558849334717 C 6.762563705444336 6.905211925506592 6.905211925506592 6.762563705444336 7.079558849334717 6.762563705444336 L 18.28005599975586 6.762563705444336 C 18.45440292358398 6.762563705444336 18.59705352783203 6.905211925506592 18.59705352783203 7.079558849334717 L 18.59705352783203 8.136210441589355 C 18.59705352783203 8.310558319091797 18.45440292358398 8.453206062316895 18.28005599975586 8.453206062316895 L 7.079558849334717 8.453206062316895 C 6.905211925506592 8.453206062316895 6.762563705444336 8.310558319091797 6.762563705444336 8.136210441589355 L 6.762563705444336 7.079558849334717 Z M 6.762563705444336 10.46084022521973 C 6.762563705444336 10.28649425506592 6.905211925506592 10.14384746551514 7.079558849334717 10.14384746551514 L 18.28005599975586 10.14384746551514 C 18.45440292358398 10.14384746551514 18.59705352783203 10.28649425506592 18.59705352783203 10.46084022521973 L 18.59705352783203 11.51749134063721 C 18.59705352783203 11.69183731079102 18.45440292358398 11.83448600769043 18.28005599975586 11.83448600769043 L 7.079558849334717 11.83448600769043 C 6.905211925506592 11.83448600769043 6.762563705444336 11.69183731079102 6.762563705444336 11.51749134063721 L 6.762563705444336 10.46084022521973 Z M 20.15032768249512 23.66897201538086 L 5.071923732757568 23.66897201538086 C 4.136787414550781 23.66897201538086 3.381281852722168 22.9134693145752 3.381281852722168 21.97833633422852 C 3.381281852722168 21.04848289489746 4.142070293426514 20.28769493103027 5.071923732757568 20.28769493103027 L 20.15032768249512 20.28769493103027 C 20.04994583129883 21.19112586975098 20.04994583129883 22.76553916931152 20.15032768249512 23.66897201538086 Z" fill="#a0522d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_uat9w =
    '<svg viewBox="274.0 716.8 28.0 28.0" ><path transform="translate(273.42, 716.27)" d="M 28.59882354736328 14.55415153503418 C 28.61312294006348 22.27770614624023 22.31439018249512 28.59333992004395 14.59083652496338 28.59876823425293 C 11.2550220489502 28.60114097595215 8.190923690795898 27.43831253051758 5.783022880554199 25.49493217468262 C 5.156896591186523 24.98960113525391 5.11009407043457 24.05123138427734 5.679073333740234 23.48225212097168 L 6.315938949584961 22.84538459777832 C 6.802560806274414 22.35876274108887 7.579439163208008 22.30551719665527 8.118572235107422 22.73324012756348 C 9.892602920532227 24.1409912109375 12.13771438598633 24.98123359680176 14.58066082000732 24.98123359680176 C 20.32952117919922 24.98123359680176 24.98123359680176 20.32861709594727 24.98123359680176 14.58066082000732 C 24.98123359680176 8.831802368164062 20.32861709594727 4.180089950561523 14.58066082000732 4.180089950561523 C 11.821457862854 4.180089950561523 9.315427780151367 5.252309799194336 7.454687118530273 7.002488136291504 L 10.32354831695557 9.871350288391113 C 10.89331912994385 10.44112014770508 10.48978805541992 11.41526985168457 9.684082984924316 11.41526985168457 L 1.466897487640381 11.41526985168457 C 0.9673874974250793 11.41526985168457 0.5625 11.0103816986084 0.5625 10.51087188720703 L 0.5625 2.293686389923096 C 0.5625 1.48798131942749 1.536649227142334 1.084450483322144 2.106419563293457 1.654164433479309 L 4.897163391113281 4.44490909576416 C 7.413819313049316 2.039833307266235 10.82469844818115 0.5625 14.58066082000732 0.5625 C 22.3138256072998 0.5625 28.58452033996582 6.824322700500488 28.59882354736328 14.55415153503418 Z M 18.37280082702637 19.00740432739258 L 18.92804336547852 18.29349708557129 C 19.38804244995117 17.70207786560059 19.281494140625 16.84973907470703 18.6900749206543 16.38979530334473 L 16.38945770263672 14.6003885269165 L 16.38945770263672 8.70207691192627 C 16.38945770263672 7.952840805053711 15.78209590911865 7.345480918884277 15.03285980224609 7.345480918884277 L 14.12846183776855 7.345480918884277 C 13.379225730896 7.345480918884277 12.77186584472656 7.952840805053711 12.77186584472656 8.70207691192627 L 12.77186584472656 16.36972808837891 L 16.46910095214844 19.2453727722168 C 17.06052017211914 19.7053165435791 17.91280174255371 19.59882354736328 18.372802734375 19.00740432739258 Z" fill="#a0522d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_kzt9m =
    '<svg viewBox="350.0 719.7 35.0 22.3" ><path transform="translate(348.5, 712.21)" d="M 25.36363410949707 17.04545402526855 C 28.00454330444336 17.04545402526855 30.12045288085938 14.91363525390625 30.12045288085938 12.27272701263428 C 30.12045288085938 9.631818771362305 28.00454330444336 7.499999523162842 25.36363410949707 7.499999523162842 C 22.72272491455078 7.499999523162842 20.59090614318848 9.631818771362305 20.59090614318848 12.27272701263428 C 20.59090614318848 14.91363525390625 22.72272491455078 17.04545402526855 25.36363410949707 17.04545402526855 Z M 12.63636302947998 17.04545402526855 C 15.27727127075195 17.04545402526855 17.39318084716797 14.91363525390625 17.39318084716797 12.27272701263428 C 17.39318084716797 9.631818771362305 15.27727127075195 7.499999523162842 12.63636302947998 7.499999523162842 C 9.995454788208008 7.499999523162842 7.863636016845703 9.631818771362305 7.863636016845703 12.27272701263428 C 7.863636016845703 14.91363525390625 9.995454788208008 17.04545402526855 12.63636302947998 17.04545402526855 Z M 12.63636302947998 20.22727012634277 C 8.929545402526855 20.22727012634277 1.49999988079071 22.0886344909668 1.49999988079071 25.79545211791992 L 1.49999988079071 29.77272605895996 L 23.77272605895996 29.77272605895996 L 23.77272605895996 25.79545211791992 C 23.77272605895996 22.08863639831543 16.34317970275879 20.22727012634277 12.63636302947998 20.22727012634277 Z M 25.36363410949707 20.22727012634277 C 24.90227127075195 20.22727012634277 24.37726974487305 20.25909042358398 23.8204517364502 20.30681800842285 C 25.66590690612793 21.64318084716797 26.95454216003418 23.44090843200684 26.95454216003418 25.79545211791992 L 26.95454216003418 29.77272605895996 L 36.5 29.77272605895996 L 36.5 25.79545211791992 C 36.5 22.08863639831543 29.0704517364502 20.22727012634277 25.36363410949707 20.22727012634277 Z" fill="#a0522d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_a3julx =
    '<svg viewBox="29.0 716.5 28.7 28.7" ><path transform="translate(26.0, 713.51)" d="M 21.6403694152832 10.88630962371826 L 21.6403694152832 3 L 13.03712177276611 3 L 13.03712177276611 10.88630962371826 L 17.3387451171875 15.18793296813965 L 21.6403694152832 10.88630962371826 Z M 10.88630962371826 13.03712177276611 L 3 13.03712177276611 L 3 21.6403694152832 L 10.88630962371826 21.6403694152832 L 15.18793296813965 17.3387451171875 L 10.88630962371826 13.03712177276611 Z M 13.03712177276611 23.79118156433105 L 13.03712177276611 31.677490234375 L 21.6403694152832 31.677490234375 L 21.6403694152832 23.79118156433105 L 17.3387451171875 19.48955726623535 L 13.03712177276611 23.79118156433105 Z M 23.79118156433105 13.03712177276611 L 19.48955726623535 17.3387451171875 L 23.79118156433105 21.6403694152832 L 31.677490234375 21.6403694152832 L 31.677490234375 13.03712177276611 L 23.79118156433105 13.03712177276611 Z" fill="#a0522d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
