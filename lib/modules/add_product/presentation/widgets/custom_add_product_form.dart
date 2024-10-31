// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import 'custom_upload_product_image_widget.dart';
import 'cutom_text_form_field_widget_.dart';

class CustomAddProductForm extends StatefulWidget {
  const CustomAddProductForm({super.key});

  @override
  State<CustomAddProductForm> createState() => _CustomAddProductFormState();
}

class _CustomAddProductFormState extends State<CustomAddProductForm> {
  String? productImage;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productDiscount;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomUploadImageWidget(onPressed: () {}),
          const SizedBox(height: 16),
          CustomTextFormField(
            hintText: "Product Name",
            keyboardType: TextInputType.name,
            onSaved: (name) {
              productName = name;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            hintText: "Product Description",
            maxLines: 6,
            keyboardType: TextInputType.text,
            onSaved: (description) {
              productDescription = description;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            hintText: "Product Price",
            keyboardType: TextInputType.number,
            onSaved: (price) {
              productPrice = price;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            hintText: "Product Discount",
            keyboardType: TextInputType.number,
            onSaved: (discount) {
              productDiscount = discount;
            },
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Add Product',
            style: AppTextStyle.Cairo700style16,
            mainAxisAlignment: MainAxisAlignment.center,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
