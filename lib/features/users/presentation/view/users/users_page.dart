import 'package:app_fundamentals/app_fundamentals.dart';
import 'package:flutter/material.dart';
import 'users_page_mobile.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenTypeLayout(
      mobile: UsersPageMobile(),
    );
  }
}
