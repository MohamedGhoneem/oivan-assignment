import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oivan_assignment/features/users/presentation/view/reputation/reputation_page.dart';

import '../../../../domain/entity/user_entity.dart';

class UserListItem extends StatelessWidget {
  final UserEntity user;

  const UserListItem({super.key, required this.user});

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
            // Implement bookmark toggle logic
          },
        ),
      ),
    );
  }
}