import 'package:flutter/material.dart';
import 'package:flutter_application_8_mprime8/services/cloud/cloud_note.dart';
import 'package:flutter_application_8_mprime8/utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);
typedef NoteUpdateCallback = void Function(CloudNote note, int colorType);

class NotesListView extends StatefulWidget {
  final Iterable<CloudNote> notes;
  final NoteCallback onDeleteNote;
  final NoteUpdateCallback onModifyColor;
  final NoteCallback onTap;

  const NotesListView(
      {super.key,
      required this.notes,
      required this.onDeleteNote,
      required this.onModifyColor,
      required this.onTap});

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  final List<MaterialColor> _colors = [
    Colors.amber,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.grey,
  ];

  int _colorIndex = 0;

  void _modifyColor() {
    setState(() {
      if (_colorIndex < 6) {
        _colorIndex++;
      } else {
        _colorIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.notes.length,
      itemBuilder: (context, index) {
        final note = widget.notes.elementAt(index);
        return ListTile(
          onTap: () {
            widget.onTap(note);
          },
          leading: IconButton(
              onPressed: () {
                _modifyColor();
                widget.onModifyColor(note, _colors[_colorIndex].value);
              },
              icon: Icon(
                Icons.note,
                color: Color(note.colorType).withOpacity(1),
              )),
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  widget.onDeleteNote(note);
                }
              },
              icon: const Icon(Icons.delete)),
        );
      },
    );
  }
}
