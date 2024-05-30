import 'package:flutter/material.dart';

void main() {
  runApp(SpotifyCloneApp());
}

class SpotifyCloneApp extends StatefulWidget {
  @override
  _SpotifyCloneAppState createState() => _SpotifyCloneAppState();
}

class _SpotifyCloneAppState extends State<SpotifyCloneApp> {
  final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LEO MUSIC',
          theme: ThemeData(
            primaryColor: Color(0xFFD2AC47), // changed to #D2AC47
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Arial',
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Arial',
            ),
          ),
          themeMode: currentMode,
          home: HomeScreen(themeNotifier: _themeNotifier),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  HomeScreen({required this.themeNotifier});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PlaylistScreen(),
    SearchScreen(),
    LibraryScreen(),
  ];

  bool _isPlaying = false; // Flag to track playback status

  // Function to handle playback control button taps
  void _handlePlayback(String action) {
    // Depending on the action, perform appropriate task
    setState(() {
      if (action == 'play_pause') {
        _isPlaying = !_isPlaying; // Toggle play/pause
      } else if (action == 'rewind') {
        // Perform rewind action
      } else if (action == 'forward') {
        // Perform forward action
      } else if (action == 'backward') {
        // Perform backward action
      } else if (action == 'shuffle') {
        // Perform shuffle action
      }
    });
  }

  void _toggleTheme() {
    widget.themeNotifier.value = widget.themeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text('LEO MUSIC')),
            IconButton(
              icon: Icon(Icons.brightness_6),
              onPressed: _toggleTheme,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          // Playback controls
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, size: 40), // Increased size here
                  onPressed: () => _handlePlayback('backward'),
                ),
                IconButton(
                  icon: _isPlaying ? Icon(Icons.pause, size: 40) : Icon(Icons.play_arrow, size: 40), // Increased size here
                  onPressed: () => _handlePlayback('play_pause'),
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, size: 40), // Increased size here
                  onPressed: () => _handlePlayback('forward'),
                ),
                IconButton(
                  icon: Icon(Icons.shuffle, size: 40), // Increased size here
                  onPressed: () => _handlePlayback('shuffle'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Your Library',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFD2AC47), // changed to #D2AC47
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class PlaylistScreen extends StatelessWidget {
  final List<String> playlists = [
    'Top Hits',
    'Discover Weekly',
    'Release Radar',
    'Chill Vibes',
    'Workout',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.music_note),
          title: Text(playlists[index]),
          onTap: () {
            // Navigate to playlist details
          },
        );
      },
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchResults = [
    'Song 1',
    'Song 2',
    'Artist 1',
    'Artist 2',
    'Album 1',
    'Album 2'
  ];
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<String> _filteredResults = _searchResults
        .where((result) =>
        result.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.music_note),
                title: Text(_filteredResults[index]),
                onTap: () {
                  // Handle search result tap
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class LibraryScreen extends StatelessWidget {
  final String profileName = 'User Name';
  final String profileEmail = 'user@example.com';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                child: Icon(Icons.person),
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black // Use black color in light mode
                          : Colors.white, // Use white color in dark mode
                    ),
                  ),
                  Text(
                    profileEmail,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black // Use black color in light mode
                          : Colors.white, // Use white color in dark mode
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.playlist_play),
                title: Text('Your Playlists'),
                onTap: () {
                  // Handle tap
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Liked Songs'),
                onTap: () {
                  // Handle tap
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Recently Played'),
                onTap: () {
                  // Handle tap
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
