import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int commentId;
  final Map<int, Future<ItemModel>> itemMap;

  const Comment({Key? key, required this.commentId, required this.itemMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[commentId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Still loading comment');
        }
        final comment = snapshot.data!;
        final kids = comment.kids
            .map((kidId) => Comment(commentId: kidId, itemMap: itemMap))
            .toList();
        return Column(
          children: [
            ListTile(
              title: Text(comment.text),
              subtitle: Text(comment.by == '' ? 'deleted' : comment.by),
            ),
            Divider(),
            ...kids,
          ],
        );
      },
    );
  }
}
