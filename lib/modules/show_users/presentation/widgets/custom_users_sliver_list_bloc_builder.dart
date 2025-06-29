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
        final cubit = context.read<ShowUsersCubit>();

        if (state is ShowUsersSuccessState) {
          return CustomUserSliverList(users: state.users);
        } else if (state is ShowUsersErrorState) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(text: state.errorMessage),
          );
        } else if (state is DeleteUsersLoadingState) {
          return SliverToBoxAdapter(
            child: Stack(
              children: [
                CustomScrollView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    CustomUserSliverList(users: cubit.currentUsers),
                  ],
                ),
                Container(
                  color: Colors.white.withOpacity(0.6),
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          );
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
