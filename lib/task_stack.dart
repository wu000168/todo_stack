import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stack_todo/task_card.dart';

import 'task.dart';
import 'task_card.dart';

class TaskStack extends StatelessWidget {
  final List<Task> _tasks;
  final Function() onDismissLeft, onDismissRight;

  const TaskStack(this._tasks,
      {required this.onDismissLeft, required this.onDismissRight, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _tasks.isEmpty
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Press"),
              Icon(Icons.add),
              Text("to add a new task"),
            ],
          )
        : Expanded(
            child: Stack(
              fit: StackFit.expand,
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                for (int i = min(_tasks.length - 1, 8); i > 0; i--)
                  AnimatedPositioned(
                    key: ValueKey(_tasks[i]),
                    duration: const Duration(milliseconds: 200),
                    top: i * 4,
                    bottom: -i * 4,
                    left: i * 4,
                    right: i * 4,
                    child: TaskCard(
                      _tasks[i],
                      elevation: (_tasks.length - i) *
                          (Theme.of(context).cardTheme.elevation ?? 2.0),
                    ),
                  ),
                Dismissible(
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      onDismissLeft();
                    } else if (direction == DismissDirection.startToEnd) {
                      onDismissRight();
                    }
                  },
                  child: TweenAnimationBuilder(
                    key: ValueKey(_tasks[0]),
                    tween: Tween<double>(begin: 4, end: 0),
                    duration: const Duration(milliseconds: 200),
                    builder: (_, double _a, __) => Positioned.fill(
                      left: _a,
                      right: -_a,
                      top: _a,
                      bottom: _a,
                      key: ValueKey(_tasks[0]),
                      child: TaskCard(
                        _tasks[0],
                        elevation: _tasks.length *
                            (Theme.of(context).cardTheme.elevation ?? 2.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
