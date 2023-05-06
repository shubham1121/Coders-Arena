import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

likePost(String postId, String myUid) async {
  try {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(myUid)
        .set({'userId': myUid});
  } on FirebaseException catch (error) {
    rethrow;
  }
}

dislikePost(String postId, String myUid) async {
  await FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('likes')
      .doc(myUid)
      .delete();
}

addComment(
    {String? comment,
    String? createdAt,
    String? userId,
    String? postId}) async {
  var docId = await FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('comments')
      .add({
    'comment': comment,
    'createdAt': createdAt,
    'userId': userId,
  });
  await FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('comments')
      .doc(docId.id)
      .update({'commentId': docId.id});
}

sendPersonalMessage(
    {String? message,
    String? personalMessageId,
    String? createdAt,
    String? senderId,
    String? receiverId}) async {
  var docId = await FirebaseFirestore.instance
      .collection('All Chats')
      .doc(personalMessageId)
      .collection('chat')
      .add({
    'message': message,
    'createdAt': createdAt,
    'senderId': senderId,
    'receiverId': receiverId,
  });
  await FirebaseFirestore.instance
      .collection('All Chats')
      .doc(personalMessageId)
      .collection('chat')
      .doc(docId.id)
      .update({'messageId': docId.id});

  await FirebaseFirestore.instance
      .collection('All Chats')
      .doc(personalMessageId)
      .set({'chatId': personalMessageId}).whenComplete(() => debugPrint('done'));
}
