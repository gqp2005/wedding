import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_size_text/auto_size_text.dart';

class CongratulationGift extends StatelessWidget {
  void onPressed(BuildContext context, String accountNumber) {
    Clipboard.setData(new ClipboardData(text: accountNumber)).then((value) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("계좌번호가 복사되었습니다"))));
  }

  Widget _buildButton(BuildContext context, String receiver, String accountNumber) {
    final rowWidth = MediaQuery.of(context).size.width * 0.8; // 전체 너비 대비 비율로 고정
    return SizedBox(
      width: rowWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            receiver,
            style: TextStyle(fontSize: 15),
          ),
          Row(
            children: [
              TextButton(
              onPressed: () => onPressed(context, accountNumber),
              child: AutoSizeText(
                accountNumber,
                maxLines: 2,
              )),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsetsDirectional.all(20.0),
        child: Column(
          children: [
            AutoSizeText('신랑 신부에게 마음 전하기',
                style: TextStyle(
                    color: const Color.fromRGBO(41, 82, 56, 100),
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            SizedBox(height: 50),
            _buildButton(context, '신랑 김민성', '신한 110-394-812984'),
            SizedBox(height: 20),
            _buildButton(context, '신랑 아버지', '우리 1002-149-963648'),
            SizedBox(height: 20),
            _buildButton(context, '신랑 어머니', '우리 1002-649-850149'),
            SizedBox(height: 20),
            _buildButton(context, '신부 김수일', 'KB국민 790401-01-404123'),
            SizedBox(height: 20),
            _buildButton(context, '신부 아버지', '우체국 500306-02-215194'),
            SizedBox(height: 20),
            _buildButton(context, '신부 어머니', 'NH농협 665-12-048147'),
          ],
        ));
  }
}