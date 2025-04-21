import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_ui_clone/components/animated_music_box.dart';
import 'package:tiktok_ui_clone/components/video_item.dart';
import 'package:tiktok_ui_clone/constants.dart';
import 'package:tiktok_ui_clone/data/video_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoData.length,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              VideoItem(url: videoData[index].url),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Following",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      const SizedBox(width: 20.0),
                      Text(
                        'For You',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: 20.0,
                  top: MediaQuery.sizeOf(context).height * 0.2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfileAvatar(),
                    const SizedBox(height: 30.0),
                    _buildIcon(
                      Icon(
                        Icons.favorite,
                        color:
                            videoData[index].isLiked
                                ? Colors.red
                                : feedIconColor,
                        size: 45.0,
                      ),
                      videoData[index].likes,
                      onTap:
                          () => setState(() {
                            videoData[index].isLiked =
                                !videoData[index].isLiked;
                          }),
                    ),
                    const SizedBox(height: 20.0),
                    _buildIcon(
                      Icon(
                        CupertinoIcons.chat_bubble_fill,
                        color: feedIconColor,
                        size: 45.0,
                      ),
                      videoData[index].comments,
                    ),
                    const SizedBox(height: 20.0),
                    _buildIcon(
                      Icon(Icons.bookmark, size: 45.0, color: feedIconColor),
                      videoData[index].favoriteLength,
                    ),

                    const SizedBox(height: 20.0),
                    _buildIcon(
                      Icon(Icons.share, color: feedIconColor, size: 45.0),
                      videoData[index].shares,
                    ),

                    const SizedBox(height: 25.0),
                    AnimatedMusicBox(),
                  ],
                ),
              ),

              Positioned(
                bottom: MediaQuery.sizeOf(context).height * 0.1,
                left: 15.0,
                child: Text(
                  videoData[index].description,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Stack _buildProfileAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(profilePicUrl),
          radius: 25.0,
        ),
        Positioned(
          bottom: -10.0,
          right: 2.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            width: 25,
            child: Icon(Icons.add, color: Colors.white, size: 25.0),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(Widget icon, String text, {VoidCallback? onTap}) => Column(
    children: [
      GestureDetector(onTap: onTap, child: icon),
      Text(text, style: TextStyle(color: Colors.white)),
    ],
  );
}
