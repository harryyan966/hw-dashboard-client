import 'package:flutter/material.dart';

class ItemBrowsingPage extends StatelessWidget {
  const ItemBrowsingPage({
    required this.title,
    required this.subtitle,
    required this.searchBarPlaceholder,
    required this.onSearch,
    required this.itemCount,
    required this.itemBuilder,
    required this.imageBuilder,
    required this.onItemSelected,
    super.key,
  });

  final String title;
  final String subtitle;
  final String searchBarPlaceholder;
  final void Function(String keyword) onSearch;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) imageBuilder;
  final void Function(BuildContext context, int index) onItemSelected;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
