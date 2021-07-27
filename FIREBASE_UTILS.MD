# FIREBASE UTILS

#USO DE FIREBASEFIRESTORE

```dart  
'''THE  BASIC USING DIRECTLY I YOUR VIEW'''
body:StreamBuilder{
    
        // stream: controller.repository.getTodos(),
        // stream: controller.showData(),
        stream:
            FirebaseFirestore.instance.collection('todo').snapshots(),
        // if (snapshot.hasError) return Text('Something went wrong !');
        // builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // if (snapshot.connectionState == ConnectionState.done)
            if (snapshot.hasError) {
            return QueryError(
                message: snapshot.error.toString(),
            );
            }
            switch (snapshot.connectionState) {
            case ConnectionState.active:
                {
                var checkd = false.obs;
                return ListView(
                    children: snapshot.data!.docs.map((e) {
                    return CheckboxListTile(
                        title: Text(e['title']),
                        value: e['checked'],
                        onChanged: (e) {
                            checkd.value = !checkd.value;
                        });
                    }).toList(),
                );
                }
            case ConnectionState.waiting:
                {
                return Center(
                    child: LinearProgressIndicator(),
                );
                }
            case ConnectionState.done:
                {
                return Center(
                    child: Text('Conection state done ...'),
                );
                }
            default:
                return Container();
            }
        }),
}

```

# APLICANDO AREGRA DE NEGOCIO
#Model
```dart
"todo_model.dart"
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? id;
  String? title;
  bool? checked;

  TodoModel({this.id, this.title, this.checked});

  TodoModel.fromJson(Map<String, dynamic> firestore_docus)
      : this(
          checked: firestore_docus['checked'] as bool?,
          title: firestore_docus['title'] as String?,
        );

  Map<String, dynamic> toJson() => {
        'title': title,
        'checked': checked,
      };

  TodoModel copyWith({
    String? id,
    String? title,
    bool? checked,
  }) {
    return TodoModel(
      checked: checked ?? this.checked,
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }
}


````

# Repository
todo_repository.dart

```dart

"todo_repository.dart"

import 'package:firebase_core/firebase_core.dart';
import 'package:flutfirebase/app/data/models/todo_model.dart';

import 'todo_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoRepository implements IFirestoreTodoRepository {
  final CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todo');

  final CollectionReference todoReference =
      FirebaseFirestore.instance.collection('todo');

  // final todosRef = FirebaseFirestore.instance
  //     .collection('todo')
  //     .withConverter<TodoModel>(
  //         fromFirestore: (snapshot, _) => TodoModel.fromDocumets(snapshot),
  //         toFirestore: (todo, _) => todo.toJson());

  List<TodoModel> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((element) {
        print("##################### THIS IS AN ID =>${element.id}");
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        return TodoModel.fromJson(data).copyWith(id: element.id);
      }).toList();
    } else {
      return <TodoModel>[];
    }
  }

  @override
  Stream<List<TodoModel>> getTodos() {
    return todosCollection.snapshots().map(todoFromFirestore);
  }

  /***
   * TODO  OUTROS IMPLEMENTAM:
   * final Firestore firestore=Firestore.instance;
   * Stream<List<TodoModel> getTodos(){
   * 
   *  return firestore.collection('todo').snapshots().map( (query){
   *    return query.documents.map( (doc){return TodoModel.fromJson(doc);})
   * 
   * })
   * }
   */

  Future create_new_todo(String title) async {
    /** Cria um novo Todo*/
    return await todosCollection.add({'title': title, 'checked': false});
  }

  Future<void> remove_todo_by_id(TodoModel todo) async {
    await todosCollection.doc(todo.id).delete().then((value) {
      print('deletado um item');
    }).catchError((error) {
      throw Exception(" Erro ao apager Item ${error}");
    });
  }

  Future complete__task(TodoModel todo) async {
    /** Actualiza um novo Todo ao fazer checked */
    // TodoModel model = TodoModel.copyWith(id:);
    bool chec = !todo.checked!;
    return await todosCollection
        .doc(todo.id)
        .update({'checked': chec, 'title': todo.title});
  }
}


```

# Controller

todo_controller
```dart
"todo_controller"
import 'package:flutfirebase/app/data/models/todo_model.dart';
import 'package:flutfirebase/app/data/repositories/todo_repository.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:get/get.dart';

class TodoController extends GetxController with StateMixin {
  final title_edit = TextEditingController().obs;
  TodoRepository todo_repository = TodoRepository();
  void saveTodo() {
    if (title_edit.value.text.isNotEmpty) {
      todo_repository.create_new_todo(title_edit.value.text).then((value) {
        Get.snackbar(
          'Saved Sucess full',
          '${title_edit.value.text}',
          backgroundColor: Colors.blueAccent,
        );
      }).catchError((err) {
        Get.snackbar(
          'Save Fail',
          'Erro ao salvar os seus dados devido :${err.toString()}',
          backgroundColor: Colors.red,
        );
      });
    }
    title_edit.value.clear();
  }

