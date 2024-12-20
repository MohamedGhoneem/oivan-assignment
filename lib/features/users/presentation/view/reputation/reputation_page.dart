import 'package:app_fundamentals/app_fundamentals.dart';
import 'package:flutter/material.dart';
import 'package:oivan_assignment/features/users/presentation/view/reputation/reputation_page_mobile.dart';
import '../../../domain/entity/user_entity.dart';

class ReputationPage extends StatelessWidget {
  final UserEntity user;

  const ReputationPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ReputationPageMobile(user: user),
    );
  }
}
