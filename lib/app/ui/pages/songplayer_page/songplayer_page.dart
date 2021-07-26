import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/songplayer_controller.dart';

class SongplayerPage extends GetView<SongplayerController> {
  final kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
  final kUrl3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => controller.tabs.value[controller.current_tab.value],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.grey[800]),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {
                  controller.to(0);
                },
                icon: Icon(Icons.home,
                    color: controller.current_tab == 0
                        ? primaryColor
                        : Colors.grey[500]),
                label: Text('home',
                    style: TextStyle(
                        color: controller.current_tab == 0
                            ? primaryColor
                            : Colors.grey[500])),
              ),
              TextButton.icon(
                onPressed: () {
                  controller.to(1);
                },
                icon: Icon(Icons.upload_file,
                    color: controller.current_tab.value == 1
                        ? primaryColor
                        : Colors.grey[500]),
                label: Text('upload',
                    style: TextStyle(
                        color: controller.current_tab.value == 1
                            ? primaryColor
                            : Colors.grey[500])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shoose_type() {
    return Container();
  }
}
