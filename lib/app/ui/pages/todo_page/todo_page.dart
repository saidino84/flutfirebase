import 'package:flutfirebase/app/data/models/todo_model.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import '../../../controllers/todo_controller.dart';

class TodoPage extends GetView<TodoController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ALL TODOS'),
      // ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Todos Recentes'),
            SizedBox(height: 20),
            // Spacer(),
            StreamBuilder(
                // stream: controller.repository.getTodos(),
                stream:
                    FirebaseFirestore.instance.collection('todo').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text('Something went wrong !');
                  if (snapshot.connectionState == ConnectionState.done)
                    return ListView.separated(
                        separatorBuilder: (_, index) => Divider(
                              color: Colors.grey[800],
                            ),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (ctx, index) {
                          // TodoModel? todo = snapshot.data?.first;
                          return Dismissible(
                            background: Container(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              color: Colors.redAccent,
                              child: Icon(
                                Icons.delete,
                                color: Colors.grey[200],
                              ),
                            ),
                            key: Key(index.toString()),
                            onDismissed: (direction) {
                              switch (direction) {
                                case DismissDirection.startToEnd:
                                  {
                                    print('removed');
                                  }
                                  break;
                              }
                            },
                            child: ListTile(
                              onTap: () {},
                              leading: Container(
                                height: 30,
                                width: 30,
                                // alignment: Alignment.center,
                                // padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Theme.of(ctx).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                // todo?.title ?? 'No data',
                                'todo tile',
                                style: TextStyle(
                                  color: Colors.grey[200],
                                ),
                              ),
                            ),
                          );
                        });
                  return Text('Loading ...');
                })
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                // Divider(),
                TextField(
                  controller: controller.title_edit.value,
                  autofocus: true,
                  maxLines: 5,
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
                    onPressed: () {
                      controller.saveTodo();
                    },
                  ),
                ),
              ],
            ),
          );
        },
        label: Text('create'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
