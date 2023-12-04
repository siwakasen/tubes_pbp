import 'package:flutter/material.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';
import 'package:ugd2_pbp/lib_tubes/components_order/summary.dart';

class OrderCompleteView extends StatefulWidget {
  const OrderCompleteView({super.key});

  @override
  State<OrderCompleteView> createState() => _OrderCompleteViewState();
}

class _OrderCompleteViewState extends State<OrderCompleteView> {
  List<Makanan> makanan = [];
  List<String> desc = ["Pedas", "Goreng mateng", "tes"];

  @override
  void initState() {
    makanan.add(Makanan(
        namaMakanan: "Soto Ayam Madura",
        hargaMakanan: 15000,
        namaFoto: "logo.png"));
    makanan.add(Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"));
    makanan.add(Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 50),
          Container(
            width: screenWidth,
            child: Image(
              width: 200,
              height: 200,
              image: AssetImage('images/icon_correct.png'),
            ),
          ),
          Container(
            width: screenWidth,
            child: Center(
              child: const Text(
                "Order Success",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 20,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            width: screenWidth,
            child: Column(
              children: [
                buildCart(context),
              ],
            ),
          ),
          Container(
            //Container payment method
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            width: screenWidth,
            child: summary(),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: screenWidth / 2 - 10,
                height: 50,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const OrderCompleteView(),
                        //   ),
                        // );
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    highlightColor: Colors.transparent,
                    child: const Center(
                      child: Text(
                        "Check Now",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: screenWidth / 2 - 10,
                height: 50,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    highlightColor: Colors.transparent,
                    child: const Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }

  Widget buildCart(BuildContext context) {
    return Column(
      children: List.generate(makanan.length, (index) => listCart(index)),
    );
  }

  Widget listCart(index) {
    Makanan m = Makanan(
      namaMakanan: makanan[index].namaMakanan!,
      hargaMakanan: makanan[index].hargaMakanan,
      namaFoto: makanan[index].namaFoto,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/${m.namaFoto}'),
                width: 110,
                height: 110,
                fit: BoxFit.cover,
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
                        Container(
                          alignment: Alignment.centerRight,
                          width: 100,
                          child: Text(
                            "IDR ${m.hargaMakanan}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 250,
                    child: Text(
                      desc[index],
                      style:
                          const TextStyle(fontFamily: 'Poppins', fontSize: 14),
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
}
