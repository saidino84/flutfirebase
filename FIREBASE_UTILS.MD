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