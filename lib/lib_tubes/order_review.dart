import 'package:flutter/material.dart';
import 'package:ugd2_pbp/entity/makananEntity.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ugd2_pbp/lib_tubes/components_order/summary.dart';
import 'package:ugd2_pbp/lib_tubes/order_complete.dart';

class OrderReviewView extends StatefulWidget {
  const OrderReviewView({super.key});

  @override
  State<OrderReviewView> createState() => _OrderReviewViewState();
}

class _OrderReviewViewState extends State<OrderReviewView> {
  List<Makanan> makanan = [];
  List<String> desc = ["Pedas", "Goreng mateng"];
  int amountOrder = 0;

  String voucherName = "";
  List<String> voucherData = ["Promo Paket Family", "Promo Paket Hemat"];
  List<String> voucherImageName = [
    "voucher_family.png",
    "voucher_hemat.png",
  ];

  int indexPaymentMethod = -1;
  List<String> paymentMethodData = [
    "Credit/Debit Card",
    "Gopay",
    "Transfer BCA",
    "Transfer Mandiri",
    "Transfer BRI"
  ];
  List<String> imageNamePaymentMethod = [
    "credit_card.png",
    "gopay.png",
    "logo_bca.png",
    "logo_mandiri.png",
    "logo_bri.png"
  ];

  String? _currentAddress;
  MapController? _mapController;
  Position _currentPosition = Position(
      latitude: -7.779353691217627,
      longitude: 110.41544086617908,
      timestamp: DateTime.now(),
      accuracy: 2000.0,
      altitude: 0.5,
      altitudeAccuracy: 0.0,
      heading: 30.0,
      headingAccuracy: 0.0,
      speed: -122.08395287867832,
      speedAccuracy: 0.5);

  TextEditingController noteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteAddressController = TextEditingController();

