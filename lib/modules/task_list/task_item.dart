import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/editing_screen.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/providers/setting_provider.dart';
import 'package:todo_app/shared/network/local/firebase_utils.dart';
import 'package:todo_app/shared/style/color.dart';
import '../../providers/task_editing_done_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatelessWidget {
  TaskData task;
  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskDone(),
      builder: (context, child){
        var provider=Provider.of<TaskDone>(context);
        var SettingPro=Provider.of<SettingProvider>(context);

        return Container(
          margin: EdgeInsets.symmetric(vertical: 15,horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.onSecondary,

          ),
          child: Slidable(
            startActionPane: ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      deleteFromFirebase(task.id);
                    },
                    borderRadius: SettingPro.language=='en'?
                    BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)):
                    BorderRadius.zero,
                    backgroundColor: Theme.of(context).colorScheme.error,
                    label: AppLocalizations.of(context)!.delete,
                    icon: Icons.delete,
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.pushNamed(
                          context,
                          EditingScreen.routeName,
                        arguments: task,

                      );
                    },
                    borderRadius: SettingPro.language=='ar'?
                    BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)):
                    BorderRadius.zero,
                    backgroundColor: Theme.of(context).colorScheme.onError,
                    label: AppLocalizations.of(context)!.edit,
                    icon: Icons.edit,
                  ),
                ]
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 4,
                    color: task.isDone==true?colorGreen:primaryColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.title,style: task.isDone==true?
                        Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: colorGreen
                        )
                            :Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: primaryColor
                        ),),
                        Text(task.description,style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary
                        )),
                      ],
                    ),
                  ),
                  InkWell(
                          onTap: () {
                            provider.onPressedDone(task);
                          },
                          child: task.isDone==true?
                              Center(
                                child: Text(AppLocalizations.of(context)!.done,style: TextStyle(
                                  color: colorGreen,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                              ):
                          Container(
                              height: 35,
                              width: 50,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),),
                              child: Icon(Icons.done,size: 30,color: Colors.white,)))
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
