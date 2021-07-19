# flutfirebase
Meu flutter app com firebase


Gerar SHA-1 no terminal para firbase android 

Go to the project folder in the terminal.

Mac keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

Windows keytool -list -v -keystore "\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

Linux keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

acaba com as recomendacoes do firbase e por fim as dependecias que seram instaladas atraves do pubspec.yaml
```yaml
dependencies:
    # [recomendado] se nao da um problema se nao colocar na sua dependencia
    firebase_core: ^1.4.0 
    cloud_firestore: ^2.4.0
    firebase_storage: ^10.0.0

```

SE for a rodar pela primeira vez possa vir dar erro de Dex
que quer dizer os codigos java quando compilados geram um arquivo .jar e 
flutter gera um arquivo .dex e firbase gerar arquivos dex maiores e k ests sao limitado
dai da um pau , para solucionar esse trouble precisar settar :

android/app/build.gradle
```groove
dependencies {
    def multidex_version = "2.0.1"
    implementation "androidx.multidex:multidex:$multidex_version"
}
```
If you aren't using AndroidX, add the following deprecated support library dependency instead:
```groove

dependencies {
    implementation 'com.android.support:multidex:1.0.3'
}
```
 e no mesmo grandle do android/app/
 adicione no defaultConfig que multiDexEnabled=true
```groove

android {
    defaultConfig {
        ...
        minSdkVersion 15 
        targetSdkVersion 28
        multiDexEnabled true
    }
    ...
}

dependencies {
    implementation "androidx.multidex:multidex:2.0.1"
}



```

Iniciando a estrutura do projecto

[-] feita a criacao da estrutura de Getx_pattern

[+] como vou interagir com cloud_firestore [que eh um banco de dado rectivo do firebase ]
 [-] primeiro estarei criando uma interface de repository que ele sera capaz de ter todos os metodos para se interagir com firabase [buscar os dados no banco ]
 e ele 'e um  banco reactivo por isso usarei streams

 ```dart
 'lib/app/data/repositories/todo_repository_interface.dart'

import 'package:flutfirebase/app/data/models/todo_model.dart';

abstract class IFirestoreTodoRepository {
  /** Interface que tera todos os metods para se comunicar com o banco reactivo do firebase [Cloud_firestore]

  **/
  // como ele 'e um banco de daos reactivo usarei streams na hora  de pegas os dados
  Stream<List<TodoModel>> getTodos();
}



```

# e sua Classe Repository que a implementa fica 
```dart
'lib/app/data/repositories/todo_repository.dart'

import 'package:flutfirebase/app/data/models/todo_model.dart';

import 'todo_repository_interface.dart';

class FireStoreTodoRepository implements IFirestoreTodoRepository {
  @override
  Stream<List<TodoModel>> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }
}


```

```dart
'TodoModel 
o modelo tera um metodo factory que alem fromJson tera um fromDocumets a referir documents do firestore



 ```

# TodoPage
 ![](todo_screnn.png)

 # on Add new Task open popup 
 ![](add_todo_dialog.png)


 ```dart
 floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => SimpleDialog(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              backgroundColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              titlePadding: EdgeInsets.all(8),
              title: Container(
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      'Nova Nota',
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.cancel,
                            color: Theme.of(context).primaryColor),
                        onPressed: () {
                          Get.back();
                        }),
                  ],
                ),
              ),
              children: [
                Divider(),
                TextFormField(
                  controller: controller.title_edit.value,
                  autofocus: true,
                  maxLines: 1,
                  autofillHints: ['saidino', 'hacker', 'claudia', 'Mariamo'],
                  style:
                      TextStyle(color: Colors.white, height: 1.5, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'ex: Programar django ',
                    hintStyle: TextStyle(
                      color: Colors.white30,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  width: size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
        },
        label: Text('create'),
        icon: Icon(Icons.add),
      ),

 ```
 # when focussed the dialog
 ![](dialog_input_focused.png)