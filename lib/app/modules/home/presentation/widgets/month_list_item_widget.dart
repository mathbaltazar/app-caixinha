import 'package:app_caixinha/app/core/presentation/utils/text_utils.dart';
import 'package:app_caixinha/app/core/theme/color_schemes.g.dart';
import 'package:app_caixinha/app/modules/home/domain/models/month_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../domain/models/month_enum_model.dart';

class MonthListItemWidget extends StatefulWidget {
  const MonthListItemWidget({
    super.key,
    required this.monthIndex,
    required this.monthPaymentModel,
    this.actions,
  });

  final int monthIndex;
  final MonthPayment? monthPaymentModel;
  final List<Widget>? actions;

  @override
  State<MonthListItemWidget> createState() => _MonthListItemWidgetState();
}

class _MonthListItemWidgetState extends State<MonthListItemWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {
            setState(() => expanded = !expanded);
          },
          title: Row(
            children: [
              Expanded(
                child: Text(
                  MonthEnumModel.values[widget.monthIndex].name.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Text(
                'PAGO',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: widget.monthPaymentModel != null
                        ? AppColors.colorPrimary.withOpacity(0.7)
                        : Colors.black12),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.check_circle_rounded,
                color: widget.monthPaymentModel != null
                    ? AppColors.colorPrimary
                    : Colors.black12,
              ),
            ],
          ),
        ),
        Visibility(
            visible: expanded,
            child: Container(
              color: AppColors.primaryContainer.withOpacity(.5),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Valor pago: \$${TextUtils.formatCurrency(widget.monthPaymentModel?.amount ?? 0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.actions ?? [],
                  ),
                  const SizedBox(height: 10),
                ],
              ).animate().slideY(
                    begin: -1,
                    end: 0,
                    duration: const Duration(milliseconds: 80),
                  ),
            ))
      ],
    );
  }
}
