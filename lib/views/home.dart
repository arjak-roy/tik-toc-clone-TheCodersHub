import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_ui_clone/bloc/home_bloc/home_bloc.dart';
import 'package:tiktok_ui_clone/components/animated_music_box.dart';
import 'package:tiktok_ui_clone/components/video_item.dart';
import 'package:tiktok_ui_clone/constants.dart';
import 'package:tiktok_ui_clone/data/videoData/video_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final HomeBloc homeBloc = HomeBloc();

  @override
  initState() {
    context.read<HomeBloc>().add(HomeVideoLoadEvent());    // homeBloc.add(HomeVideoLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          
          //Abhi k liye koi abi call nhi ho rha. par bad me add karenge
          if (state is HomeVideoLoadingState) {
            return Container(
              color: Colors.black,
              child: const Center(child: CircularProgressIndicator(color: Colors.white,)),
            );
          }

          if(state is HomeVideoLoadErrorState){
            return Center(child: Text(state.message),);
          }
          
          else if (state is HomeVideoLoadSucessState) {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.videos.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  //Actual video
                  VideoItem(url: state.videos[index].url),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Following",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
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
                                state.videos[index].isLiked
                                    ? Colors.red
                                    : feedIconColor,
                            size: 45.0,
                          ),
                          videoData[index].likes,
                          onTap:
                              () => 
                                context.read().add(HomeVideoLikeEvent(index: index))

                        ),
                        const SizedBox(height: 20.0),
                        _buildIcon(
                          Icon(
                            CupertinoIcons.chat_bubble_fill,
                            color: feedIconColor,
                            size: 45.0,
                          ),
                          state.videos[index].comments,
                        ),
                        const SizedBox(height: 20.0),
                        _buildIcon(
                          Icon(
                            Icons.bookmark,
                            size: 45.0,
                            color: feedIconColor,
                          ),
                          state.videos[index].favoriteLength,
                        ),

                        const SizedBox(height: 20.0),
                        _buildIcon(
                          Icon(Icons.share, color: feedIconColor, size: 45.0),
                          state.videos[index].shares,
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
          );
        }
        else{
          return Container(
            color: const Color.fromARGB(255, 255, 255, 255),
          );
        }
        }
      ),
    );

          }
    // }
    // else{
    //   return Container();
    // }
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

