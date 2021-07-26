import 'package:flutfirebase/app/controllers/songplayer_controller.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';

class PlayerHome extends GetView<SongplayerController> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (ctx, index) {
          return Center(
            child: Container(
              child: Text('Music Number $index'),
            ),
          );
        });
  }
}
