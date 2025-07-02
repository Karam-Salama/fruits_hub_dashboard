import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../add_product/domain/entities/product_entity.dart';
import '../../../show_users/presentation/widgets/custom_user_operation_widget.dart';
import '../cubit/show_products_cubit.dart';
import '../cubit/show_products_states.dart';
import '../views/edit_product_view.dart';

class CustomProductsSliverList extends StatelessWidget {
  const CustomProductsSliverList({super.key, required this.products});
  final List<ProductEntity> products;

  void _showDeleteConfirmationDialog(BuildContext context, String productId) {
    final cubit = BlocProvider.of<ShowProductsCubit>(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تأكيد الحذف"),
        content: const Text("هل أنت متأكد أنك تريد حذف هذا المنتج؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.deleteProduct(productId);
            },
            child: const Text(
              "حذف",
              style: TextStyle(color: AppColors.redColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    if (products.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text("لا يوجد منتجات لعرضها")),
      );
    }

    return BlocListener<ShowProductsCubit, ShowProductsState>(
      listener: (context, state) {
        if (state is DeleteProductErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];
            final discountPrice = calculateAfterDiscount(product);

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 0.0 : 12.0,
                vertical: 4.0,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    product.name,
                    style: AppTextStyle.Cairo400style13.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${product.unitAmount} ${AppStrings.kilo}',
                            style: AppTextStyle.Cairo400style13,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${discountPrice.toStringAsFixed(2)} ج.م',
                            style: AppTextStyle.Cairo600style16.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      if (product.discount > 0) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${product.price} ج.م',
                              style: AppTextStyle.Cairo600style13.copyWith(
                                color: AppColors.secondaryColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${product.discount}% خصم',
                                style: AppTextStyle.Cairo600style10.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.lightGreyColor),
                      image: DecorationImage(
                        image: NetworkImage(product.imageUrl!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  trailing: isMobile
                      ? _buildMobileActions(context, product)
                      : _buildDesktopActions(context, product),
                ),
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  Widget _buildDesktopActions(BuildContext context, ProductEntity product) {
    return Wrap(
      spacing: 10,
      children: [
        CustomTwoOperationWidget(
          text: "تعديل",
          backGroundColor: AppColors.lighterBlueColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProductView(product: product),
              ),
            );
          },
        ),
        CustomTwoOperationWidget(
          text: "حذف",
          backGroundColor: AppColors.lighterRedColor,
          onTap: () {
            _showDeleteConfirmationDialog(context, product.code);
          },
        ),
      ],
    );
  }

  Widget _buildMobileActions(BuildContext context, ProductEntity product) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: AppColors.greyColor),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: AppColors.blueColor, size: 20),
              SizedBox(width: 8),
              Text("تعديل"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: AppColors.redColor, size: 20),
              SizedBox(width: 8),
              Text("حذف"),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 'edit') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProductView(product: product),
            ),
          );
        } else if (value == 'delete') {
          _showDeleteConfirmationDialog(context, product.code);
        }
      },
    );
  }

  double calculateAfterDiscount(ProductEntity product) {
    return product.price - (product.price * product.discount / 100);
  }
}
