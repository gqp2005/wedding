import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Introduction extends StatelessWidget {

  const Introduction({super.key});



  Widget _buildName(String father, mother, order, name) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(father, style: const TextStyle(fontSize: 15)),
            Text(mother, style: const TextStyle(fontSize: 15)),
          ],
        ),
        Text('  의 $order  '),
        Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsetsDirectional.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Image.asset(
                'assets/images/hand.png',
                fit: BoxFit.contain,
              ),
            ),
            const AutoSizeText('초대합니다',
                style: TextStyle(
                    color: Color.fromRGBO(41, 82, 56, 100),
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            const SizedBox(height: 50),
            const AutoSizeText(
             '이제 저희 두 사람 연인이 아닌 \n가족으로 새로운 출발을 하려합니다. \n귀한 걸음하시어 축복해 주시면 감사하겠습니다 ❤',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 50),
            _buildName('김영석', '윤향숙', '장남', '김민성'),
            const SizedBox(height: 30),
            _buildName('김정수', '진광임', '둘째', '김수일'),
            const SizedBox(height: 50),
            const AutoSizeText('2025년 10월 18일 토요일\n낮 12시 30분',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(41, 82, 56, 100),
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
                    /*
            const SizedBox(height: 50),
            const AutoSizeText(
              '코로나19 상황으로 인해, 부득이하게 \n결혼식 참석, 식사여부를 파악해야합니다 😢\n번거로우시겠지만, 아래 설문조사에 응해 주시면 \n정말 정말 감사하겠습니다 ❤',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _launchURL(),
              child: const Text('설문조사 하기'),
            )
            */
          ],
        ));
  }
}