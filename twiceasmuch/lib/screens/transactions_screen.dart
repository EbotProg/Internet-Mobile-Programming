import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/transaction_db_methods.dart';
import 'package:twiceasmuch/models/transaction.dart';

class TrasactionsScreen extends StatefulWidget {
  const TrasactionsScreen({super.key});

  @override
  State<TrasactionsScreen> createState() => _TrasactionsScreenState();
}

class _TrasactionsScreenState extends State<TrasactionsScreen> {
  List<Transaction> transactions = [];
  bool isloading = false;
  void getTransaction() async {
    isloading = true;
    setState(() {});
    transactions = await TransactionDBMethods()
        .getTrasactions(Supabase.instance.client.auth.currentUser!.id);

    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getTransaction();
      },
      child: isloading
          ? const CircularProgressIndicator(
              color: Colors.green,
            )
          : SingleChildScrollView(
              child: transactions.isEmpty
                  ? const Center(
                      child: Text("No Transactions Yet!"),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
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
                          ...List.generate(
                              15, (index) => getItem(transactions[index])),
                        ],
                      ),
                    ),
            ),
    );
  }

  Widget getItem(Transaction transaction) {
    return Container(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      transaction.buyer!.username!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(transaction.time.toString()),
                  ],
                ),
                const SizedBox(height: 5),
                Text(transaction.food!.name!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
