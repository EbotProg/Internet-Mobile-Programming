import 'package:flutter/material.dart';

class TrasactionsScreen extends StatelessWidget {
  const TrasactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 0),
            //   child: Text(
            //     'Transactions',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 30,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10),
            ...List.filled(15, getItem),
          ],
        ),
      ),
    );
  }

  Widget get getItem => Container(
        decoration: BoxDecoration(
          color: const Color(0xffF0F0F0),
          border: Border(
            right: BorderSide(
              color: Colors.yellow[800]!, // Color(0xff20B970),
              width: 2,
            ),
          ),
          // borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(
              Icons.info,
              color: Colors.yellow[800],
              size: 30,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nji Caleb',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('7:26 PM'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text('Fufu and Eru'),
                ],
              ),
            ),
          ],
        ),
      );
}
