import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const Search({
    super.key,
    this.focusNode,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search restaurant.',
          hintStyle: Theme.of(context).textTheme.titleMedium,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: Theme.of(context).textTheme.titleMedium);
  }
}
