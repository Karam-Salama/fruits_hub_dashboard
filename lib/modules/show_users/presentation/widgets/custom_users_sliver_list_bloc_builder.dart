import 'package:flutter/material.dart';

import '../../../../core/functions/get_dummy_users.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../cubit/show_users_cubit.dart';
import '../cubit/show_users_states.dart';
import 'custom_user_sliver_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomUsersSliverListBlocBuilder extends StatelessWidget {
  const CustomUsersSliverListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowUsersCubit, ShowUsersStates>(
      builder: (context, state) {
        if (state is ShowUsersSuccessState) {
          return CustomUserSliverList(users: state.users);
        } else if (state is ShowUsersErrorState) {
          return SliverToBoxAdapter(
              child: CustomErrorWidget(text: state.errorMessage));
        } else {
          return Skeletonizer.sliver(
            enabled: true,
            child: CustomUserSliverList(users: getDummyUsersList()),
          );
        }
      },
    );
  }
}
