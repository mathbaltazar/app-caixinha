import 'package:flutter/material.dart';

class VerticalIconTextWidget extends StatelessWidget {
  const VerticalIconTextWidget({
    super.key,
    required this.icon,
    this.iconSize,
    required this.label,
    this.tonal,
    this.enabled,
    this.onTap,
  });

  final Icon icon;
  final double? iconSize;
  final Widget label;
  final Function()? onTap;
  final bool? enabled;
  final bool? tonal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          tonal == true ? IconButton.filledTonal(
            visualDensity: VisualDensity.compact,
            icon: icon,
            color: icon.color,
            iconSize: iconSize,
            onPressed: enabled ?? true ? onTap : null,
          )
          : IconButton.filled(
            visualDensity: VisualDensity.compact,
            icon: icon,
            color: icon.color,
            iconSize: iconSize,
            onPressed: enabled ?? true ? onTap : null,
          ),
          label,
        ],
      ),
    );
  }
}
