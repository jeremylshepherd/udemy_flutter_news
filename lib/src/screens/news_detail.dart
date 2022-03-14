import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;
  const NewsDetail({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: _buildBody(bloc),
    );
  }

  Widget _buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Loading');
        }
        final itemFuture = snapshot.data![itemId];
        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!snapshot.hasData) {
              return const Text('Also loading');
            }
            return _buildList(itemSnapshot.data!, snapshot.data!);
          },
        );
      },
    );
  }

  Widget _buildTitle(ItemModel item) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final commentsList = item.kids.map((kidId) {
      return Comment(commentId: kidId, itemMap: itemMap);
    }).toList();
    return ListView(
      children: [_buildTitle(item), ...commentsList],
    );
  }
}
