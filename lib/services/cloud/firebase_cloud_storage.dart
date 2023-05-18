import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_8_mprime8/services/cloud/cloud_note.dart';
import 'package:flutter_application_8_mprime8/services/cloud/cloud_storage_constants.dart';
import 'package:flutter_application_8_mprime8/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');

  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateNote(
      {required String documentId,
      required String text,
      required int colorType}) async {
    try {
      await notes
          .doc(documentId)
          .update({textFieldName: text, colorTypeFieldName: colorType});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) {
    final allNotes = notes
        .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudNote.fromSnapshot(doc)));
    return allNotes;
  }

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
      colorTypeFieldName: 4294951175,
    });
    final fetchedNote = await document.get();
    return CloudNote(
        documentId: fetchedNote.id,
        ownerUserId: ownerUserId,
        text: '',
        colorType: 4294951175);
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
