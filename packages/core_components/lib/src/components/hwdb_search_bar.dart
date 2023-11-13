import 'package:core_components/core_components.dart';
import 'package:flutter/material.dart';

class HWDBSearchBar extends StatefulWidget {
  const HWDBSearchBar({
    required this.placeholder,
    required this.onSearch,
    super.key,
  });

  final String placeholder;
  final void Function(String keyword) onSearch;

  @override
  State<HWDBSearchBar> createState() => _HWDBSearchBarState();
}

class _HWDBSearchBarState extends State<HWDBSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.space40),
      child: TextField(
        onSubmitted: widget.onSearch,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: Space.space16, right: Space.space8),
            child: Icon(Icons.search, size: Space.space36),
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
