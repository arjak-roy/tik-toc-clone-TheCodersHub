import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_ui_clone/Features/reels/PresentationLayer/BLoC/LikeButtonCubit/likeButton..dart';
import 'package:tiktok_ui_clone/Features/reels/PresentationLayer/BLoC/home_bloc/home_bloc.dart';
import 'package:tiktok_ui_clone/Features/reels/PresentationLayer/Widgets/animated_music_box.dart';
import 'package:tiktok_ui_clone/Features/reels/PresentationLayer/Widgets/video_item.dart';
import 'package:tiktok_ui_clone/constants.dart';
import 'package:tiktok_ui_clone/Features/reels/DataLayer/Datasources/Local_Mock/video_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final HomeBloc homeBloc = HomeBloc();

  @override
  initState() {
    context.read<HomeBloc>().add(
      HomeVideoLoadEvent(),
    ); // homeBloc.add(HomeVideoLoadEvent());
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
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }

          if (state is HomeVideoLoadErrorState) {
            return Center(child: Text(state.message));
          } else if (state is HomeVideoLoadSucessState) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    //Actual video
                    VideoItem(url: state.videos[index].url.toString()),
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
                            BlocBuilder<LikeButtonCubit, bool>(
                              builder: (context, state) {
                                if (state == true && index == 0) {
                                  return Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.red,
                                    size: 45.0,
                                  );
                                }
                                else{
                                  return Icon(
                                    CupertinoIcons.heart,
                                    color: feedIconColor,
                                    size: 45.0,
                                  );
                                }
                              },
                            ),
                            state.videos[index].likes.toString(),
                            onTap:
                                () => {
                                context.read<LikeButtonCubit>().toggleLike(index)
                                  //Logic to be added
                                },
                          ),
                          const SizedBox(height: 20.0),
                          _buildIcon(
                            Icon(
                              CupertinoIcons.chat_bubble_fill,
                              color: feedIconColor,
                              size: 45.0,
                            ),
                            state.videos[index].comments.toString(),
                          ),
                          const SizedBox(height: 20.0),
                          _buildIcon(
                            Icon(
                              Icons.bookmark,
                              size: 45.0,
                              color: feedIconColor,
                            ),
                            state.videos[index].favoriteLength.toString(),
                          ),

                          const SizedBox(height: 20.0),
                          _buildIcon(
                            Icon(Icons.share, color: feedIconColor, size: 45.0),
                            state.videos[index].shares.toString(),
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
                        videoData[index].description.toString(),
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
          } else {
            return Container(color: const Color.fromARGB(255, 255, 255, 255));
          }
        },
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
      CircleAvatar(backgroundImage: NetworkImage(profilePicUrl), radius: 25.0),
      Positioned(
        bottom: -10.0,
        right: 2.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
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
