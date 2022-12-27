
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/shared/network/local/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/chosen_date_provider.dart';
import '../shared/style/color.dart';

class EditingScreen extends StatelessWidget {
  static String routeName='editing screen';
  var titleController = TextEditingController();
  var detailsController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var task=ModalRoute.of(context)?.settings.arguments as TaskData;
    titleController.text=task.title;
    detailsController.text=task.description;
    bool initSelectedDate=true;

    return ChangeNotifierProvider(
      create: (context) => ChosenDateProvider(),
      builder: (context, child) {
        var provider = Provider.of<ChosenDateProvider>(context);
        if(initSelectedDate==true)provider.selectedDate=DateTime.fromMicrosecondsSinceEpoch(task.date);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.route_tasks),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(30)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    AppLocalizations.of(context)!.edit,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: titleController,
                          validator: (text) {
                            if (text == '') {
                              return AppLocalizations.of(context)!.enter_title;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context)!.this_title,
                                style: TextStyle(fontSize: 16)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: detailsController,
                          maxLines: 3,
                          validator:(text) {
                            if (text == '') {
                              return AppLocalizations.of(context)!.enter_details;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text(
                              AppLocalizations.of(context)!.this_details,
                              style: TextStyle(fontSize: 16),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          AppLocalizations.of(context)!.select_time,
                          style:
                          Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    initSelectedDate=false;
                    showPicker(context, provider);
                  },
                  child: Text(
                    '${provider.selectedDate.day}-${provider.selectedDate.month}-${provider.selectedDate.year}',
                    textAlign: TextAlign.center,
                    style:
                    Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryColor
                  ),
                  child: TextButton(
                      onPressed: () {
                        task.title=titleController.text;
                        task.description=detailsController.text;
                        task.date=provider.selectedDate.microsecondsSinceEpoch;
                        updateTask(task);
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.save_change,style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),)),
                )
              ],
            ),
          ),
        );
      }
    );
}

  void showPicker(context, ChosenDateProvider provider) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: provider.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (chosenDate == null) return;
    provider.changSelectedDate(chosenDate);
  }
}
