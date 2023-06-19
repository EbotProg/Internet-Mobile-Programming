import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/transaction_db_methods.dart';
import 'package:twiceasmuch/enums/payment_status.dart';
import 'package:twiceasmuch/enums/transaction_status.dart';
import 'package:twiceasmuch/global.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/models/payment.dart';
import 'package:twiceasmuch/models/transaction.dart';
import 'package:twiceasmuch/screens/home_screen.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({super.key, required this.food});
  final Food food;

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Make Payment"),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Amount",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                '${widget.food.discountPrice! + 50} FCFA',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Enter your Phone Number"),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 233, 230, 230),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: loading
                ? () {}
                : () async {
                    //make payment
                    if (!mounted) return;
                    setState(() {
                      loading = true;
                    });

                    await TransactionDBMethods().createTrasaction(
                      Transaction(
                        buyerID: globalUser?.userID,
                        donorID: widget.food.donorID,
                        foodID: widget.food.foodID,
                        status: TransactionStatus.requested,
                        time: DateTime.now(),
                        food: widget.food,
                        donor: widget.food.donor,
                        buyer: globalUser,
                        payment: Payment(
                          amount: widget.food.discountPrice! + 50,
                          depositorID:
                              Supabase.instance.client.auth.currentUser!.id,
                          timeOfDeposit: DateTime.now(),
                          withdrawerID: widget.food.donorID,
                          status: PaymentStatus.deposited,
                        ),
                      ),
                    );
                    await showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 300,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/success.png'))),
                                ),
                                const Text(
                                  'Payment Succesful!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff20B970),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                          ..popUntil((route) => false)
                                          ..push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff20B970),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Return to home',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                    if (!mounted) return;
                    setState(() {
                      loading = false;
                    });
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
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ]),
    );
  }
}
