import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok_app/models/video.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> videoPaths = [
    'assets/videos/video1.mp4',
    'assets/videos/video2.mp4',
    'assets/videos/video3.mp4',
  ];

  final List<Video> videos = [];

  final List<VideoPlayerController> _controllers = [];
  FilePickerResult thumbnail = FilePickerResult([]);

  late VideoPlayerController controller;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _fetchVideos() async {
    try {
      final List<Video> fetchedVideos = await Video.fetchVideos();
      setState(() {
        videos.addAll(fetchedVideos);
      });

      // Initialize controllers after fetching
      for (var video in fetchedVideos) {
        // final controller =
        //     VideoPlayerController.networkUrl(Uri.parse(video.videoUrl));

        controller =
            await VideoPlayerController.networkUrl(Uri.parse(video.videoUrl))
              ..initialize().then((_) {
                controller.play();
                setState(() {});
              })
              ..setLooping(true);
        _controllers.add(controller);

        // await controller.initialize(); // make sure to await
        // controller.setLooping(true);
        // _controllers.add(controller);
      }

      // Start the first video if there is at least one
      if (_controllers.isNotEmpty) {
        _controllers.first.play();
        setState(() {}); // Update UI after all are initialized
      }
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  void _onPageChanged(int index) {
    for (int i = 0; i < _controllers.length; i++) {
      if (i == index) {
        _controllers[i].play();
      } else {
        _controllers[i].pause();
      }
    }
  }

  Widget buildSidebar() {
    return Container(
      width: 220,
      color: Colors.black,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'TikTok',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          sideNavItem(Icons.home, 'Saran', selected: true),
          sideNavItem(Icons.search, 'Jelajahi'),
          sideNavItem(Icons.people, 'Mengikuti'),
          sideNavItem(Icons.group, 'Teman'),
          sideNavItem(Icons.add_box, 'Unggah'),
          sideNavItem(Icons.message, 'Aktivitas', badge: '1'),
          sideNavItem(Icons.chat, 'Pesan', badge: '2'),
          sideNavItem(Icons.live_tv, 'LIVE'),
          sideNavItem(Icons.person_outline, 'Profil'),
          sideNavItem(Icons.more_horiz, 'Lainnya'),
        ],
      ),
    );
  }

  Widget sideNavItem(
    IconData icon,
    String label, {
    bool selected = false,
    String? badge,
  }) {
    return ListTile(
      leading: Stack(
        children: [
          Icon(icon, color: selected ? Colors.red : Colors.white),
          if (badge != null)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badge,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        label,
        style: TextStyle(color: selected ? Colors.red : Colors.white),
      ),
    );
  }

  Widget buildActionButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        profileButton(),
        const SizedBox(height: 16),
        actionIcon(Icons.favorite, '621.4K'),
        const SizedBox(height: 16),
        actionIcon(Icons.comment, '4319'),
        const SizedBox(height: 16),
        actionIcon(Icons.bookmark, '28.6K'),
        const SizedBox(height: 16),
        actionIcon(Icons.share, '52.8K'),
      ],
    );
  }

  Widget profileButton() {
    return CircleAvatar(
      radius: 24,
      backgroundImage: AssetImage('images/profile1.png'),
    );
    // return Container();
  }

  Widget actionIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  void showUploadModal1(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 600,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Upload video',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Icon(Icons.upload_file, size: 80, color: Colors.white70),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Tarik lalu lepas file video yang ingin diupload',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Video Anda akan bersifat pribadi sampai Anda memublikasikannya.',
                  style: TextStyle(color: Colors.white38, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          Center(child: CircularProgressIndicator()));
                  FilePickerResult? video = await FilePicker.platform.pickFiles(
                    type: FileType.video,
                    allowMultiple: false,
                    onFileLoading: (FilePickerStatus status) => print(status),
                    dialogTitle: 'Pilih video',
                    withData: true,
                  );
                  if (video != null && video.files.single.bytes != null) {
                    // final fileBytes = result.files.single.bytes!;
                    // final fileName = result.files.single.name;

                    showUploadModal2(context, video);
                  }
                },
                child: Text('Pilih file'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              SizedBox(height: 24),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Dengan mengirimkan video ke TikTok, Anda menyatakan bahwa Anda setuju dengan Persyaratan Layanan dan Pedoman Komunitas TikTok.',
                  style: TextStyle(fontSize: 12, color: Colors.white38),
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Pelajari lebih lanjut',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showUploadModal2(
    BuildContext context,
    FilePickerResult video,

    // Uint8List fileBytes,
    // String fileName,
  ) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              16, 24, 16, MediaQuery.of(context).viewInsets.bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${video.files.single.name.substring(0, video.files.single.name.length - 4)}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 16),
              Text('Judul', style: TextStyle(color: Colors.white70)),
              TextField(
                controller: titleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '',
                  hintStyle: TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text('Deskripsi', style: TextStyle(color: Colors.white70)),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '',
                  hintStyle: TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (_) =>
                            Center(child: CircularProgressIndicator()));
                    await Video.uploadVideoWeb(
                      video: video,
                      title: titleController.text,
                      desc: descriptionController.text,
                    );

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text('Berikutnya'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildBottomBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) => {
          setState(() {
            currentIndex = index;
          }),
          if (index == 1) {showUploadModal1(context)}
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Upload'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          isMobile ? Container() : buildSidebar(),
          Expanded(
            child: Center(
              child: Container(
                width: isMobile ? double.infinity : 600,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _controllers.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) {
                    final controller = _controllers[index];
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: controller.value.aspectRatio,
                                child: VideoPlayer(controller),
                              )
                            : const Center(child: CircularProgressIndicator()),
                        Positioned(
                            bottom: 40,
                            left: 10,
                            child: Container(
                              width: 300,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '@user$index',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    videos[index].title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.74,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    videos[index].description,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 11.74),
                                  ),
                                ],
                              ),
                            )),
                        Positioned(
                          right: 5,
                          bottom: 50,
                          child: buildActionButtons(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile ? buildBottomBar() : null,
    );
  }
}
