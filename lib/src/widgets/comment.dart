import 'dart:async';
import 'package:html/parser.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter_news/src/widgets/loading_container.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int commentId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  const Comment({
    Key? key,
    required this.commentId,
    required this.itemMap,
    required this.depth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[commentId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }
        final comment = snapshot.data!;
        final kids = comment.kids.map((kidId) {
          return Comment(commentId: kidId, itemMap: itemMap, depth: depth + 1);
        }).toList();
        return Column(
          children: [
            ListTile(
              leading: depth > 1
                  ? const Icon(
                      Icons.reply,
                      color: Colors.blue,
                    )
                  : null,
              title: _buildText(comment),
              subtitle: Text(comment.by == '' ? 'deleted' : comment.by),
              contentPadding: EdgeInsets.only(
                left: depth * 16.0,
                right: 16,
              ),
            ),
            const Divider(),
            ...kids,
          ],
        );
      },
    );
  }

  Widget _buildText(ItemModel itemModel) {
    final text =
        parse(itemModel.text.replaceAll('<p>', '\n\n').replaceAll('</p>', ''));
    return Text(parse(text.body!.text).documentElement!.text);
  }
}
