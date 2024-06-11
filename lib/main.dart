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
  final List<String> albums = [
    'Album 1',
    'Album 2',
    'Album 3',
    'Album 4',
    'Album 5',
  ];

  final Map<String, List<String>> albumSongs = {
    'Album 1': ['Song A1', 'Song A2', 'Song A3'],
    'Album 2': ['Song B1', 'Song B2', 'Song B3'],
    'Album 3': ['Song C1', 'Song C2', 'Song C3'],
    'Album 4': ['Song D1', 'Song D2', 'Song D3'],
    'Album 5': ['Song E1', 'Song E2', 'Song E3'],
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Three columns to make album tiles smaller
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumDetailScreen(
                    albumName: albums[index],
                    songs: albumSongs[albums[index]] ?? [],
                  ),
                ),
              );
            },
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    albums[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12.0, // Smaller font size
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
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

class AlbumDetailScreen extends StatelessWidget {
  final String albumName;
  final List<String> songs;

  AlbumDetailScreen({required this.albumName, required this.songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(albumName),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.music_note),
            title: Text(songs[index]),
          );
        },
      ),
    );
  }
}
