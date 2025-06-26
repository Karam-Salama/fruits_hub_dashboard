import '../../modules/add_user/domain/entities/user_entity.dart';

UserEntity getDummyUsers() {
  return UserEntity(
    name: 'test',
    email: 'test@text.com',
    uId: 'test',
  );
}

List<UserEntity> getDummyUsersList() {
  return List.generate(5, (_) => getDummyUsers());
}
