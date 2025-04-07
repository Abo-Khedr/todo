import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/home/addTaskBottomSheet/add_task_bottom_sheet.dart';
import 'package:todo/home/settings/settings_tab.dart';
import 'package:todo/home/task/task_tab.dart';
import 'package:todo/provider/auth_user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthUserProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          "To Do List{${authProvider.currentUser!.name}}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              authProvider.currentUser = null;
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: AppColors.whiteColor,
            width: 3,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AddTaskBottomSheet();
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: AppColors.whiteColor,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        notchMargin: 6,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 30,
              ),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 30,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    TaskTab(),
    SettingsTab(),
  ];
}
