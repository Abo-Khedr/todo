import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/home/task/task_item.dart';
import 'package:todo/provider/auth_user_provider.dart';

class TaskTab extends StatefulWidget {
  TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthUserProvider>(context);
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: date,
            firstDate: DateTime.now().subtract(
              Duration(
                days: 365,
              ),
            ),
            lastDate: DateTime.now().add(
              Duration(
                days: 365,
              ),
            ),
            onDateSelected: (dateTime) {
              date = dateTime;
              setState(() {});
            },
            leftMargin: 20,
            monthColor: AppColors.primaryColor,
            dayColor: AppColors.primaryColor,
            activeDayColor: AppColors.whiteColor,
            activeBackgroundDayColor: AppColors.primaryColor,
            dotColor: AppColors.primaryColor,
            selectableDayPredicate: (date) => date.day != 15,
            locale: 'en',
          ),
          StreamBuilder(
            stream:
                FirebaseFunctions.getTask(date, authProvider.currentUser!.id!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      Text('Something went wrong'),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.primaryColor,
                  ),
                );
              }

              var tasks = snapshot.data?.docs
                  .map(
                    (e) => e.data(),
                  )
                  .toList();
              if (tasks!.isEmpty) {
                return Center(child: Text('No tasks '));
              }
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  itemBuilder: (context, index) {
                    return TaskItem(
                      task: tasks[index],
                    );
                  },
                  itemCount: tasks.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
