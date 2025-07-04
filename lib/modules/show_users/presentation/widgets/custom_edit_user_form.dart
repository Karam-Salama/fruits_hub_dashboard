import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/core/functions/validation.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:fruits_hub_dashboard/modules/add_user/domain/entities/user_entity.dart';

import '../../../../core/functions/build_custom_dialog.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../../add_product/presentation/widgets/cutom_text_form_field_widget_.dart';
import '../../../add_user/presentation/cubit/add_user_cubit.dart';
import '../../../add_user/presentation/cubit/add_user_states.dart';

class CustomEditUserForm extends StatefulWidget {
  const CustomEditUserForm({super.key, required this.user});
  final UserEntity user;

  @override
  State<CustomEditUserForm> createState() => _CustomEditUserFormState();
}

class _CustomEditUserFormState extends State<CustomEditUserForm> {
  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode _autoValidateMode;

  late String _name;
  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _autoValidateMode = AutovalidateMode.disabled;

    _name = widget.user.name;
    _email = widget.user.email;
    _password = '';
  }

  @override
  Widget build(BuildContext context) {
    final addUserCubit = BlocProvider.of<AddUserCubit>(context);

    return BlocConsumer<AddUserCubit, AddUserState>(
      listener: (context, state) {
        if (state is UserUpdatedSuccessState) {
          buildCustomDialog(
            context,
            CustomDialog(
              icon: Icons.check_circle,
              message: "تم تحديث بيانات المستخدم بنجاح",
              textButton: 'حسناً',
              onpressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
            ),
          );
        } else if (state is AddUserErrorState) {
          buildCustomDialog(
            context,
            CustomDialog(
              icon: Icons.error,
              message: state.errorMessage,
              textButton: 'حاول مرة أخرى',
              onpressed: () => Navigator.pop(context),
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: Column(
            children: [
              CustomTextFormField(
                initialValue: _name,
                hintText: "الاسم الكامل",
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال الاسم';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                initialValue: _email,
                hintText: "البريد الإلكتروني",
                keyboardType: TextInputType.emailAddress,
                validator: Validation.validateEmail,
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                initialValue: _password,
                hintText: "كلمة المرور الجديدة (اختياري)",
                obscureText: true,
                validator: Validation.validateOptionalPassword,
                onSaved: (value) => _password = value ?? '',
              ),
              const SizedBox(height: 30),
              if (state is AddUserLoadingState)
                const CircularProgressIndicator(color: AppColors.primaryColor)
              else
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "حفظ التعديلات",
                        mainAxisAlignment: MainAxisAlignment.center,
                        style: AppTextStyle.Cairo700style16,
                        onPressed: _submitForm,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: "إلغاء",
                        style: AppTextStyle.Cairo700style16.copyWith(
                          color: AppColors.redColor,
                        ),
                        backGroundColor: AppColors.whiteColor,
                        borderColor: AppColors.redColor,
                        onPressed: () => Navigator.pop(context),
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedUser = widget.user.copyWith(
        name: _name,
        email: _email,
        password: _password.isEmpty ? null : _password,
      );

      BlocProvider.of<AddUserCubit>(context).updateUser(user: updatedUser);
    } else {
      setState(() => _autoValidateMode = AutovalidateMode.always);
    }
  }
}




/**
 * 
 * 
class CustomAddUserForm extends StatefulWidget {
  const CustomAddUserForm({super.key});

  @override
  State<CustomAddUserForm> createState() => _CustomAddUserFormState();
}

class _CustomAddUserFormState extends State<CustomAddUserForm> {
  @override
  Widget build(BuildContext context) {
    AddUserCubit addUserCubit = BlocProvider.of<AddUserCubit>(context);

    return BlocConsumer<AddUserCubit, AddUserState>(
      listener: (context, state) {
        if (state is AddUserSuccessState) {
          buildCustomDialog(
            context,
            CustomDialog(
              icon: Icons.check_circle,
              message: "تم اضافة المستخدم بنجاح برجاء تفعيل الحساب",
              textButton: 'حسناً',
              onpressed: () {
                Navigator.pop(context);
              },
            ),
          );
        } else if (state is AddUserErrorState) {
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
        return Form(
          key: addUserCubit.addUserFormKey,
          autovalidateMode: addUserCubit.addUserAutoValidateMode,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: AppStrings.fullName,
                keyboardType: TextInputType.name,
                onSaved: (name) {
                  addUserCubit.name = name;
                },
                validator: Validation.validateName,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: AppStrings.Email,
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) {
                  addUserCubit.emailAddress = email;
                },
                validator: Validation.validateEmail,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: AppStrings.password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !addUserCubit.isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    addUserCubit.isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.greyColor,
                  ),
                  onPressed: () {
                    addUserCubit.togglePasswordVisibility();
                  },
                ),
                validator: Validation.validatePassword,
                onSaved: (password) {
                  addUserCubit.password = password;
                },
              ),
              const SizedBox(height: 30),
              state is AddUserLoadingState
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor)
                  : CustomButton(
                      text: "اضافة المستخدم",
                      style: AppTextStyle.Cairo700style16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressed: () async {
                        if (addUserCubit.addUserFormKey.currentState!
                            .validate()) {
                          addUserCubit.addUserFormKey.currentState!.save();
                          addUserCubit.addUser(
                            addUserCubit.emailAddress!,
                            addUserCubit.password!,
                            addUserCubit.name!,
                          );
                        } else {
                          setState(() {
                            addUserCubit.addUserAutoValidateMode =
                                AutovalidateMode.always;
                          });
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}

 */