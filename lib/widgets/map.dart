import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
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

  Future<void> _launchMap() async {
    final uri = Uri.parse('https://m.map.naver.com/map?lat=37.5428524&lng=126.9497086&dlevel=20&mapMode=&pinTitle=%EC%8B%A0%EB%9D%BC%EC%8A%A4%ED%85%8C%EC%9D%B4%20%EB%A7%88%ED%8F%AC&boundary=&traffic=');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('지도를 열 수 없습니다')));
    }
  }

  Future<void> _callPhone() async {
    final uri = Uri(scheme: 'tel', path: '02-6979-9108');
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('전화 연결을 할 수 없습니다')));
    }
  }

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
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _launchMap,
                      icon: const Icon(Icons.location_on, color: Color(0xFF274B2E)),
                      label: const Text('지도', style: TextStyle(color: Color(0xFF274B2E))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        side: const BorderSide(color: Color(0xFF274B2E), width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: _callPhone,
                      icon: const Icon(Icons.phone, color: Color(0xFF274B2E)),
                      label: const Text('전화', style: TextStyle(color: Color(0xFF274B2E))),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFF274B2E), width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}