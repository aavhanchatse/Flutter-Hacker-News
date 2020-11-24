import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hacker_news/src/blocs/stories_bloc.dart';
import 'package:hacker_news/src/widgets/news_list_tile.dart';
import 'package:hacker_news/src/widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // storieBlock.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
        centerTitle: true,
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return StreamBuilder(
      stream: storieBlock.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              storieBlock.fetchItem(snapshot.data[index]);
              return NewsListTile(
                itemId: snapshot.data[index],
              );
            },
          ),
        );
      },
    );
  }
}
