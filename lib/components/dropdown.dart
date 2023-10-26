import 'package:dashboard_breeds/theme/colors_references.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  final String? value;
  final String hintText;
  final String? disabledIintText;
  final List<DropdownMenuItem<String>>? items;
  final Function(String?)? onChanged;
  const Dropdown(
      {Key? key,
      this.value,
      required this.hintText,
      this.disabledIintText,
      this.items,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      menuMaxHeight: 200.0,
      iconDisabledColor: ColorsReferences.accentColor.withAlpha(70),
      iconEnabledColor: ColorsReferences.accentColor,
      dropdownColor: ColorsReferences.backgroundDropdownMenu,
      disabledHint: disabledIintText != null
          ? Text(
              disabledIintText!,
              style: TextStyle(
                color: ColorsReferences.accentColor.withAlpha(70),
                fontSize: 10.0,
              ),
            )
          : null,
      hint: Text(
        hintText,
        style: TextStyle(
          color: ColorsReferences.accentColor.withAlpha(70),
          fontSize: 10.0,
        ),
      ),
      style: const TextStyle(fontSize: 12.0, color: ColorsReferences.textColor),
      items: items,
      onChanged: onChanged,
    );
  }
}
