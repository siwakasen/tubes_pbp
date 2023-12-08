import 'package:flutter/material.dart';
import 'package:ugd2_pbp/entity/transaksiEntity.dart';

Widget transDetails(Transaksi trans) {
  String date = trans.datetime!.substring(1, 11);
  String time = trans.datetime!.substring(12, 19);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Transaction Details",
        style: TextStyle(
            fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: 15),
      Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transaction ID",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "TRX-${trans.id}",
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date order",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "$date",
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Time order",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "$time",
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
