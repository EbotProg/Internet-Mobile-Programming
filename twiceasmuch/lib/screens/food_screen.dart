import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twiceasmuch/db/food_db_methods.dart';
import 'package:twiceasmuch/db/transaction_db_methods.dart';
import 'package:twiceasmuch/enums/transaction_status.dart';
import 'package:twiceasmuch/global.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/transaction.dart';
import 'package:twiceasmuch/screens/payment/make_payments.dart';
import 'package:twiceasmuch/widgets/message_bottom_sheet_widget.dart';
import 'package:twiceasmuch/utilities/snackbar_utils.dart';

class FoodScreen extends StatefulWidget {
  final Food food;
  const FoodScreen({super.key, required this.food});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  bool loading = false;

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
                      image: NetworkImage(widget.food.image ?? ''),
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
                      Text(widget.food.name ?? '',
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
                                  child: widget.food.donor?.picture != null
                                      ? Image.network(
                                          widget.food.donor!.picture!,
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
                              Text(widget.food.donor?.username ?? ''),
                            ],
                          ),
                          const Text("\t | \t"),
                          Text(
                            "${DateFormat('MMM dd yyyy').format(widget.food.uploadedAt!)}\n${DateFormat.jm().format(widget.food.uploadedAt!)}",
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
                            onPressed: loading
                                ? () {}
                                : () async {
                                    if (widget.food.discountPrice == 0 ||
                                        widget.food.discountPrice == null) {
                                      if (!mounted) return;
                                      setState(() {
                                        loading = true;
                                      });
                                      await TransactionDBMethods()
                                          .createTrasaction(
                                        Transaction(
                                          buyerID: globalUser?.userID,
                                          donorID: widget.food.donorID,
                                          foodID: widget.food.foodID,
                                          status: TransactionStatus.requested,
                                          time: DateTime.now(),
                                          food: widget.food,
                                          donor: widget.food.donor,
                                          buyer: globalUser,
                                        ),
                                      );
                                      await FoodDBMethods().editFood(
                                        widget.food..sold = true,
                                      );
                                      if (!mounted) return;
                                      setState(() {
                                        loading = true;
                                      });
                                      snackbarSuccessful(
                                        title:
                                            "A notification has been sent to the donor",
                                        context: context,
                                      );
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
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                MakePayment(food: widget.food)));
                                                              },
                                                              icon: Container(
                                                                height: 50,
                                                                width: 50,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    image: const DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: AssetImage(
                                                                            'assets/mtn.jpg'))),
                                                              ),
                                                            ),
                                                            const Text(
                                                                "MTN momo")
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.45,
                                                        ),
                                                        Column(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            MakePayment(
                                                                      food: widget
                                                                          .food,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              icon: Container(
                                                                height: 50,
                                                                width: 50,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    image: const DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: AssetImage(
                                                                            'assets/orange.png'))),
                                                              ),
                                                            ),
                                                            const Text(
                                                                "Orange Money")
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
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : Text(
                                    widget.food.discountPrice == null ||
                                            widget.food.discountPrice == 0
                                        ? 'Get Free'
                                        : 'Get for ${widget.food.discountPrice!} FCFA',
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
                        onPressed: () async {
                          await showModalBottomSheet(
                              isDismissible: true,
                              context: context,
                              builder: (context) {
                                return MessageBottomSheetWidget(
                                  user: widget.food.donor!,
                                  food: widget.food,
                                );
                              });
                        },
                        icon: Row(
                          children: [
                            const Icon(Icons.message_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Message ${widget.food.donor?.username ?? ''}")
                          ],
                        ),
                      ),
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
                          Text(widget.food.expiryDate == null
                              ? 'No expiry date'
                              : DateFormat('MMM dd yyyy')
                                  .format(widget.food.expiryDate!))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Location ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(widget.food.donor?.location ?? '')
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
                          Text("${widget.food.quantity ?? 1} plate(s)")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "State",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(widget.food.state.displayString())
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
                            widget.food.discountPrice == null ||
                                    widget.food.discountPrice == 0
                                ? "Free"
                                : '${widget.food.discountPrice!}FCFA',
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
