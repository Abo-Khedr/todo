import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/home/edit_screen.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/provider/auth_user_provider.dart';

class TaskItem extends StatelessWidget {
  Task task;

  TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthUserProvider>(context);
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.5,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFunctions.deleteTask(
                    task.id, authProvider.currentUser!.id!);
              },
              icon: Icons.delete,
              backgroundColor: AppColors.redColor,
              label: 'Delete',
              spacing: 8,
            ),
            SlidableAction(
              onPressed: (context) {
                // Navigator.pushNamed(context, EditScreen.roteName ,  arguments: task);
              },
              icon: Icons.edit,
              backgroundColor: AppColors.primaryColor,
              label: 'Edit',
              spacing: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              width: 4,
              height: 100,
              decoration: BoxDecoration(
                color:
                    task.isDone ? AppColors.greenColor : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: task.isDone
                          ? AppColors.greenColor
                          : AppColors.primaryColor),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  task.description,
                ),
              ],
            ),
            Spacer(),
            task.isDone
                ? Text(
                    'Done!',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.greenColor,
                        ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.all(0)),
                    onPressed: () {
                      task.isDone = true;
                      FirebaseFunctions.updateTask(
                          task, authProvider.currentUser!.id!);
                    },
                    child: Icon(
                      Icons.done,
                      size: 35,
                      color: AppColors.whiteColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
