import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/providers/chosen_date_provider.dart';
import 'package:todo_app/shared/network/local/firebase_utils.dart';
import 'package:todo_app/shared/style/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/component/show_loading_component.dart';

class addTaskBtmSheet extends StatelessWidget {
  var titleController = TextEditingController();
  var detailsController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChosenDateProvider(),
      builder: (context, child) {
        var provider = Provider.of<ChosenDateProvider>(context);

        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    AppLocalizations.of(context)!.add_task,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Form(

                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          autofocus: true,
                          controller: titleController,
                          validator: (text) {
                            if (text == '') {
                              return AppLocalizations.of(context)!.enter_title;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context)!.enter_title,
                                style: TextStyle(fontSize: 16)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: detailsController,
                          maxLines: 3,
                          validator: (text) {
                            if (text == '') {
                              return AppLocalizations.of(context)!.enter_details;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text(
                              AppLocalizations.of(context)!.enter_details,
                              style: TextStyle(fontSize: 16),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                        InkWell(
                          onTap: () {
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
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      TaskData task = TaskData(
                          title: titleController.text,
                          description: detailsController.text,
                          date: DateUtils.dateOnly(provider.selectedDate)
                              .microsecondsSinceEpoch);
                      ShowLoading(context, AppLocalizations.of(context)!.loading);
                      ShowMessage(context, AppLocalizations.of(context)!.you_sure, () {
                        addTaskToFirebaseFireStore(task);
                        HideLoading(context);
                        ShowMessage(context, AppLocalizations.of(context)!.success_adding, () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, AppLocalizations.of(context)!.ok);
                      },
                        AppLocalizations.of(context)!.yes,
                        negBtn: AppLocalizations.of(context)!.cancel,
                        negAction: () {
                          HideLoading(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                  child: const Icon(Icons.done_rounded, size: 40),
                )
              ],
            ),
          ),
        );
      },
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
