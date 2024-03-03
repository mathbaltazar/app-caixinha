import 'package:app_caixinha/app/core/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

class EmptyParticipantsStartWidget extends StatelessWidget {
  const EmptyParticipantsStartWidget({super.key, required this.onAddPressed});

  final Function() onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Nenhum particpante ainda.',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 120),
        IconButton(
          iconSize: 48,
          onPressed: onAddPressed,
          icon: Icon(
            Icons.add_circle,
            color: AppColors.colorPrimary,
          ),
        ),
        const Text('Adicionar participante'),
      ],
    );
  }
}
