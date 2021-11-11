import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'task.dart';

class TaskCard extends StatelessWidget {
  final Task _task;
  final double? elevation;

  const TaskCard(this._task, {Key? key, this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        elevation: elevation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _task.title,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Divider(),
              if (_task.description != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_task.description!),
                ),
            ],
          ),
        ),
      );
}
