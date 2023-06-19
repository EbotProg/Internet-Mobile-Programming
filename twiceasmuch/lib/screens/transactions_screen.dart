import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/transaction_db_methods.dart';
import 'package:twiceasmuch/enums/transaction_status.dart';
import 'package:twiceasmuch/global.dart';
import 'package:twiceasmuch/models/transaction.dart';
import 'package:twiceasmuch/widgets/message_bottom_sheet_widget.dart';

class TrasactionsScreen extends StatefulWidget {
  const TrasactionsScreen({super.key});

  @override
  State<TrasactionsScreen> createState() => _TrasactionsScreenState();
}

class _TrasactionsScreenState extends State<TrasactionsScreen> {
  List<Transaction> transactions = [];
  bool isloading = false;
  bool isDeleting = false;
  bool isReceiving = false;

  void getTransaction() async {
    isloading = true;
    if (!mounted) return;
    setState(() {});
    transactions = await TransactionDBMethods()
        .getTrasactions(Supabase.instance.client.auth.currentUser!.id);

    isloading = false;
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getTransaction();
      },
      child: isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : transactions.isEmpty
              ? const Center(
                  child: Text("No Transactions Yet!"),
                )
              : SingleChildScrollView(
                  child: Container(
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
                          transactions.length,
                          (index) => getItem(transactions[index]),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget getItem(Transaction transaction) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(transaction.transactionID),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const DrawerMotion(),

        // A pane can dismiss the Slidable.
        // dismissible: DismissiblePane(onDismissed: () {}),
        dragDismissible: false,

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) async {
              await showModalBottomSheet(
                  isDismissible: true,
                  context: context,
                  builder: (context) {
                    return MessageBottomSheetWidget(
                      user: globalUser?.userID == transaction.buyerID
                          ? transaction.donor!
                          : transaction.buyer!,
                      food: transaction.food!,
                    );
                  });

              setState(() {});
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.message,
            label: 'Message',
          ),
          if (transaction.status == TransactionStatus.requested)
            SlidableAction(
              onPressed: (context) async {
                if (!mounted) return;
                setState(() {
                  isReceiving = true;
                });
                await TransactionDBMethods().updateTransaction(
                  transaction..status = TransactionStatus.delivered,
                );
                if (!mounted) return;
                setState(() {
                  isReceiving = false;
                });
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: isReceiving ? Icons.refresh : Icons.check,
              label: 'Received',
            ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          if (transaction.status == TransactionStatus.requested)
            SlidableAction(
              onPressed: (context) async {
                if (!mounted) return;
                setState(() {
                  isDeleting = true;
                });
                await TransactionDBMethods().updateTransaction(
                  transaction..status = TransactionStatus.canceled,
                );
                if (!mounted) return;
                setState(() {
                  isDeleting = false;
                });
              },
              backgroundColor: const Color(0xFFFE4A49), //Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: isDeleting ? Icons.refresh : Icons.delete,
              label: 'Cancel',
            ),
        ],
      ),
      closeOnScroll: false,

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF0F0F0),
          border: Border(
            right: BorderSide(
              color: transaction.status == TransactionStatus.requested
                  ? Colors.yellow[800]!
                  : transaction.status == TransactionStatus.delivered
                      ? Colors.green[800]!
                      : Colors.red[800]!, // Color(0xff20B970),
              width: 2,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            if (transaction.status == TransactionStatus.requested)
              Icon(
                Icons.info,
                color: Colors.yellow[800],
                size: 30,
              )
            else if (transaction.status == TransactionStatus.delivered)
              Icon(
                Icons.check,
                color: Colors.green[800],
                size: 30,
              )
            else
              Icon(
                Icons.close,
                color: Colors.red[800],
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
                        globalUser?.userID == transaction.buyer!.userID
                            ? transaction.donor!.username!
                            : transaction.buyer!.username!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.MMMEd()
                            .format(transaction.time ?? DateTime.now()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(transaction.food!.name!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
