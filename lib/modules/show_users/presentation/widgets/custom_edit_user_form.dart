import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/modules/add_user/domain/entities/user_entity.dart';

class CustomEditUserForm extends StatelessWidget {
  const CustomEditUserForm({super.key, required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("hello ${user.name}"),
    );
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