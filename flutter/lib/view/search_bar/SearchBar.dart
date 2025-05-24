import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score/controller/controllers.dart' as SB;

class SearchBar extends GetView<SB.SearchController> {
  final BorderRadiusGeometry? borderRadius;
  final void Function(String)? onChangedInput;
  final void Function()? onClearedInput;
  final void Function(String)? onSubmittedInput;
  const SearchBar({
    Key? key,
    this.borderRadius,
    this.onChangedInput,
    this.onClearedInput,
    this.onSubmittedInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _inputField(context);
  }

  Widget _inputField(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      child: TextField(
        controller: controller.keywordController,
        cursorColor: Colors.yellow[800],
        style: Theme.of(context).textTheme.headlineMedium,
        onChanged: _onChangedInput,
        onSubmitted: _onSubmittedInput,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          enabledBorder: _noBorder(),
          focusedBorder: _borderBottomOnly(),
          prefixIcon: const Icon(
            CupertinoIcons.search,
          ),
          suffixIcon: IconButton(
            color: Colors.blueGrey[300],
            icon: const Icon(CupertinoIcons.clear),
            onPressed: _onClearedInput,
          ),
        ),
      ),
    );
  }

  void _onChangedInput(String input) {
    if (kDebugMode) {
      print("${input}");
    }
    if (onChangedInput != null) {
      onChangedInput!(input);
    }
  }

  void _onClearedInput() {
    controller.clearTextField();
    if (onClearedInput != null) {
      onClearedInput!();
    }
  }

  void _onSubmittedInput(String input) {
    print(input);
    controller.searchOnGoogle(input);
    if (onSubmittedInput != null) {
      onSubmittedInput!(input);
    }
  }

  InputBorder _noBorder() {
    return InputBorder.none;
  }

  InputBorder _borderBottomOnly() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blueGrey[200]!,
      ),
    );
  }
}