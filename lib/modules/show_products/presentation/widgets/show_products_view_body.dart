import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/core/utils/app_assets.dart';
import 'package:fruits_hub_dashboard/modules/add_product/domain/entities/product_entity.dart';
import 'package:fruits_hub_dashboard/modules/show_products/presentation/cubit/show_products_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/functions/get_dummy_product.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../show_users/presentation/widgets/custom_user_operation_widget.dart';
import '../cubit/show_products_cubit.dart';

class ShowProductsViewBody extends StatelessWidget {
  const ShowProductsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 20),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: size.height / 15)),
            SliverToBoxAdapter(
              child: CustomAppBar(
                title: "صفحه عرض المنتجات",
                isVisibleTrailing: false,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ProductsSliverListBlocBuilder(),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class ProductsSliverListBlocBuilder extends StatelessWidget {
  const ProductsSliverListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowProductsCubit, ShowProductsState>(
      builder: (context, state) {
        if (state is ShowProductsSuccess) {
          return CustomProductsSliverList(products: state.products);
        } else if (state is ShowProductsFailure) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(text: state.errorMessage),
          );
        } else {
          return Skeletonizer.sliver(
            enabled: true,
            child: CustomProductsSliverList(products: getDummyProducts()),
          );
        }
      },
    );
  }
}

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
          icon: Assets.assetsIconsEditUser,
          color: AppColors.blueColor,
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
          icon: Assets.assetsIconsDeleteUser,
          color: AppColors.redColor,
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

class EditProductView extends StatelessWidget {
  const EditProductView({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: EditProductViewBody(product: product));
  }
}

class EditProductViewBody extends StatelessWidget {
  const EditProductViewBody({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Edit product ${product.name}"),
    );
  }
}
