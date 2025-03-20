import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({Key? key}) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  final List<String> videoUrls = [
    'https://www.instagram.com/reel/DGfxwdMoy2s/?igsh=dDYwbTZjaGZuYXgy',
    'https://www.instagram.com/reel/DFctfCPhIOq/?igsh=aXRkcDRjYzFmZzly',
    'https://www.instagram.com/p/DGhp-digf5r/?igsh=dWlneHRleWV3eHp3',
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videoUrls.length,
      itemBuilder: (context, index) {
        return ReelsVideoPlayer(videoUrl: videoUrls[index]);
      },
    );
  }
}

class ReelsVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ReelsVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<ReelsVideoPlayer> createState() => _ReelsVideoPlayerState();
}

class _ReelsVideoPlayerState extends State<ReelsVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      }).catchError((error) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.value.isInitialized && _controller.value.isPlaying) {
          _controller.pause();
        } else if (_controller.value.isInitialized) {
          _controller.play();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : Container(color: Colors.black),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 100,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.heart, color: Colors.white),
                  onPressed: () {},
                ),
                const Text('120', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.comment, color: Colors.white),
                  onPressed: () {},
                ),
                const Text('300', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.share, color: Colors.white),
                  onPressed: () {},
                ),
                const Text('50', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://www.example.com/profile.jpg'),
                    ),
                    SizedBox(width: 10),
                    Text('short.stacksx', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text('Follow', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 5),
                Text('- home ❤️🏠', style: TextStyle(color: Colors.white)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.music_note, color: Colors.white, size: 16),
                    SizedBox(width: 5),
                    Text('short.stacksx • Original audio', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          if (!_controller.value.isInitialized)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
