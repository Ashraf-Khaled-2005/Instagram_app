import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/authication/data/manager/fetchuserdetailcubit/fetchuserdetail_cubit.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';
import 'package:instagram_app/features/chat/presentation/view/widget/custommesasge.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Chatdetail extends StatefulWidget {
  final UserModel userModel;
  const Chatdetail({super.key, required this.userModel});

  @override
  State<Chatdetail> createState() => _ChatdetailState();
}

class _ChatdetailState extends State<Chatdetail> {
  TextEditingController controller = TextEditingController();

  String formattedTime = DateFormat('HH:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    UserModel curuser = BlocProvider.of<FetchUSerDetailCubit>(context).user;
    String getroomid() {
      List<String> users = [widget.userModel.uid, curuser.uid];
      users.sort();
      return '${users[0]}_${users[1]}';
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage('${widget.userModel.image}'),
                  ),
                  const SizedBox(
                    width: 65,
                  ),
                  Text(
                    "${widget.userModel.username}",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Chats')
                    .doc(getroomid())
                    .collection('messages')
                    .orderBy('date', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData) {
                    log("No data in snapshot");
                    return Center(child: Text('No messages yet'));
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    log("Document list is empty");
                    return Center(child: Text('No messages yet'));
                  }

                  log("Data found: ${snapshot.data!.docs.length} documents");

                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var messageData = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        log("Message Data: $messageData");

                        var formattedTime = DateFormat.jm().format(
                            (messageData['date'] as Timestamp).toDate());

                        return Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: messageData['senderid'] ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? Customchatbabblesender(
                                  text: messageData['message'],
                                  formattedTime: formattedTime,
                                )
                              : Customchatbabblerece(
                                  formattedTime: formattedTime,
                                  text: messageData['message']),
                        );
                      },
                    ),
                  );
                },
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Type here",
                  prefixIcon:
                      IconButton(onPressed: () {}, icon: Icon(Icons.image)),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        if (controller.text.isNotEmpty) {
                          try {
                            final roomId = getroomid();
                            final timestamp = Timestamp.now();
                            final uuid = Uuid().v4();

                            // Update or set the chat room data
                            await FirebaseFirestore.instance
                                .collection('Chats')
                                .doc(roomId)
                                .set({
                              'sendername': curuser.username,
                              'senderid': curuser.uid,
                              'senderimage': curuser.image,
                              'reciverid': widget.userModel.uid,
                              'recivername': widget.userModel.username,
                              'reciverimage': widget.userModel.image,
                              'participants': [
                                curuser.uid,
                                widget.userModel.uid
                              ],
                              'chatroomid': roomId,
                              'date': timestamp
                            });

                            // Add the message to the messages collection
                            await FirebaseFirestore.instance
                                .collection('Chats')
                                .doc(roomId)
                                .collection('messages')
                                .doc(uuid)
                                .set({
                              'message': controller.text,
                              'senderid': curuser.uid,
                              'date': timestamp,
                              'messageid': uuid
                            });

                            // Clear the text field after sending the message
                            setState(() {
                              controller.clear();
                            });
                          } catch (e) {
                            log("Error sending message: $e");
                            // Optionally show a message to the user about the error
                          }
                        }
                      },
                      icon: Icon(Icons.send)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
