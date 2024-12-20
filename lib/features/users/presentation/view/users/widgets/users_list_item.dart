import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oivan_assignment/features/users/presentation/view/reputation/reputation_page.dart';

import '../../../../domain/entity/user_entity.dart';
import '../../../bloc/users_bloc.dart';

class UserListItem extends StatelessWidget {
  final UserEntity user;
final UsersBloc bloc;
  const UserListItem({super.key, required this.user, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: (){
          Navigator.push(context, CupertinoPageRoute(
            builder: (context) =>  ReputationPage(user: user,),
          ));
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.profileImage),
        ),
        title: Text(user.displayName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reputation: ${user.reputation}'),
            Text('Location: ${user.location}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            user.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: user.isBookmarked ? Colors.blue : null,
          ),
          onPressed: () {
            bloc.toggleUserBookmark(user);
          },
        ),
      ),
    );
  }
}