import 'package:core_components/core_components.dart';
import 'package:flutter/material.dart';

class ItemBrowsingPageL extends ItemBrowsingPage {
  const ItemBrowsingPageL({
    required super.title,
    required super.subtitle,
    required super.searchBarPlaceholder,
    required super.onSearch,
    required super.itemCount,
    required super.itemBuilder,
    required super.imageBuilder,
    required super.onItemSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Space.space40),
        Row(
          children: [
            PageTitle(title: title),
            HWDBSearchBar(
              placeholder: searchBarPlaceholder,
              onSearch: onSearch,
            ),
          ],
        ),
        const SizedBox(height: Space.space16),
        Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: Space.space24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: Space.space24),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Space.space24,
                mainAxisSpacing: Space.space24,
                mainAxisExtent: Space.space200,
              ),
              itemCount: itemCount,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => onItemSelected(context, index),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(Space.space8),
                    ),
                    padding: const EdgeInsets.all(Space.space24),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(Space.space8),
                            child: itemBuilder(context, index),
                          ),
                        ),
                        const SizedBox(width: Space.space24),
                        SizedBox(
                          width: 200,
                          child: imageBuilder(context, index),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PageTitle extends StatelessWidget {
  const PageTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}
