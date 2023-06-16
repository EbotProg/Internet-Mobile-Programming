import 'package:flutter/material.dart';

class UploadFoodScreen extends StatelessWidget {
  const UploadFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                'Upload Food Info',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Name of Food'),
                  hintText: 'Name of Food e.g Fufu and Eru',
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  strokeAlign: 2,
                  color: Colors.grey,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Icon(Icons.upload_file, size: 35),
                  Text(
                    'Upload Picture of Food',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: DropdownButtonHideUnderline(
                child: SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    items: const [
                      DropdownMenuItem(
                        child: Text('State of Food e.g Raw or Cooked'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Text('Quantity')
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: DropdownButtonHideUnderline(
                child: SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    items: const [
                      DropdownMenuItem(
                        child: Text('Quantity'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Expiry Date'),
                  hintText: '14/07/2024',
                  suffixIcon: Icon(Icons.date_range),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Successfully Uploaded'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff20B970),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
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
    );
  }
}
