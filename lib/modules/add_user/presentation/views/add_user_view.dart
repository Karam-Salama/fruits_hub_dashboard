import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/core/services/service_locator.dart';

import '../../domain/repo/auth_repo.dart';
import '../cubit/add_user_cubit.dart';
import '../widgets/add_user_view_body.dart';

class AddUserView extends StatelessWidget {
  const AddUserView({super.key});
  static const String routeName = 'add-user-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddUserCubit(authRepo: getIt<AuthRepo>()),
        child: AddUserViewBody(),
      ),
    );
  }
}
