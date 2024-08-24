import 'dart:io';
import 'package:flutter/material.dart';
import 'Favourite.dart';
import 'Explore.dart';
import 'Profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    //final String data = ModalRoute.of(context)!.settings.arguments as String;
    //print(data);

    return PopScope(
      onPopInvoked: (c){
        exit(1);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food"),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          titleSpacing: 50,
          titleTextStyle: const TextStyle(
            fontSize: 25,
            color: Colors.black
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            Explore(),
            Favourite(),
            Profile(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Colors.red,
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            controller: _tabController,
            indicatorColor: Colors.white,
            dividerHeight: 0,
            tabs: const [
              Tab(
                icon:Icon(Icons.search,),
                text: "Explore",
              ),
              Tab(icon:Icon(Icons.favorite_border_outlined,),
                text: "Favourite",
              ),
              Tab(icon:Icon(Icons.person,),
                text: "Profile",
              ),
            ],
          ),
        ),
      )
    );
  }
}