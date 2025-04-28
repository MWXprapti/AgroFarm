import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReelsScreen extends StatelessWidget {
  final List<String> videoUrls = [
    'https://www.youtube.com/watch?v=RDclpZAwXVw',
    'https://www.youtube.com/watch?v=gTastlkWMFs',
    'https://www.youtube.com/watch?v=iraezTzB938',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows the app bar to be transparent over the content
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Reels",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return ReelItem(videoUrl: videoUrls[index]);
        },
      ),
    );
  }
}

class ReelItem extends StatefulWidget {
  final String videoUrl;
  const ReelItem({required this.videoUrl});

  @override
  _ReelItemState createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // YouTube Player
        YoutubePlayerBuilder(
          player: YoutubePlayer(controller: _controller),
          builder: (context, player) {
            return SizedBox.expand(child: player);
          },
        ),

        // Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              ),
            ),
          ),
        ),

        // UI Elements (Like, Comment, Share)
        Positioned(
          bottom: screenHeight * 0.1,
          right: screenWidth * 0.05,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.white, size: screenWidth * 0.08),
                onPressed: () {},
              ),
              Text("12.4K", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04)),
              SizedBox(height: screenHeight * 0.02),

              IconButton(
                icon: Icon(Icons.comment, color: Colors.white, size: screenWidth * 0.08),
                onPressed: () {},
              ),
              Text("321", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04)),
              SizedBox(height: screenHeight * 0.02),

              IconButton(
                icon: Icon(Icons.share, color: Colors.white, size: screenWidth * 0.08),
                onPressed: () {},
              ),
              Text("89", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04)),
            ],
          ),
        ),

        // Video Description & Username
        Positioned(
          bottom: screenHeight * 0.1,
          left: screenWidth * 0.05,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("@username",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: screenHeight * 0.005),
              Text("This is a sample caption for the reel.",
                  style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04)),
            ],
          ),
        ),
      ],
    );
  }
}