import 'package:flutfirebase/app/controllers/songplayer_controller.dart';
import 'package:flutfirebase/app/data/models/song_model.dart';
import 'package:flutfirebase/app/ui/pages/todo_page/components/error_widget.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';

class PlayerHome extends GetView<SongplayerController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;
    var selected = 0.obs;
    return Scaffold(
      body: StreamBuilder<List<Song>>(
          stream: controller.getSongz(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return QueryError(message: snapshot.error.toString());

            switch (snapshot.connectionState) {
              case ConnectionState.active:
                {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        Song song = snapshot.data![index];
                        return Card(
                          elevation: 10,
                          color: Colors.white54,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(song.cover_url!),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.music_note_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  onChanged: (e) {
                                    selected.value = index;
                                    controller.play_song(song);
                                  },
                                  value: song.isSolo,
                                  title: Text('${song.artist}'),
                                  isThreeLine: true,
                                  subtitle: Text('${song.songName}\n '),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              case ConnectionState.waiting:
                {
                  return Center(
                    child: CircularProgressIndicator(),
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
      floatingActionButton: Obx(
        () => Container(
            height: 60 + selected.value.toDouble(),
            width: size.width * 0.4,
            decoration: BoxDecoration(
                // color: primaryColor,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: primaryColor)),
            child: StreamBuilder<List<Song>>(
                stream: controller.getSongz(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return CircularProgressIndicator();
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      {
                        Song song = snapshot.data![selected.value];
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(song.cover_url!),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.play_pause();
                                },
                                icon: Icon(
                                  controller.playing.value
                                      ? Icons.play_arrow_rounded
                                      : Icons.pause,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    case ConnectionState.waiting:
                      {
                        return Center(
                          child: CircularProgressIndicator(),
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
                })),
      ),
    );
  }
}
