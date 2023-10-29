import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryCreationView extends ConsumerStatefulWidget {
  const CategoryCreationView({super.key});

  @override
  ConsumerState<CategoryCreationView> createState() => _CategoryCreationViewState();
}

class _CategoryCreationViewState extends ConsumerState<CategoryCreationView> {
  DummyParentCategory? parentCategory;

  @override
  Widget build(BuildContext context) {
    final TextEditingController iconController = TextEditingController();
    final List<DropdownMenuEntry<DummyParentCategory>> iconEntries =
    <DropdownMenuEntry<DummyParentCategory>>[];
    for (final icon in DummyParentCategory.values) {
      iconEntries.add(DropdownMenuEntry<DummyParentCategory>(
        value: icon,
        label: icon.label,
        leadingIcon: Icon(icon.icon),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Category',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'New Category',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset('assets/categoryThumbnail.png'),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      maximumSize: const Size(150, 48.0),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.photo,
                            color: Theme.of(context).colorScheme.onPrimary),
                        Text(
                          'Add Image',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter a name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownMenu<DummyParentCategory>(
              controller: iconController,
              enableFilter: true,
              leadingIcon: const Icon(Icons.search),
              label: const Text('Parent Category'),
              dropdownMenuEntries: iconEntries,
              onSelected: (DummyParentCategory? icon) {
                setState(() {
                  parentCategory = icon;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum DummyParentCategory {
  statue('Statue', Icons.accessibility),
  picture('Picture', Icons.filter_frames_outlined),
  consumable('Consumable', Icons.savings_outlined),
  food('Food', Icons.fastfood_outlined),
  trash('Trash', Icons.restore_from_trash);

  const DummyParentCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}
