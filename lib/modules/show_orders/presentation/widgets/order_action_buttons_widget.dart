import 'package:flutter/material.dart';

import 'package:fruits_hub_dashboard/core/utils/app_text_styles.dart';
import 'package:fruits_hub_dashboard/core/widgets/custom_btn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/order_enum.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/order_entity.dart';
import '../cubit/update_order_cubit.dart';

class OrderActionButtonsWidget extends StatelessWidget {
  const OrderActionButtonsWidget({super.key, required this.orderEntity});
  final OrderEntity orderEntity;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Visibility(
        visible: orderEntity.status == OrderStatusEnum.pending,
        child: Expanded(
          child: CustomButton(
            text: "قبول الطلب",
            onPressed: () {
              context.read<UpdateOrderCubit>().updateOrderStatus(
                    status: OrderStatusEnum.accepted,
                    orderId: orderEntity.orderId,
                  );
            },
            style: AppTextStyle.Cairo700style16,
            backGroundColor: AppColors.acceptedColor,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Visibility(
        visible: orderEntity.status == OrderStatusEnum.pending,
        child: Expanded(
          child: CustomButton(
            text: "إلغاء الطلب",
            onPressed: () {
              context.read<UpdateOrderCubit>().updateOrderStatus(
                    status: OrderStatusEnum.cancelled,
                    orderId: orderEntity.orderId,
                  );
            },
            style: AppTextStyle.Cairo700style16,
            backGroundColor: AppColors.cancelledColor,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Visibility(
        visible: orderEntity.status == OrderStatusEnum.accepted,
        child: Expanded(
          child: CustomButton(
            text: "تاكيد الطلب",
            onPressed: () {
              context.read<UpdateOrderCubit>().updateOrderStatus(
                    status: OrderStatusEnum.delivered,
                    orderId: orderEntity.orderId,
                  );
            },
            style: AppTextStyle.Cairo700style16,
            backGroundColor: AppColors.deliveredColor,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    ]);
  }
}
