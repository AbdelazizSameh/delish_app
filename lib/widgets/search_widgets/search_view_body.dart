import 'package:flutter/material.dart';

import '../Global/search_bar.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [CustomSearchBar()]),
    );
  }
}
