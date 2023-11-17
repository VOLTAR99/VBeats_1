
import 'package:vbeats/consts/colors.dart';
import 'package:vbeats/consts/text_style.dart';
import 'package:vbeats/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:vbeats/views/player.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(PlayerController());




    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.search, color: bgColor ,))
          ],
          leading: const Icon(Icons.sort_rounded,color: bgColor,),
          title: Text('VBeats',
              style: ourStyle(
                family: bold,
                size: 18,
              )),
        ),
        body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL
          ),
          builder: (BuildContext context, snapshot ){
            if(snapshot.data == null){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.data!.isEmpty){
              return Center(
                child: Text(
                  'No Song Found',
                  style: ourStyle(),
                ),
              );
            }else{
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              bgColor,
                              bgDarkColor
                            ]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(3),
                      child: Obx(() => ListTile(
                          title: Text("${snapshot.data![index].displayNameWOExt}",
                            style: ourStyle(
                                family: bold,
                                size: 15
                            ),
                          ),
                          subtitle:Text("${snapshot.data![index].artist}",
                            style: ourStyle(
                                family: bold,
                                size: 12
                            ),
                          ),
                          leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(     //music which do not have any artwork will have this icon
                            Icons.music_note,
                            color: whiteColor,
                            size: 32,
                          ),
                        ),
                          trailing: controller.playIndex.value == index && controller.isPlaying.value
                              ? const Icon(Icons.play_arrow,
                                           color: whiteColor,
                                           size: 26,)
                              : null,
                          onTap: (){
                            Get.to (()=> Player(
                              data: snapshot.data!,
                            ),
                              transition: Transition.downToUp,
                            );
                             controller.playSong(snapshot.data![index].uri, index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }

          },
        )
    );
  }
}