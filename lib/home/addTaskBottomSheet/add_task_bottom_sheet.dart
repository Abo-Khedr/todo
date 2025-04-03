import 'package:flutter/material.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/model/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add New Task",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text(
                  'Enter task title',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                label: Text(
                  'Enter task description',
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Selected Time',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                showDateFun();
              },
              child: Text(
                selectedDate.toString().substring(0, 10),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                Task task = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  dateTime:
                      DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
                );
                FirebaseFunctions.addTask(task);

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  )),
              child: Text(
                'Add Task',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDateFun() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(
          days: 365,
        ),
      ),
    );
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }
}
