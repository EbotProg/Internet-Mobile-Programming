import 'dart:async';

import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  final String title;
  final String description;
  final String continueText;
  final Color continueColor;
  final FutureOr Function() onContinue;

  const MyDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onContinue,
    required this.continueText,
    required this.continueColor,
  });

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30.0,
        ),
      ),
      child: Container(
        // height: 220,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: loading
                      ? () {}
                      : () async {
                          setState(() {
                            loading = true;
                          });
                          await widget.onContinue();
                          Navigator.of(context).pop(true);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.continueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        )
                      : Text(
                          widget.continueText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
