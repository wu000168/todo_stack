import 'package:flutter/material.dart';
import 'task.dart';

class AddTaskDialog extends StatefulWidget {
  final BuildContext context;
  AddTaskDialog(this.context, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddTaskDialogState();
}

class AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(widget.context).padding.top,
          bottom: MediaQuery.of(widget.context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                AppBar(
                  elevation: _scrollController.hasClients &&
                          _scrollController.offset !=
                              _scrollController.initialScrollOffset
                      ? (Theme.of(context).bottomSheetTheme.elevation ?? 0) + 2
                      : Theme.of(context).bottomSheetTheme.elevation,
                  toolbarHeight: 64,
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.pop(
                        context,
                        Task(
                            _titleController.text, _descriptionController.text),
                      ),
                      icon: const Icon(Icons.done),
                    ),
                    const SizedBox(width: 16)
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Form(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.task_alt),
                            title: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration.collapsed(
                                  hintText: "Add title..."),
                              style: Theme.of(context).textTheme.headline3,
                              controller: _titleController,
                            ),
                          ),
                          ListTile(
                            minVerticalPadding: 16,
                            leading: const Icon(Icons.list),
                            title: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration.collapsed(
                                  hintText: "Add descrption..."),
                              controller: _descriptionController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              textAlignVertical: TextAlignVertical.top,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
