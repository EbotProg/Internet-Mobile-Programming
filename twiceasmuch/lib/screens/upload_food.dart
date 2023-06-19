import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twiceasmuch/db/food_db_methods.dart';
import 'package:twiceasmuch/enums/food_price.dart';
import 'package:twiceasmuch/enums/food_state.dart';
import 'package:twiceasmuch/file_picker_methods.dart';
import 'package:twiceasmuch/models/food.dart';
import 'package:twiceasmuch/utilities/snackbar_utils.dart';

class UploadFoodScreen extends StatefulWidget {
  const UploadFoodScreen({super.key, this.food, required this.shouldEdit});
  final Food? food;
  final bool shouldEdit;

  @override
  State<UploadFoodScreen> createState() => _UploadFoodScreenState();
}

class _UploadFoodScreenState extends State<UploadFoodScreen> {
  var foodprice = FoodPrice.none;
  var foodState = FoodState.none;
  bool editing = false;
  bool isLoading = false;
  DateTime? _selectedDate;
  TextEditingController? dateController;

  TextEditingController? nameController;

  TextEditingController? quantityController;
  TextEditingController? priceController;
  TextEditingController? locationController;
  final formKey = GlobalKey<FormState>();
  final imagePicker = ImagePickerMethods();
  final db = FoodDBMethods();
  XFile? image;
  void setToNull() {
    foodprice = FoodPrice.none;
    foodState = FoodState.none;
    image = null;
    dateController!.text = '';
    nameController!.text = '';
    quantityController!.text = '';
    if (!mounted) return;
    setState(() {});
  }

  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2024))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      if (!mounted) return;
      setState(() {
        _selectedDate = pickedDate;
        dateController!.text = _selectedDate!.toUtc().toString();
      });
    });
  }

  @override
  void initState() {
    dateController = TextEditingController();
    nameController = TextEditingController();
    quantityController = TextEditingController();
    priceController = TextEditingController();
    locationController = TextEditingController();

    if (widget.shouldEdit) {
      editing = widget.shouldEdit;
      nameController!.text = widget.food!.name!;
      dateController!.text = widget.food!.expiryDate!.toString();
      quantityController!.text = widget.food!.quantity!.toString();
      priceController!.text = widget.food!.discountPrice!.toString();
      locationController!.text = widget.food!.location!;
      if (widget.food!.discountPrice! > 0) {
        foodprice = FoodPrice.discount;
      } else {
        foodprice = FoodPrice.free;
      }
      foodState = widget.food!.state;
      if (!mounted) return;
      setState(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    dateController!.dispose();
    nameController!.dispose();
    quantityController!.dispose();
    priceController!.dispose();
    locationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff292E2A),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        title: widget.shouldEdit
            ? const Text(
                'Edit Food',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const Text(
                'Upload Food',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    'Enter the information of the food you want to donate',
                    style: TextStyle(
                      color: Color(0xff9A9A9A),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(
                    controller: nameController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter food name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Name of Food'),
                      hintText: 'Name of Food e.g Fufu and Eru',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    image = await imagePicker.selectPicture();
                    if (!mounted) return;
                    setState(() {});
                  },
                  child: editing
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Image.network(
                                widget.food!.image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                    onPressed: () async {
                                      image = await imagePicker.selectPicture();
                                      editing = false;
                                      if (!mounted) return;
                                      setState(() {});
                                    },
                                    child: const Text("Change Image"))
                              ],
                            )
                          ],
                        )
                      : (image == null)
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  strokeAlign: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: const Row(
                                children: [
                                  Icon(Icons.upload_file, size: 35),
                                  Text(
                                    'Upload Picture of Food',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Image.file(
                                    File(image!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                        onPressed: () async {
                                          image =
                                              await imagePicker.selectPicture();
                                          if (!mounted) return;
                                          setState(() {});
                                        },
                                        child: const Text("Change Image"))
                                  ],
                                )
                              ],
                            ),
                ),
                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      label: Text('Food Cost'),
                      border: OutlineInputBorder(),
                      fillColor: Color(0xffECECEC),
                    ),
                    validator: (val) {
                      if (val == FoodPrice.none) {
                        return 'Please chose whether free or set price';
                      }
                      return null;
                    },
                    value: foodprice,
                    items: const [
                      DropdownMenuItem(
                        value: FoodPrice.none,
                        child: Text('Set food cost'),
                      ),
                      DropdownMenuItem(
                        value: FoodPrice.discount,
                        child: Text(
                          'Discounted Price',
                          style: TextStyle(color: Color(0xff20B970)),
                        ),
                      ),
                      DropdownMenuItem(
                        value: FoodPrice.free,
                        child: Text(
                          'Free food',
                          style: TextStyle(color: Color(0xff20B970)),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      foodprice = value!;
                      if (!mounted) return;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                foodprice == FoodPrice.discount
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Price of Food'),
                            hintText: 'e.g: 500',
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      label: Text('Food state'),
                      border: OutlineInputBorder(),
                      fillColor: Color(0xffECECEC),
                    ),
                    validator: (val) {
                      if (val == FoodState.none) {
                        return 'Please select state of food';
                      }
                      return null;
                    },
                    value: foodState,
                    items: const [
                      DropdownMenuItem(
                        value: FoodState.none,
                        child: Text('State of Food e.g Raw or Cooked'),
                      ),
                      DropdownMenuItem(
                        value: FoodState.cooked,
                        child: Text('Cooked Food',
                            style: TextStyle(color: Color(0xff20B970))),
                      ),
                      DropdownMenuItem(
                        value: FoodState.raw,
                        child: Text('Raw Food',
                            style: TextStyle(color: Color(0xff20B970))),
                      ),
                    ],
                    onChanged: (value) {
                      if (!mounted) return;
                      setState(() {
                        foodState = value!;
                      });
                    },
                  ),
                ),
                // Text('Quantity')
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(
                    controller: quantityController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'please enter quantity';
                      }
                      if (int.parse(val) < 1) {
                        return 'quantity should be at least 1';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Quantity'),
                      hintText: 'e.g: 3',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(
                    controller: locationController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'please enter Location';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('location'),
                      hintText: 'e.g: Buea',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(
                    controller: dateController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please click the calender and select a date';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text('Expiry Date'),
                      hintText: '14/07/2024',
                      suffixIcon: IconButton(
                          onPressed: () {
                            _pickDateDialog();
                          },
                          icon: const Icon(Icons.date_range)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        final food = Food(
                            donorID:
                                Supabase.instance.client.auth.currentUser!.id,
                            state: foodState,
                            location: locationController!.text,
                            name: nameController!.text,
                            quantity: int.tryParse(quantityController!.text),
                            expiryDate: _selectedDate,
                            discountPrice: priceController!.text.isEmpty
                                ? 0
                                : int.tryParse(priceController!.text));
                        print('${food.discountPrice} ${food.quantity}');
                        food.imageFile = image;
                        if (!mounted) return;
                        setState(() {});
                        String? res;
                        if (widget.shouldEdit) {
                          res = await db.editFood(food);
                        } else {
                          res = await db.uploadFood(food);
                        }
                        if (res == null) {
                          isLoading = false;
                          snackbarError(title: res!, context: context);
                          if (!mounted) return;
                          setState(() {});
                        } else {
                          snackbarSuccessful(title: res, context: context);
                          isLoading = false;
                          setToNull();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff20B970),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          )
                        : const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
