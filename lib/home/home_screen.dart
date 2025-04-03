import 'package:flutter/material.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/home/addTaskBottomSheet/add_task_bottom_sheet.dart';
import 'package:todo/home/settings/settings_tab.dart';
import 'package:todo/home/task/task_tab.dart';

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
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          "To Do List",
          style: Theme.of(context).textTheme.titleLarge,
        ),
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
          showModalBottomSheet(context: context,
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
