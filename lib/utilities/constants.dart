import 'package:flutter/material.dart';
import 'package:network_implementation/network_implementation.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
NetworkImplementation network =
    NetworkImplementation.instance('https://api.stackexchange.com/2.2');
String usersEndPoint = '/users';
String reputationsEndPoint = '/reputation-history';
