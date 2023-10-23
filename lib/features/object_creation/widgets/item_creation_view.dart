import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemCreationView extends ConsumerStatefulWidget {
  const ItemCreationView({super.key});

  @override
  ConsumerState<ItemCreationView> createState() => _ItemCreationViewState();
}

class _ItemCreationViewState extends ConsumerState<ItemCreationView> {
  DummyCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final TextEditingController iconController = TextEditingController();
    final List<DropdownMenuEntry<DummyCategory>> iconEntries =
        <DropdownMenuEntry<DummyCategory>>[];
    for (final icon in DummyCategory.values) {
      iconEntries.add(DropdownMenuEntry<DummyCategory>(
        value: icon,
        label: icon.label,
        leadingIcon: Icon(icon.icon),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Item',
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
              'New Item',
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
            const TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter a description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Price',
                hintText: 'Enter a price',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownMenu<DummyCategory>(
              controller: iconController,
              enableFilter: true,
              leadingIcon: const Icon(Icons.search),
              label: const Text('Category'),
              dropdownMenuEntries: iconEntries,
              onSelected: (DummyCategory? icon) {
                setState(() {
                  selectedCategory = icon;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum DummyCategory {
  statue('Statue', Icons.accessibility),
  picture('Picture', Icons.filter_frames_outlined),
  consumable('Consumable', Icons.savings_outlined),
  food('Food', Icons.fastfood_outlined),
  trash('Trash', Icons.restore_from_trash);

  const DummyCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}
