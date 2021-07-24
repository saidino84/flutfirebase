import 'package:flutfirebase/app/data/models/todo_model.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../controllers/todo_controller.dart';
import 'components/error_widget.dart';
import 'components/list_todo_widget.dart';

class TodoPage extends GetView<TodoController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ALL TODOS'),
      // ),
      // resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Get.back()),
              Text(
                'Todos Recentes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              IconButton(
                icon: Icon(Icons.devices_outlined),
                onPressed: () {},
              ),
            ],
          )),
          SizedBox(height: 20),
          // Spacer(),
          Expanded(
            child: StreamBuilder(
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
                        // return ListTodos(snapshot);

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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          AppWidget.create_new_todo(context, size);
        },
      ),
    );
  }
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