  @override
  void initState() {
    makanan.add(Makanan(
        namaMakanan: "Soto Ayam Madura",
        hargaMakanan: 15000,
        namaFoto: "logo.png"));
    makanan.add(Makanan(
        namaMakanan: "Ayam goreng", hargaMakanan: 25000, namaFoto: "logo.png"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      appBar: AppBar(
        title: const Text(
          "ORDER REVIEW",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE9E9E9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 40,
            color: Colors.black,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            //Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Order Details",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: screenWidth,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buildCart(context),
                    Material(
                      color: Colors.white, // Set the background color
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          width: 200,
                          height: 60,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.red,
                                size: 30,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Add more menu",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                width: screenWidth,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Main Restaurant",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(20),
                            child: const Image(
                              image: AssetImage('images/logo.png'),
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 255,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: const Text(
                                  "Crusty Crunch's Sultan Agung",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 255,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: const Text(
                                  "Jl. Sultan Agung no. 24. Wirogunana, Mergang, Yogyakarta",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                  width: 200,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: const Row(
                                    children: [
                                      Text(
                                        "55281",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Yogyakarta",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          )
                        ],
                      )
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              //DELIVERY ADDRESS
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                width: screenWidth,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Delivery Address",
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                          GestureDetector(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: const Text(
                                "Change Address",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    color: Colors.red),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _mapController = MapController();
                                _getCurrentLocation();
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => locationAddress(),
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(25),
                            child: const Image(
                              image: AssetImage('images/icon_map.png'),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 260,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: const Text(
                                    "Jl. Babarsari, Selokan",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 260,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: const Text(
                                    "Jl. Babarsari, Selokan, no. 33, Sleman, Yogyakarta",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Add delivery note",
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                            isDense: true,
                            contentPadding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          controller: noteController,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                //Container voucher
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                width: screenWidth,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Voucher",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(5),
                                  child: const Image(
                                    image:
                                        AssetImage('images/voucher_logo.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  voucherName.isEmpty
                                      ? "Apply Voucher"
                                      : voucherName,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                child: const Icon(Icons.chevron_right_rounded,
                                    size: 50),
                                onTap: () {
                                  setState(() {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => applyVoucher(),
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                //Container payment method
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                width: screenWidth,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Method",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(5),
                                  child: const Image(
                                    image:
                                        AssetImage('images/payment_logo.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                indexPaymentMethod == -1
                                    ? const Text("Select Payment Method",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                        ))
                                    : indexPaymentMethod == 0
                                        ? const Text("Credit/ Debit Card",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                            ))
                                        : indexPaymentMethod == 1
                                            ? const SizedBox(
                                                width: 90,
                                                height: 30,
                                                child: Image(
                                                  image: AssetImage(
                                                      'images/gopay.png'),
                                                ),
                                              )
                                            : Container(
                                                width: 100,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Image(
                                                  fit: BoxFit.fitWidth,
                                                  image: AssetImage(
                                                      'images/${imageNamePaymentMethod[indexPaymentMethod]}'),
                                                ),
                                              ),
                              ],
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                child: const Icon(Icons.chevron_right_rounded,
                                    size: 50),
                                onTap: () {
                                  setState(() {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => paymentMethod(),
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                //Container payment method
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                width: screenWidth,
                child: summary(),
              ),
              Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.white,
                  ),
                  width: screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: Material(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.red,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderCompleteView(),
                                  ),
                                );
                              });
                            },
                            borderRadius: BorderRadius.circular(50),
                            highlightColor: Colors.transparent,
                            child: const Center(
                              child: Text(
                                "Order Now!",
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
                      const SizedBox(height: 30),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCart(BuildContext context) {
    return Column(
      children: List.generate(makanan.length, (index) => listCart(index)),
    );
  }

  Widget applyVoucher() => DraggableScrollableSheet(
        initialChildSize: 0.91,
        builder: (_, controller) => Container(
            padding: const EdgeInsets.only(top: 21),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Container()),
                      Container(
                        width: 100,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text(
                    "Voucher List",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(255, 167, 167, 167),
                  thickness: 1,
                  height: 20,
                ),
                buildVoucherImage(context),
              ],
            )),
      );
  Widget buildVoucherImage(BuildContext context) {
    return Column(
      children: List.generate(
          voucherImageName.length, (index) => scrollVoucherItem(index)),
    );
  }

  Column scrollVoucherItem(int index) {
    return Column(
      children: [
        Material(
          child: Ink.image(
            image: AssetImage('images/${voucherImageName[index]}'),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                showSnackBar(context, "Berhasil memilih ${voucherData[index]}",
                    Colors.green);
                setState(() {
                  voucherName = voucherData[index];
                  Navigator.of(context).pop();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.all(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget locationAddress() => DraggableScrollableSheet(
        initialChildSize: 0.91,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.only(top: 21),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container()),
                  Container(
                    width: 100,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: const Text(
                "Choose New Address",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 167, 167, 167),
              thickness: 1,
              height: 0,
            ),
            SizedBox(
              height: 300,
              child: _mapController.hashCode != null
                  ? buildMap(context)
                  : const Center(child: CircularProgressIndicator()),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              height: 50,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _getCurrentLocation();
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  highlightColor: Colors.transparent,
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "USE MY CURRENT LOCATION",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          width: 30,
                          height: 30,
                          padding: const EdgeInsets.all(8),
                          child: const Image(
                            image: AssetImage('images/icon_mapBlack.png'),
                          ),
                        ),
                        fillColor: Colors.transparent,
                        hintText: "Address detail",
                        hintStyle: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                      ),
                      readOnly: true,
                      controller: addressController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          width: 30,
                          height: 30,
                          padding: const EdgeInsets.all(8),
                          child: const Image(
                            image: AssetImage('images/icon_note.png'),
                          ),
                        ),
                        fillColor: Colors.transparent,
                        hintStyle: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        labelText: "Notes",
                        filled: true,
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                      ),
                      controller: noteAddressController,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                width: 200,
                height: 50,
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).pop();
                        showSnackBar(
                            context, "Berhasil Mengganti Alamat", Colors.green);
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    highlightColor: Colors.transparent,
                    child: const Center(
                      child: Text(
                        "SAVE",
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
            ),
            const SizedBox(height: 20),
          ]),
        ),
      );

  Widget paymentMethod() => DraggableScrollableSheet(
        initialChildSize: 0.91,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.only(top: 21),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Container()),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Text(
                  "Select Payment Method",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 167, 167, 167),
                thickness: 1,
                height: 20,
              ),
              Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: const Text("Pay by",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          indexPaymentMethod = 0;
                          Navigator.of(context).pop();
                          showSnackBar(
                              context,
                              "Berhasil Memilih Pembayaran Credit/Debit",
                              Colors.green);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: double.infinity,
                        height: 70,
                        child: const Row(
                          children: [
                            SizedBox(width: 8),
                            Icon(
                              Icons.credit_card,
                              size: 40,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text("Credit/Debit Card",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 167, 167, 167),
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: const Text("E-Money",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => setState(() {
                        indexPaymentMethod = 1;
                        Navigator.of(context).pop();
                        showSnackBar(context,
                            "Berhasil Memilih Pembayaran Gopay", Colors.green);
                      }),
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 30,
                              child: Image(
                                image: AssetImage('images/gopay.png'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Gopay",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Bind Gopay Account",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 167, 167, 167),
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: const Text("Transfer",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => setState(() {
                        indexPaymentMethod = 2;
                        Navigator.of(context).pop();
                        showSnackBar(context, "Berhasil Memilih Transfer BCA",
                            Colors.green);
                      }),
                      child: Container(
                        decoration: const BoxDecoration(),
                        width: double.infinity,
                        height: 70,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Image(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('images/logo_bca.png'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "BCA",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => setState(() {
                        indexPaymentMethod = 3;
                        Navigator.of(context).pop();
                        showSnackBar(context,
                            "Berhasil Memilih Transfer Mandiri", Colors.green);
                      }),
                      child: Container(
                        decoration: const BoxDecoration(),
                        width: double.infinity,
                        height: 70,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Image(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('images/logo_mandiri.png'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Mandiri",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => setState(() {
                        indexPaymentMethod = 4;
                        Navigator.of(context).pop();
                        showSnackBar(context, "Berhasil Memilih Transfer BRI",
                            Colors.green);
                      }),
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Image(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('images/logo_bri.png'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "BRI",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

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
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('images/${m.namaFoto}'),
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
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
                          decoration: const BoxDecoration(color: Colors.white),
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
                    decoration: const BoxDecoration(color: Colors.white),
                    width: 250,
                    child: Text(
                      desc[index],
                      style:
                          const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey[300],
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            amountOrder--;
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      Text(
                        amountOrder.toString(),
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 16),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey[300],
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            amountOrder++;
                          });
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 3),
        const Divider(
          color: Color.fromARGB(255, 167, 167, 167),
          thickness: 1,
        ),
        const SizedBox(height: 1),
      ],
    );
  }

  Widget buildMap(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter:
                LatLng(_currentPosition.latitude, _currentPosition.longitude),
            initialZoom: 16.99,
          ),
          mapController: _mapController,
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.ugd2_pbp',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(
                      _currentPosition.latitude, _currentPosition.longitude),
                  width: 30.0,
                  height: 30.0,
                  child: const SizedBox(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(_currentPosition.latitude + 0.0017,
                      _currentPosition.longitude - 0.0014),
                  width: 30.0,
                  height: 30.0,
                  child: SizedBox(
                    child: Icon(
                      Icons.storefront_rounded,
                      color: Colors.amber[900],
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(_currentPosition.latitude + 0.00092,
                      _currentPosition.longitude + 0.0021),
                  width: 30.0,
                  height: 30.0,
                  child: SizedBox(
                    child: Icon(
                      Icons.storefront_rounded,
                      color: Colors.amber[900],
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(_currentPosition.latitude - 0.00095,
                      _currentPosition.longitude + 0.0012),
                  width: 30.0,
                  height: 30.0,
                  child: SizedBox(
                    child: Icon(
                      Icons.storefront_rounded,
                      color: Colors.amber[900],
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _mapController?.move(
                          LatLng(_currentPosition.latitude,
                              _currentPosition.longitude),
                          16.99);
                    });
                  },
                  child: const Icon(
                    Icons.navigation_rounded,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.bestForNavigation,
              forceAndroidLocationManager: true)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          _getAddressFromLatLng(_currentPosition);
        });
      });
    } catch (e) {
      print('$e');
      return getLastKnownPosition();
    }
  }

  getLastKnownPosition() async {
    _currentPosition = Position(
        latitude: -7.779353691217627,
        longitude: 110.41544086617908,
        timestamp: DateTime.now(),
        accuracy: 2000.0,
        altitude: 0.5,
        altitudeAccuracy: 0.0,
        heading: 30.0,
        headingAccuracy: 0.0,
        speed: -122.08395287867832,
        speedAccuracy: 0.5);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition.latitude, _currentPosition.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}, ${place.subLocality}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: bg,
  ));
}
