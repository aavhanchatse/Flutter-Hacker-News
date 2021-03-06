import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/stories_bloc.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await storieBlock.clearCache();
        await storieBlock.fetchTopIds();
      },
    );
  }
}
