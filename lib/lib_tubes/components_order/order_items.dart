import 'package:flutter/material.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';

Widget listItem(index, makanan, desc) {
  Makanan m = Makanan(
    namaMakanan: makanan[index].namaMakanan!,
    hargaMakanan: makanan[index].hargaMakanan,
    namaFoto: makanan[index].namaFoto,
  );
  List<String> qty = ["1", "2", "3"];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 110,
              height: 110,
              child: Image(
                image: AssetImage('images/${m.namaFoto}'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                const SizedBox(height: 12),
                SizedBox(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          m.namaMakanan!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "IDR ${m.hargaMakanan}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            " x ${qty[index]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: 250,
                  child: Text(
                    desc[index],
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            )
          ],
        ),
      ),
      const SizedBox(height: 1),
    ],
  );
}
