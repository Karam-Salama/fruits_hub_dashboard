import 'package:flutter/material.dart';

import '../widgets/show_users_view_body.dart';

class ShowUsersView extends StatelessWidget {
  const ShowUsersView({super.key});
  static const String routeName = 'show-users-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ShowUsersViewBody(),
    );
  }
}
