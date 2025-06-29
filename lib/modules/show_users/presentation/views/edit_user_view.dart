import 'package:flutter/material.dart';

import '../../../add_user/domain/entities/user_entity.dart';
import '../widgets/edit_user_view_body.dart';

class EditUserView extends StatelessWidget {
  const EditUserView({super.key, required this.user});
  static const String routeName = '/edit-user';
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditUserViewBody(user: user),
    );
  }
}
