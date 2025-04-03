// import 'package:flutter/material.dart';
// import 'package:todo/app_colors.dart';
// import 'package:todo/firebase_functions.dart';
// import 'package:todo/model/task_model.dart';
//
// class EditScreen extends StatefulWidget {
//   static const String roteName = 'Edit Screen';
//
//   const EditScreen({super.key});
//
//   @override
//   State<EditScreen> createState() => _EditScreenState();
// }
//
// class _EditScreenState extends State<EditScreen> {
//   DateTime selectedDate = DateTime.now();
//   var titleController = TextEditingController();
//   var descriptionController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     var args = ModalRoute.of(context)!.settings.arguments as Task;
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: MediaQuery.of(context).size.height * 0.15,
//         title: Text(
//           "To Do List",
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.all(25),
//             decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               borderRadius: BorderRadius.circular(
//                 25,
//               ),
//             ),
//             padding: EdgeInsets.all(15),
//             child: Padding(
//               padding: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).viewInsets.bottom),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     "Edit Task",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                           color: AppColors.blackColor,
//                         ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   TextField(
//                     controller: titleController,
//                     decoration: InputDecoration(
//                       label: Text(
//                         args.title,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   TextField(
//                     controller: descriptionController,
//                     decoration: InputDecoration(
//                       label: Text(
//                         args.description,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   Text(
//                     'Selected Time',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       showDateFun();
//                     },
//                     child: Text(
//                       selectedDate.toString().substring(0, 10),
//                       textDirection: TextDirection.ltr,
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.titleSmall,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Task newTask = Task(
//                         title: titleController.text,
//                         description: descriptionController.text,
//                         dateTime: DateUtils.dateOnly(selectedDate)
//                             .millisecondsSinceEpoch,
//                       );
//
//                       FirebaseFunctions.updateTask(newTask);
//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         elevation: 0,
//                         padding: EdgeInsets.symmetric(
//                           vertical: 8,
//                         )),
//                     child: Text(
//                       'Save Changes',
//                       style: Theme.of(context)
//                           .textTheme
//                           .titleLarge!
//                           .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   showDateFun() async {
//     DateTime? chosenDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(
//         Duration(
//           days: 365,
//         ),
//       ),
//     );
//     if (chosenDate != null) {
//       selectedDate = chosenDate;
//       setState(() {});
//     }
//   }
// }
