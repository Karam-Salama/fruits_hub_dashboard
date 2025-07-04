import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../../add_user/domain/entities/user_entity.dart';
import '../../../add_user/domain/repo/add_user_repo.dart';
import '../../../add_user/presentation/cubit/add_user_cubit.dart';
import '../widgets/edit_user_view_body.dart';

class EditUserView extends StatelessWidget {
  const EditUserView({super.key, required this.user});
  static const String routeName = '/edit-user';
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddUserCubit(authRepo: getIt<AddUserRepo>()),
        child: EditUserViewBody(user: user),
      ),
    );
  }
}
