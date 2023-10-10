import 'package:bus_hub/widgets/credit_info.dart';
import 'package:bus_hub/widgets/quick_links.dart';
import 'package:bus_hub/widgets/trending_routes.dart';
import 'package:bus_hub/widgets/user_info.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text("Home"),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              // User info
              UserInfo(),
              // Credit details
              CreditInfo(),
              // Quick acccess
              QuickLinks(),
              // Trending routes
              TrendingRoutes(),
            ],
          ),
        ),
      ),
    );
  }
}
