import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class new_fastTest6 extends StatelessWidget {
  new_fastTest6({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffed4),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 235.0, middle: 0.5028),
            Pin(size: 63.0, start: 11.0),
            child: Text(
              '與動物相處',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 47,
                color: const Color(0xffa0522d),
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 45.6, start: 13.7),
            Pin(size: 41.1, start: 21.9),
            child:
                // Adobe XD layer: 'Icon ionic-md-arrow…' (shape)
                SvgPicture.string(
              _svg_ryq30,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 25.0, end: 24.0),
            Pin(size: 344.0, start: 90.0),
            child: SingleChildScrollView(
              primary: false,
              child: Text(
                '和動物相處絕對是減輕壓力很棒的方法。不僅能增加你的笑容，而且研究發現，會觸發身體分泌讓人感覺舒服的「催產素」，能夠降血壓、舒緩緊張情緒。\n沒有寵物怎麼辦？看看網路上的動物趣味短片，也能有類似效果。\n',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 27,
                  color: const Color(0xffa0522d),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 17.0, end: 17.0),
            Pin(size: 253.0, end: 80.0),
            child:
                // Adobe XD layer: 'maxresdefault (1)' (shape)
                Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assetstemp/animal video.jpg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.534),
            child: SizedBox(
              width: 77.0,
              height: 77.0,
              child:
                  // Adobe XD layer: 'Icon feather-play-c…' (group)
                  Stack(
                children: <Widget>[
                  SizedBox.expand(
                      child: SvgPicture.string(
                    _svg_dgox10,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  )),
                  Align(
                    alignment: Alignment(0.135, 0.0),
                    child: SizedBox(
                      width: 23.0,
                      height: 31.0,
                      child: SvgPicture.string(
                        _svg_uq0zys,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                ],
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
const String _svg_dgox10 =
    '<svg viewBox="2.9 2.7 77.1 77.4" ><path transform="translate(-0.09, -0.32)" d="M 80.11366271972656 41.72328567504883 C 80.11366271972656 63.10957717895508 62.8511848449707 80.44658660888672 41.55683135986328 80.44658660888672 C 20.26248168945312 80.44658660888672 3.000000715255737 63.10957717895508 3.000000715255737 41.72328567504883 C 3.000000715255737 20.33700752258301 20.26248168945312 3.000000715255737 41.55683135986328 3.000000715255737 C 62.8511848449707 3.000000715255737 80.11366271972656 20.33700752258301 80.11366271972656 41.72328567504883 Z" fill="none" stroke="#ffffff" stroke-width="5" stroke-linecap="square" stroke-linejoin="round" /></svg>';
const String _svg_uq0zys =
    '<svg viewBox="33.6 26.1 23.0 30.6" ><path transform="translate(18.65, 14.1)" d="M 15 12.00000286102295 L 37.95497894287109 27.30331802368164 L 15 42.60663604736328 L 15 12.00000286102295 Z" fill="none" stroke="#ffffff" stroke-width="5" stroke-linecap="square" stroke-linejoin="round" /></svg>';
