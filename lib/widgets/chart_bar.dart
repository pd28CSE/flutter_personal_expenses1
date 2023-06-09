import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double sepndingAmount;
  final double sepndingPctOfTotal;

  const ChartBar(
      {super.key,
      required this.label,
      required this.sepndingAmount,
      required this.sepndingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext cntx, BoxConstraints constraints) {
        return Column(
          children: [
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${sepndingAmount.toStringAsFixed(0)}'))),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              // // ------>> With Stack Chart Bar Design <<------
              // child: Stack(
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.grey, width: 1),
              //         color: Color.fromRGBO(220, 220, 220, 1),
              //         borderRadius: BorderRadius.all(Radius.circular(10)),
              //       ),
              //     ),
              //     FractionallySizedBox(
              //       heightFactor: sepndingPctOfTotal,
              //       child: Container(
              //         decoration: BoxDecoration(
              //           color: Theme.of(context).primaryColor,
              //           borderRadius:
              //               BorderRadius.vertical(top: Radius.circular(10)),
              //         ),
              //       ),
              //       alignment: Alignment.bottomCenter,
              //     ),
              //   ],
              // ),

              // // ------>> Without Stack Chart Bar Design <<------
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: FractionallySizedBox(
                  heightFactor: sepndingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
