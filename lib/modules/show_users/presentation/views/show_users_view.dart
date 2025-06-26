import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/repo/show_user_repo.dart';
import '../cubit/show_users_cubit.dart';
import '../widgets/show_users_view_body.dart';

class ShowUsersView extends StatelessWidget {
  const ShowUsersView({super.key});
  static const String routeName = 'show-users-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            ShowUsersCubit(showUsersRepo: getIt<ShowUsersRepo>())..getUsers(),
        child: ShowUsersViewBody(),
      ),
    );
  }
}
