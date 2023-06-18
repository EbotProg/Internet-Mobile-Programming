import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff292E2A),
      appBar: AppBar(
        backgroundColor: const Color(0xff292E2A),
        // leading: null,
        automaticallyImplyLeading: false,
        title: SizedBox(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.white),
              ),
              CircleAvatar(
                radius: 20,
                child:
                    //  user.imageUrl != null
                    //     ? ClipOval(
                    //         child: Image.network(
                    //           user.imageUrl!,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       )
                    //     :
                    ClipOval(
                  child: Image.asset('assets/Ellipse 4.png'),
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                'Ellie',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
      ),
      // extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final isMine = index % 2 == 0;
                      return Align(
                        alignment: isMine
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                            minWidth: MediaQuery.of(context).size.width * 0.5,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isMine
                                  ? const Color(0xff20B970)
                                  : const Color(0xff292E2A),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 10,
                              left: 15,
                              right: 15,
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hey, how are you',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '7:32 pm',
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          label: Text('Message...'),
                          border: OutlineInputBorder(),
                          fillColor: Color(0xffECECEC),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
