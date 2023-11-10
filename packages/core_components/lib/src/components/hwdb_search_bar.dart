import 'package:core_components/src/constants/_.dart';
import 'package:flutter/material.dart';

class HWDBSearchBar extends StatelessWidget {
  const HWDBSearchBar({
    required this.placeholder,
    required this.onSearch,
    super.key,
  });

  final String placeholder;
  final void Function(String keyword) onSearch;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.space40),
        child: TextField(
          onSubmitted: onSearch,
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: Space.space16, right: Space.space8),
              child: Icon(Icons.search, size: Space.space36),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
