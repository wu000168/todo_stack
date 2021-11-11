import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stack_todo/task_stack.dart';
import 'add_task_dialog.dart';
import 'task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ThemeData _defaultTheme(BuildContext context,
      {Brightness brightness = Brightness.light}) {
    Color textColor = brightness == Brightness.light
        ? const Color.fromARGB(255, 0x1C, 0x1B, 0x1F)
        : const Color.fromARGB(255, 0xE6, 0xE1, 0xE5);
    Color canvasColor = brightness == Brightness.light
        ? ThemeData.light().canvasColor
        : ThemeData.dark().canvasColor;
    return ThemeData(
      brightness: brightness,
      textTheme: TextTheme(
        headline3: TextStyle(
          color: textColor,
          fontFamily: "Roboto",
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
      ),
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: canvasColor,
        titleTextStyle: TextStyle(
          color: textColor,
          fontFamily: "Roboto",
          fontSize: 28,
          fontWeight: FontWeight.normal,
        ),
        toolbarHeight: 128,
        titleSpacing: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: canvasColor,
          statusBarIconBrightness: brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        largeSizeConstraints: const BoxConstraints(
          minWidth: 96,
          minHeight: 96,
        ),
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Todo',
      theme: _defaultTheme(context, brightness: Brightness.light),
      darkTheme: _defaultTheme(context, brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskList _tasks = TaskList("Your Tasks", <Task>[]);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  void _addTask(BuildContext parentContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (BuildContext context) => AddTaskDialog(parentContext),
    ).then((task) {
      if (task != null) {
        setState(() {
          _tasks.tasks.insert(0, task);
        });
      }
    });
  }

  void _backlogTask() {
    setState(() => _tasks.tasks.add(_tasks.tasks.removeAt(0)));
  }

  void _completeTask() {
    setState(() => _tasks.tasks.removeAt(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 128,
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
          alignment: Alignment.bottomLeft,
          child: Text(_tasks.title),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 128),
          child: TaskStack(
            _tasks.tasks,
            onDismissLeft: _backlogTask,
            onDismissRight: _completeTask,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _backlogTask,
            icon: const Icon(Icons.vertical_align_bottom_rounded),
          ),
          const SizedBox(width: 32),
          FloatingActionButton.large(
            onPressed: () => _addTask(context),
            child: const Icon(
              Icons.add_rounded,
              size: 36,
            ),
          ),
          const SizedBox(width: 32),
          IconButton(
            onPressed: _completeTask,
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
    );
  }
}
