import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Seção 1
                TitleSection(),
                // Seção 2 
                ArtistGrid(),
                // Seção 3
                NewReleaseSection(),
                // Seção 4
                RecommendedPlaylists(),
                // Adicionando o espaçamento maior abaixo das playlists
                SizedBox(height: 32),  
              ],
            ),
          ),
          // Seção 5 
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Miniplayer(),
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}

// Seção 1: Título e ícones
class TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.8), Colors.white.withOpacity(0.1)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Olá Gariton', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Icon(Icons.notifications, color: Colors.white),
              SizedBox(width: 16),
              Icon(Icons.settings, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}

// Seção 2: Grid com artistas 
class ArtistGrid extends StatelessWidget {
  final List<Artist> artists = [
    Artist('Derek', 'https://thisis-images.spotifycdn.com/37i9dQZF1DZ06evO2URr5W-default.jpg'),
    Artist('Ryu, The Runner', 'https://i.scdn.co/image/ab67616100005174d73dbbe6ab17585d42d945bd'),
    Artist('Mu540', 'https://yt3.googleusercontent.com/bh-GU0PPG6An27iTHK0zkA9rFBDEnflWds-JzoFCZ7wb0_rIqBJOb9irP1DLrEPp_G-1n6aUQA=s900-c-k-c0x00ffffff-no-rj'),
    Artist('DJ Ramon Sucesso', 'https://i1.sndcdn.com/artworks-TIG58wRLLeLEFREb-uigRNw-t500x500.jpg'),
    Artist('Skank', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvcjbfs6i5spiLTtN5kCEAydSD_8fe8zTzqA&s'),
    Artist('Tayler The Creator', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXcEyZZ4W-Vj5kb13bQ94DzNp-lZOy596JdbaoK-PyFPCc9XSxOpeOBxMov5lSG7J16AU&usqp=CAU'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8, 
          mainAxisSpacing: 8, 
          childAspectRatio: 3.0,
        ),
        itemCount: artists.length,
        itemBuilder: (context, index) {
          return ArtistCard(artist: artists[index]);
        },
      ),
    );
  }
}

// Model de artista para representar os dados de cada card
class Artist {
  final String name;
  final String imageUrl;

  Artist(this.name, this.imageUrl);
}

// Card de artista individual
class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard({required this.artist});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              artist.imageUrl,
              fit: BoxFit.cover,
              height: 150, // Imagem ajustada
              width: 150,  // Imagem ajustada
            ),
          ),
          SizedBox(width: 12),
          Text(artist.name, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// Seção 3: Novo lançamento 
class NewReleaseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://cdn-images.dzcdn.net/images/cover/eae2437894635519584a8e6a2af45b84/0x1900-000000-80-0-0.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Exalta Samba', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Novo Lançamento', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          AlbumCard(),
        ],
      ),
    );
  }
}

// Card do álbum com a imagem, nome da música, artista, e botões
class AlbumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Image.network(
            'https://lastfm.freetls.fastly.net/i/u/ar0/8ed1f8280fba59770277ea67c3b240f2.jpg',
            fit: BoxFit.cover,
            height: 180,
            width: double.infinity,
          ),
          Positioned(
            bottom: 10,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fire na Babilonia', style: TextStyle(fontSize: 16, color: Colors.white)),
                Text('DJ Cleiton Rasta', style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 16,
            child: Row(
              children: [
                Icon(Icons.favorite_border, color: Colors.white),
                SizedBox(width: 16),
                Icon(Icons.play_arrow, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Seção 4: Playlist recomendadas
class RecommendedPlaylists extends StatelessWidget {
  // Lista de playlists com dados personalizáveis
  final List<Playlist> playlists = [
    Playlist('Autodominio', 'https://i.scdn.co/image/ab67616d0000b273a7bb97684153cd195be77054'),
    Playlist('É que eu nasci teimoso', 'https://images.genius.com/8b19fbdef80c16720b13d08f2d73ba4a.1000x1000x1.jpg'),
    Playlist('Chromakopia', 'https://i.scdn.co/image/ab67616d0000b273124e9249fada4ff3c3a0739c'),
    Playlist('Funk', 'https://i.scdn.co/image/ab67616d0000b2737bc063e7e131dddface63635'),
    Playlist('MM... FOOD', 'https://m.media-amazon.com/images/I/61IhnFgGQPL._UF894,1000_QL80_.jpg'),
    Playlist('Doomsday', 'https://i.scdn.co/image/ab67616d0000b2736ce90ec627a0198a8efd127f'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 200, // A altura da área de playlists
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                return PlaylistCard(playlist: playlists[index]);
              },
            ),
          ),
          SizedBox(height: 50), // Espaço extra abaixo das playlists
        ],
      ),
    );
  }
}

// seção 4 Model de Playlist para representar os dados de cada card
class Playlist {
  final String name;
  final String imageUrl;

  Playlist(this.name, this.imageUrl);
}

// Card de playlist individual
class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.network(
              playlist.imageUrl,
              width: 160,
              height: 120,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 10,
              left: 16,
              child: Text(
                playlist.name,
                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Seção 5: Miniplayer
class Miniplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://m.media-amazon.com/images/I/61IhnFgGQPL._UF894,1000_QL80_.jpg',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('One Beer', style: TextStyle(fontSize: 14)),
              Text('MF Doom', style: TextStyle(fontSize: 12)),
            ],
          ),
          Spacer(),
          Icon(Icons.computer, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.favorite_border, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.play_arrow, color: Colors.white),
        ],
      ),
    );
  }
}

// Menu inferior
class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
        BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Playlists'),
      ],
    );
  }
}
