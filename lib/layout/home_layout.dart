import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/setting/setting.dart';
import 'package:todo_app/modules/task_list/task_list.dart';
import 'package:todo_app/providers/tabs_provder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'add_Task_Btm_Sheet.dart';

class HomeLayout extends StatelessWidget {
  static const String routName = 'Home';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TabsProvider(),
      builder: (context, child) {
        var provider = Provider.of<TabsProvider>(context);
        return Scaffold(
          extendBody: true,
          body: tabs[provider.currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.route_tasks),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).colorScheme.onSecondary,
            notchMargin: 8,
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
                currentIndex: provider.currentIndex,
                onTap: (index) {
                  provider.changTab(index);
                },
                items: [
                  BottomNavigationBarItem(
                      label: AppLocalizations.of(context)!.list,
                      icon: Icon(Icons.list)),
                  BottomNavigationBarItem(
                    label: AppLocalizations.of(context)!.setting,
                    icon: Icon(Icons.settings),
                  ),
                ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showAddTaskBottomSheet(context);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void showAddTaskBottomSheet(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: addTaskBtmSheet(),
      ),
    );
  }

  List<Widget> tabs = [TaskList(), SettingScreen()];
}
