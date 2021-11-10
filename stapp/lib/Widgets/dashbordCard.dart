import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget dashbordCard(
  BuildContext context,
  Icon icon,
  String cardName,
) {
  return Container(
    child: Card(
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 10,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: icon,
            ),
            Text(cardName),
          ],
        ),
      ),
    ),
  );
}
