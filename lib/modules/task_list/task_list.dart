import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/modules/task_list/task_item.dart';
import 'package:todo_app/providers/selected_date_provider.dart';
import 'package:todo_app/shared/network/local/firebase_utils.dart';
import 'package:todo_app/shared/style/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectedDate(),
      builder: (context, child) {
        var provider=Provider.of<SelectedDate>(context);
       return Column(
         children: [
           Container(
             margin: EdgeInsets.symmetric(horizontal: 20),
             child: CalendarTimeline(
               initialDate: provider.currentDate,
               firstDate: DateTime.now().subtract(Duration(days: 365)),
               lastDate: DateTime.now().add(Duration(days: 365)),
               onDateSelected: (date){
                 provider.changCurrentDate(date);
               },
               leftMargin: 20,
               monthColor: colorBlack,
               dayColor: primaryColor,
               activeDayColor: Colors.white,
               activeBackgroundDayColor: primaryColor,
               dotsColor: bkgColorGreen,
               selectableDayPredicate: (date) => true,
               locale: 'en_ISO',
               dayNameColor: Colors.white,
             ),
           ),
           StreamBuilder<QuerySnapshot<TaskData>>(
             stream: getTasksFromFirebase(provider.currentDate),
             builder: (context, snapshot) {
               if(snapshot.connectionState==ConnectionState.waiting){
                 return Center(child: CircularProgressIndicator());
               }
               if(snapshot.hasError){
                 return Text(AppLocalizations.of(context)!.something_wrong);
               }
               var tasks=snapshot.data?.docs.map((doc) => doc.data()).toList()??[];
               if(tasks.isEmpty){
                 return Center(child: Text(AppLocalizations.of(context)!.no_data,style: TextStyle(
                   color: Theme.of(context).colorScheme.onPrimary
                 ),));
               }
               return Expanded(
                 child: ListView.builder(
                     itemCount: tasks.length,
                     itemBuilder: (context,index){
                       return TaskItem(tasks[index]);
                     }
                 ),
               );

             },
           )
         ],
       );
      },
    );
  }
}
