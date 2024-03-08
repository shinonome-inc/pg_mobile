import 'package:flutter/material.dart';
import 'package:pg_mobile/widgets/search_bar_widget.dart';

class DebugSearchBarPage extends StatelessWidget {
  const DebugSearchBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('searchBar'),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SearchBarWidget(),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
