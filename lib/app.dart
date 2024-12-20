import 'package:flutter/material.dart';
import 'package:oivan_assignment/features/users/presentation/view/users/users_page.dart';
import 'core/design_system/app_colors.dart';
import 'core/design_system/fonts.dart';
import 'core/design_system/size_config.dart';

import 'utilities/constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Oivan',
      theme: ThemeData(
        fontFamily: Fonts.urbanist.name,
        primaryColor: primaryColor,
      ),
      home: const UsersPage(),
    );
  }
}