  Stream<List<TodoModel>> showData() {
    return todo_repository.getTodos();
  }

  void todo_done(TodoModel todo) {
    todo_repository.complete__task(todo);
  }

  void delete_todo(TodoModel model) async {
    todo_repository.remove_todo_by_id(model).then((value) {
      Get.snackbar('Delete', "Delete was purshace sucessfully !",
          backgroundColor: Colors.blueAccent);
    }).catchError((err) {
      Get.snackbar("Delete", "Fail to Delete that todo err: ${err}",
          backgroundColor: Colors.redAccent);
    });
  }
}


```

# View  Interact the views in realTime 

```dart
body:StreamBuilder{
	stream:todo_controller.showData().
	builder:(ctx,AsyncSnaphot<List<TodoModel>> snapshop){
		if (snapshot.hasError) {
                    return QueryError_Widget(
                      message: snapshot.error.toString(),
                    );
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      {
                        return ListView.builder(
                        	shrinkWrap: true,
          			itemCount: snapshot.data!.length,
          			itemBuilder:(ctx,index){
          				TodoModel todo = snapshot.data![index]
          				return Dismissible(
          					key:Uniquekey(),
          					backgroundColor:Container(color:red,icon:I.delete),
          					onDismissed:(dir)=>todo_controller.delete_todo(todo),
          					child: CheckboxListTile(
								title: Text('${todo.title}'),
								value: todo.checked,
								onChanged: (e) {
								  checkd.value = !checkd.value;
								});
          					
          					
          			}
                        );
                       }
                    case ConnectionState.waiting:
                      {
                        return Center(
                          child: LinearProgressIndicator(),
                        );
                      }
                    case ConnectionState.done:
                      {
                        return Center(
                          child: Text('Conection state done ...'),
                        );
                      }
                    default:
                      return Container();
                  }
	}

}


class ListTodos{
	
	
	}



```

# FIREBASE STORAGE TIME

```yaml

  firebase_core: ^1.4.0 
  firebase_storage: ^10.0.0

  # google sign
  firebase_auth: ^3.0.1
  google_sign_in: ^5.0.5

  #Google Icon
  font_awesome_flutter: ^9.1.0

  # State Manager
  get: ^4.1.4

  file_picker: ^3.0.3
```

# CLASSE RESPONSAVEL DE SE COMINCAR COM FIREBASE /repository

```dart
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class MyFirebaseApi {
  static UploadTask? uploadTask(String destination, File file) {
    // Faz Upload
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (err) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}


```

# A PARTE DE PEGAR A FOTO/FILE E FAZER UPLOAD

```dart

  //sao os files pegues atraves do file picker
  late Rx<File> song_uri;
  late Rx<File> cover_uri;
    Future get_audio() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false,allowedExtensions: ['.mp3', '.wav']);

    if (result != null) {
      // PlatformFile file = result.files.single.path!;
      var path = result.files.single.path!;
      // var path = file.path;
      if (path != null) {
        song_uri = File(path).obs;
        song_uri_contrl.text = os_path.basename(path); //os_path.basename(path);
      }
      Get.snackbar('Music', 'Sound catch sucessfully');
    }
  }

    void select_music_cover() async {
      /**selects file /image*/
    has_cover.value = false;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image,exte);

    if (result != null) {
      PlatformFile file = result.files.first;
      var path = file.path;
      // Get.snackbar('${os_path.basename(!file)}', message)
      Get.snackbar('Got image', '$path');
      if (path != null) {
        cover_uri = File(path).obs;
        has_cover.value = true;
        print('COVER PATH IS =====>$cover_uri');
      }
    }
  }

  Future upload_simple() async {
    var isvalid = is_all_data_got();//faz validacao se os dados foram pegues com sucess
    if (isvalid) {
      print('saving data...');
      var audio_data = song_uri.value;
      var audio_path = os_path.basename(audio_data.path);
      if (!audio_path.endsWith(".mp3")) {
        audio_path = audio_path + '.mp3';
      }
      // Get.defaultDialog(title: 'File content type $audio_path');
      // var task = MyFirebaseApi.uploadTask('testes/$audio_path', audio_data);
/*  PODE TAMBEM FAZER-SE O SEGUINTE
      MyFirebaseApi.uploadBytes(
          'data/$audio_path', audio_data.readAsBytesSync());
      **/
      // Baixar o link do file
      // if (task != null) {
      //   final snapshot = await task.whenComplete(() {});
      //   final urlDownload = await snapshot.ref.getDownloadURL();
      // }
      Get.snackbar('Save $isvalid', 'Save sucess ',
          backgroundColor: Colors.blueAccent,
          icon: Icon(Icons.done_all, color: Colors.white),
          shouldIconPulse: true,
          showProgressIndicator: true);
    } else {
      Get.snackbar('Save $isvalid', 'preeche os campos todos sao necessarios',
          backgroundColor: Colors.amberAccent,
          icon: Icon(Icons.error_outline, color: Colors.redAccent));
    }
  }


```


