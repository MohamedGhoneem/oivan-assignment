import 'package:app_fundamentals/app_fundamentals.dart';
import 'package:flutter/material.dart';
import 'package:oivan_assignment/features/users/presentation/view/users/widgets/users_list_item.dart';
import '../../../../../main.dart';
import '../../../domain/entity/user_entity.dart';
import '../../bloc/users_bloc.dart';

class UsersPageMobile extends BaseStatefulWidget {
  const UsersPageMobile({super.key});

  @override
  BaseState<UsersPageMobile> createState() => _UsersPageMobileState();
}

class _UsersPageMobileState extends BaseState<UsersPageMobile> {
  late final UsersBloc _usersBloc;

  @override
  void initState() {
    super.initState();
    _usersBloc = UsersBloc(getIt(), getIt(), getIt());
    _usersBloc.fetchUsers();
  }

  @override
  Widget setBody(BuildContext context) {
    return StreamBuilder<List<UserEntity>>(
      stream: _usersBloc.usersStream,
      builder: (context, snapshot) {
        return StreamingResult(
          subject: _usersBloc.requestStateSubject,
          successWidget: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              physics:
                  const ClampingScrollPhysics(), // This helps maintain position
            ),
            child: ListView.builder(
              controller: _usersBloc.paginationHandler.controller,
              itemCount: _usersBloc.filteredUsers.length,
              itemBuilder: (context, index) {
                return UserListItem(user: _usersBloc.filteredUsers[index], bloc: _usersBloc,);
              },
            ),
          ),
          emptyWidget: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No Users Found'),
                ElevatedButton(
                  onPressed: _usersBloc.reset,
                  child: const Text('Refresh'),
                ),
              ],
            ),
          ),
          retry: _usersBloc.fetchUsers,
        );
      },
    );
  }

  @override
  PreferredSizeWidget? setAppbar() {
    return AppBar(
      title: const Text('Users'),
      actions: [
        StreamBuilder<bool>(
          stream: _usersBloc.showBookmarkedOnlyStream,
          initialData: false,
          builder: (context, snapshot) {
            return IconButton(
              icon: Icon(
                snapshot.data == true ? Icons.bookmark : Icons.bookmark_border,
              ),
              onPressed: _usersBloc.toggleBookmarkFilter,
              tooltip: 'Show Bookmarked Only',
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usersBloc.dispose();
    super.dispose();
  }
}
