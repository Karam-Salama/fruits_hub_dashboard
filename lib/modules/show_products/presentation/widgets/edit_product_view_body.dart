import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../add_product/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/core/functions/build_custom_dialog.dart';
import 'package:fruits_hub_dashboard/core/functions/validation.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:fruits_hub_dashboard/core/utils/app_text_styles.dart';
import 'package:fruits_hub_dashboard/core/widgets/custom_btn.dart';
import 'package:fruits_hub_dashboard/core/widgets/custom_dialog_widget.dart';
import 'package:fruits_hub_dashboard/modules/add_product/presentation/manager/cubit/add_product_cubit.dart';

import '../../../add_product/presentation/widgets/custom_upload_product_image_widget.dart';
import '../../../add_product/presentation/widgets/cutom_text_form_field_widget_.dart';
import '../../../add_product/presentation/widgets/is_featured_product_widget.dart';
import '../../../add_product/presentation/widgets/is_organic_product_widget.dart';

class EditProductViewBody extends StatefulWidget {
  const EditProductViewBody({super.key, required this.product});
  final ProductEntity product;

  @override
  State<EditProductViewBody> createState() => _EditProductViewBodyState();
}

class _EditProductViewBodyState extends State<EditProductViewBody> {
  File? productImage;
  Uint8List? webProductImage;
  bool _imageChanged = false;

  late String productName;
  late String productCode;
  late num productPrice, expirationMonths, numberOfCalories;
  late num productDiscount, unitAmount;
  late String productDescription;
  late bool isFeatured;
  late bool isOrganic;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    // Initialize form fields with product data
    productName = widget.product.name;
    productCode = widget.product.code;
    productPrice = widget.product.price;
    productDiscount = widget.product.discount;
    expirationMonths = widget.product.expirationsMonths;
    numberOfCalories = widget.product.numberOfCalories;
    unitAmount = widget.product.unitAmount;
    productDescription = widget.product.description;
    isFeatured = widget.product.isFeatured;
    isOrganic = widget.product.isOrganic;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddProductCubit, AddProductState>(
          listener: (context, state) {
            if (state is AddProductSuccess) {
              buildCustomDialog(
                context,
                CustomDialog(
                  icon: Icons.check_circle,
                  message: "تم تعديل المنتج بنجاح",
                  textButton: 'حسناً',
                  onpressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context, true); // Return success
                  },
                ),
              );
            } else if (state is AddProductFailure) {
              buildCustomDialog(
                context,
                CustomDialog(
                  icon: Icons.error,
                  message: state.errorMessage,
                  textButton: 'جرب مرة اخرى',
                  onpressed: () {
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    SizedBox(height: size.height / 25),
                    CustomAppBar(
                      title: 'صفحه تعديل المنتج',
                      isVisibleTrailing: false,
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),
                    SizedBox(height: size.height / 20),
                    CustomUploadImageWidget(
                      initialImageUrl: widget.product.imageUrl,
                      onImageSelected: (value) {
                        setState(() {
                          if (kIsWeb) {
                            webProductImage = value;
                          } else {
                            productImage = value;
                          }
                          _imageChanged = true;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "أسم المنتج",
                      initialValue: productName,
                      keyboardType: TextInputType.name,
                      validator: Validation.makeValidation,
                      onSaved: (value) {
                        productName = value!;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "رقم المنتج",
                      initialValue: productCode,
                      keyboardType: TextInputType.number,
                      validator: Validation.makeValidation,
                      onSaved: (value) {
                        productCode = value!.toLowerCase();
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "سعر المنتج",
                      initialValue: productPrice.toString(),
                      keyboardType: TextInputType.number,
                      validator: Validation.makeValidation,
                      onSaved: (value) {
                        productPrice = num.parse(value!);
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "خصم المنتج",
                      initialValue: productDiscount.toString(),
                      keyboardType: TextInputType.number,
                      validator: Validation.makeValidation,
                      onSaved: (value) {
                        productDiscount = num.parse(value!);
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "عدد اشهر الصلاحية",
                      initialValue: expirationMonths.toString(),
                      keyboardType: TextInputType.number,
                      validator: Validation.makeValidation,
                      onSaved: (value) {
                        expirationMonths = num.parse(value!);
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "عدد سعرات المنتج",
                      initialValue: numberOfCalories.toString(),
                      keyboardType: TextInputType.number,
                      validator: Validation.makeValidation,
                      onSaved: (value) {
                        numberOfCalories = num.parse(value!);
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "سعر الوحدة",
                      initialValue: unitAmount.toString(),
                      keyboardType: TextInputType.number,
                      validator: Validation.makeValidation,
                      onSaved: (value) {
                        unitAmount = num.parse(value!);
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "وصف المنتج",
                      initialValue: productDescription,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      validator: Validation.makeValidation,
                      onSaved: (value) {
                        productDescription = value!;
                      },
                    ),
                    const SizedBox(height: 12),
                    FeaturedCheckboxWidget(
                      value: isFeatured,
                      onChanged: (value) {
                        setState(() {
                          isFeatured = value!;
                        });
                      },
                    ),
                    IsOrganicCheckboxWidget(
                      value: isOrganic,
                      onChanged: (value) {
                        setState(() {
                          isOrganic = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    state is AddProductLoading
                        ? const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  text: 'حفظ التعديلات',
                                  style: AppTextStyle.Cairo600style16.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      final updatedProduct = ProductEntity(
                                        name: productName,
                                        code: widget.product.code,
                                        price: productPrice,
                                        discount: productDiscount,
                                        description: productDescription,
                                        isFeatured: isFeatured,
                                        expirationsMonths:
                                            expirationMonths.toInt(),
                                        numberOfCalories:
                                            numberOfCalories.toInt(),
                                        unitAmount: unitAmount.toInt(),
                                        isOrganic: isOrganic,
                                        reviews: widget.product.reviews,
                                        imageUrl: widget.product.imageUrl,
                                        image: widget.product.image,
                                      );

                                      if (_imageChanged) {
                                        final imageToUse = kIsWeb
                                            ? webProductImage
                                            : productImage;
                                        context
                                            .read<AddProductCubit>()
                                            .updateProductWithImage(
                                              updatedProduct,
                                              imageToUse!,
                                            );
                                      } else {
                                        context
                                            .read<AddProductCubit>()
                                            .updateProduct(updatedProduct);
                                      }
                                    } else {
                                      setState(() {
                                        autovalidateMode =
                                            AutovalidateMode.always;
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomButton(
                                  text: 'إلغاء',
                                  style: AppTextStyle.Cairo600style16.copyWith(
                                    color: AppColors.redColor,
                                  ),
                                  backGroundColor: AppColors.whiteColor,
                                  borderColor: AppColors.redColor,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
