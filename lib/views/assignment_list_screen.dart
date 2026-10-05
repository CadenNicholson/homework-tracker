import 'package:flutter/material.dart';

import '../presenters/assignment_presenter.dart';

class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final AssignmentPresenter _presenter = AssignmentPresenter();

  bool _isLoading = true;

  // Filter options: all, completed, uncompleted
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    _loadAssignments();
  }

  Future<void> _loadAssignments() async {
    await _presenter.loadAssignments();
    setState(() => _isLoading = false);
  }

  void _showAddAssignmentDiaglog() {
    String newAssignmentTitle = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Assignment'),
          content: TextField(
            autofocus: true,
            decoration:
                const InputDecoration(hintText: 'Enter assignment title'),
            onChanged: (value) {
              newAssignmentTitle = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (newAssignmentTitle.trim().isNotEmpty) {
                  await _presenter.addAssignment(
                    newAssignmentTitle.trim(),
                  );

                  setState(() {});
                }

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final assignments = _presenter.assignments;

    // Apply the selected filter
    final filteredAssignments = assignments.where((assignment) {
      if (_filter == 'completed') {
        return assignment.isCompleted;
      } else if (_filter == 'uncompleted') {
        return !assignment.isCompleted;
      }

      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        actions: [
          DropdownButton<String>(
            value: _filter,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(
                value: 'all',
                child: Text('All'),
              ),
              DropdownMenuItem(
                value: 'completed',
                child: Text('Completed'),
              ),
              DropdownMenuItem(
                value: 'uncompleted',
                child: Text('Uncompleted'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _filter = value;
                });
              }
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: filteredAssignments.length,
              itemBuilder: (context, index) {
                final assignment = filteredAssignments[index];

                return CheckboxListTile(
                  title: Text(
                    assignment.title,
                    style: assignment.isCompleted
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough,
                          )
                        : const TextStyle(),
                  ),
                  value: assignment.isCompleted,
                  onChanged: (_) async {
                    final originalIndex = assignments.indexOf(assignment);

                    await _presenter.toggledCompleted(originalIndex);

                    setState(() {});
                  },
                  secondary: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      final originalIndex = assignments.indexOf(assignment);

                      await _presenter.deleteAssignment(originalIndex);

                      setState(() {});
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAssignmentDiaglog,
        child: const Icon(Icons.add),
      ),
    );
  }
}