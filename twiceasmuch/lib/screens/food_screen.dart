import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/payment_db_methods.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/payment.dart';
import 'package:twiceasmuch/screens/payment/make_payments.dart';
import 'package:twiceasmuch/utilities/snackbar_utils.dart';

class FoodScreen extends StatelessWidget {
  final Food food;
  const FoodScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.3,
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(food.image ?? ''),
                      fit: BoxFit.cover)),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(food.name ?? '',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                clipBehavior: Clip.hardEdge,
                                height: 50,
                                width: 50,
                                child: AspectRatio(
                                  aspectRatio: 3 / 4,
                                  child: food.donor?.picture != null
                                      ? Image.network(
                                          food.donor!.picture!,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/profile.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(food.donor?.username ?? ''),
                            ],
                          ),
                          const Text("\t | \t"),
                          Text(
                            "${DateFormat('MMM dd yyyy').format(food.uploadedAt!)}\n${DateFormat.jm().format(food.uploadedAt!)}",
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: SizedBox(
                          width: width * 0.8,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (food.discountPrice == 0 ||
                                  food.discountPrice == null) {
                                await PaymentDBMethods().createPayment(Payment(
                                    amount: 0,
                                    depositorID: Supabase
                                        .instance.client.auth.currentUser!.id,
                                    timeOfDeposit: DateTime.now(),
                                    withdrawerID: food.donorID));
                                snackbarSuccessful(
                                    title:
                                        "A notification has been sent to the donor",
                                    context: context);
                                Navigator.of(context).pop();
                              } else {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 180,
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Select Payment Method",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      MakePayment(
                                                                          food:
                                                                              food)));
                                                        },
                                                        icon: Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              image: const DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: AssetImage(
                                                                      'assets/mtn.jpg'))),
                                                        ),
                                                      ),
                                                      const Text("MTN momo")
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.45,
                                                  ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      MakePayment(
                                                                          food:
                                                                              food)));
                                                        },
                                                        icon: Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              image: const DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: AssetImage(
                                                                      'assets/orange.png'))),
                                                        ),
                                                      ),
                                                      const Text("Orange Money")
                                                    ],
                                                  ),
                                                ]),
                                          ],
                                        ),
                                      );
                                    });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff20B970),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              food.discountPrice == null ||
                                      food.discountPrice == 0
                                  ? 'Get Free'
                                  : 'Get for ${food.discountPrice!} FCFA',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Row(
                            children: [
                              const Icon(Icons.message_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("Message ${food.donor?.username ?? ''}")
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 226, 230, 231),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "More Info",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Expiry Date",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(food.expiryDate == null
                              ? 'No expiry date'
                              : DateFormat('MMM dd yyyy')
                                  .format(food.expiryDate!))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Location ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(food.donor?.location ?? '')
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "User rating",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text("4.6/5")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Quantity",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text("${food.quantity ?? 1} plate(s)")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "State",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(food.state.displayString())
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Price",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            food.discountPrice == null ||
                                    food.discountPrice == 0
                                ? "Free"
                                : '${food.discountPrice!}FCFA',
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
