import 'package:flutfirebase/app/ui/utils/shared.dart';

class ListTodos extends GetView<TodoController> {
  AsyncSnapshot<List<TodoModel>> snapshot;
  ListTodos(this.snapshot);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
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
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'S',
                              style: TextStyle(color: Colors.white),
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
  }
}
