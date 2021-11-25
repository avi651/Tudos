import 'package:flutter/material.dart';
import 'package:sq_mob/components/home_components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: HomeComponent(),
    );
  }
}
