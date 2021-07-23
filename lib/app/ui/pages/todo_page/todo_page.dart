import 'package:flutfirebase/app/data/models/todo_model.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import '../../../controllers/todo_controller.dart';

class TodoPage extends GetView<TodoController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ALL TODOS'),
      // ),
      resizeToAvoidBottomInset: false,
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
                stream: controller.showData(),
                builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
                  if (snapshot.hasError) return Text('Something went wrong !');
                  // if (snapshot.connectionState == ConnectionState.done)
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  return Container(
                    height: size.height - 50,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (ctx, index) {
                          TodoModel todo = snapshot.data![index];
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
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              controller.delete_todo(todo);
                            },
                            child: ListTile(
                              onTap: () {
                                controller.todo_done(todo);
                              },
                              leading: Container(
                                height: 30,
                                width: 30,
                                // alignment: Alignment.center,
                                // padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Theme.of(ctx).primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: todo.checked == true
                                          ? Colors.white
                                          : Colors.white12),
                                ),
                                child: todo.checked == true
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : Container(),
                              ),
                              title: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    tileMode: TileMode.mirror,
                                    colors: [
                                      Color(0xFF2D27FF).withOpacity(0.2),
                                      Color(0xFFFF0A6C).withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: primaryColor,
                                  ),
                                ),
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            'S',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // todo?.title ?? 'No data',
                                        // snapshot.data !=null?snapshot.data[index].title!:'None',
                                        "${todo.title} ",
                                        style: TextStyle(
                                          color: Colors.grey[200],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          create_new_todo(context, size);
        },
      ),
    );
  }

  Future<dynamic> create_new_todo(BuildContext context, Size size) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                  icon:
                      Icon(Icons.cancel, color: Theme.of(context).primaryColor),
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
            style: TextStyle(color: Colors.white, height: 1.5, fontSize: 18),
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
                // controller.todo_repository.todoReference.add({
                //   'title': controller.title_edit.value.text,
                //   'checked': false
                // });
              },
            ),
          ),
        ],
      ),
    );
  }
}
