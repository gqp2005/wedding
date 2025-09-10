import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui; // *** 핵심: dart:ui_web ***  (dart:ui 아님!)

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final API_KEY = "AIzaSyCVpKms5coyp5-grw1P5eXgDjpJi6JRc1I"; // API KEY를 넣어주세요

  Widget getMap() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('iframe', (int viewId) {
      var iframe = html.IFrameElement();
      iframe.src = 'https://www.google.com/maps/embed/v1/place?key=$API_KEY&q=place_id:ChIJ60eAfhyZfDUR4xiU955RgF4'; // embedded google map url
      return iframe;
    });

    return const HtmlElementView(viewType: 'iframe');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsetsDirectional.all(20.0),
        child: Column(
          children: [
            const Text('오시는 길',
                style: TextStyle(
                    color: Color.fromRGBO(41, 82, 56, 100),
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.5,
              child: getMap(),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '신라스테이 마포, \n2층 카페',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SelectableText(
                        '서울 마포구 마포대로 83',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      tooltip: '주소 복사',
                      onPressed: () async {
                        const address = '서울 마포구 마포대로 83';
                        await Clipboard.setData(const ClipboardData(text: address));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('주소가 복사되었습니다')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}