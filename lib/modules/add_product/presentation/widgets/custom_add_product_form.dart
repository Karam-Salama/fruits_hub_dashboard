// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/functions/build_custom_dialog.dart';
import '../../../../core/functions/validation.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../domain/entities/product_entity.dart';
import '../manager/cubit/add_product_cubit.dart';
import 'custom_upload_product_image_widget.dart';
import 'cutom_text_form_field_widget_.dart';
import 'is_featured_product_widget.dart';
import 'is_organic_product_widget.dart';

class CustomAddProductForm extends StatefulWidget {
  const CustomAddProductForm({super.key});

  @override
  State<CustomAddProductForm> createState() => _CustomAddProductFormState();
}

class _CustomAddProductFormState extends State<CustomAddProductForm> {
  File? productImage;
  String? productName;
  String? productCode;
  num? productPrice, expirationMonths, numberOfCalories;
  num? productDiscount, unitAmount;
  String? productDescription;
  bool isFeatured = false;
  bool isOrganic = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddProductSuccess) {
          buildCustomDialog(
            context,
            CustomDialog(
              icon: Icons.check_circle,
              message: 'Product Added Successfully',
              textButton: 'Ok',
              onpressed: () {
                Navigator.pop(context);
              },
            ),
          );
        } else if (state is AddProductFailure) {
          buildCustomDialog(
            context,
            CustomDialog(
              icon: Icons.error,
              message: state.errorMessage,
              textButton: 'Try Again',
              onpressed: () {
                Navigator.pop(context);
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              CustomUploadImageWidget(
                onImageSelected: (value) {
                  productImage = value;
                },
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: "Product Name",
                keyboardType: TextInputType.name,
                validator: Validation.makeValidation,
                onSaved: (value) {
                  productName = value!;
                },
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: "Product Code",
                keyboardType: TextInputType.number,
                validator: Validation.makeValidation,
                onSaved: (value) {
                  productCode = value!.toLowerCase();
                },
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: "Product Price",
                keyboardType: TextInputType.number,
                validator: Validation.makeValidation,
                onSaved: (value) {
                  productPrice = num.parse(value!);
                },
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: "Product Discount",
                keyboardType: TextInputType.number,
                validator: Validation.makeValidation,
                onSaved: (value) {
                  productDiscount = num.parse(value!);
                },
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: "Expiration Months",
                keyboardType: TextInputType.number,
                validator: Validation.makeValidation,
                onSaved: (value) {
                  expirationMonths = num.parse(value!);
                },
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: "Number of Calories",
                keyboardType: TextInputType.number,
                validator: Validation.makeValidation,
                onSaved: (value) {
                  numberOfCalories = num.parse(value!);
                },
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: "Unit Amount",
                keyboardType: TextInputType.number,
                validator: Validation.makeValidation,
                onSaved: (value) {
                  unitAmount = num.parse(value!);
                },
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: "Product Description",
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
              state is AddProductLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomButton(
                      text: 'Add Product',
                      style: AppTextStyle.Cairo700style16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressed: () async {
                        if (productImage != null) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ProductEntity addProductEntity = ProductEntity(
                                name: productName!,
                                image: productImage!,
                                code: productCode!,
                                price: productPrice!,
                                discount: productDiscount!,
                                description: productDescription!,
                                isFeatured: isFeatured,
                                expirationsMonths: expirationMonths!.toInt(),
                                numberOfCalories: numberOfCalories!.toInt(),
                                unitAmount: unitAmount!.toInt(),
                                isOrganic: isOrganic,
                                reviews: []);
                            context
                                .read<AddProductCubit>()
                                .addProduct(addProductEntity);
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        } else {
                          showError(context);
                        }
                      },
                    ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void showError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please select an image'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
