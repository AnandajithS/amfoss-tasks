import 'dart:convert';
import 'package:flutter/material.dart';

// Model classes (unchanged)
class HeroModel {
  final int id;
  final String name;
  final String slug;
  final Powerstats powerstats;
  final Biography biography;
  final Work work;
  final Connections connections;
  final Images images;

  HeroModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.powerstats,
    required this.biography,
    required this.work,
    required this.connections,
    required this.images,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      powerstats: Powerstats.fromJson(json['powerstats']),
      biography: Biography.fromJson(json['biography']),
      work: Work.fromJson(json['work']),
      connections: Connections.fromJson(json['connections']),
      images: Images.fromJson(json['images']),
    );
  }
}

class Powerstats {
  final int intelligence;
  final int strength;
  final int speed;
  final String eyeColor;
  final String hairColor;

  Powerstats({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.eyeColor,
    required this.hairColor,
  });

  factory Powerstats.fromJson(Map<String, dynamic> json) {
    return Powerstats(
      intelligence: json['intelligence'],
      strength: json['strength'],
      speed: json['speed'],
      eyeColor: json['eyeColor'],
      hairColor: json['hairColor'],
    );
  }
}

class Biography {
  final String fullName;
  final String alterEgos;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;

  Biography({
    required this.fullName,
    required this.alterEgos,
    required this.placeOfBirth,
    required this.firstAppearance,
    required this.publisher,
    required this.alignment,
  });

  factory Biography.fromJson(Map<String, dynamic> json) {
    return Biography(
      fullName: json['fullName'],
      alterEgos: json['alterEgos'],
      placeOfBirth: json['placeOfBirth'],
      firstAppearance: json['firstAppearance'],
      publisher: json['publisher'],
      alignment: json['alignment'],
    );
  }
}

class Work {
  final String occupation;
  final String base;

  Work({required this.occupation, required this.base});

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      occupation: json['occupation'],
      base: json['base'],
    );
  }
}

class Connections {
  final String groupAffiliation;
  final String relatives;

  Connections({required this.groupAffiliation, required this.relatives});

  factory Connections.fromJson(Map<String, dynamic> json) {
    return Connections(
      groupAffiliation: json['groupAffiliation'],
      relatives: json['relatives'],
    );
  }
}

class Images {
  final String xs;
  final String sm;
  final String md;
  final String lg;

  Images({required this.xs, required this.sm, required this.md, required this.lg});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      xs: json['xs'],
      sm: json['sm'],
      md: json['md'],
      lg: json['lg'],
    );
  }
}

// Main Application
void main() {
  runApp(HeroApp());
}

class HeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hero App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HeroListScreen(),
    );
  }
}

// Hero List Screen
class HeroListScreen extends StatefulWidget {
  @override
  _HeroListScreenState createState() => _HeroListScreenState();
}

class _HeroListScreenState extends State<HeroListScreen> {
  List<HeroModel> heroes = [];
  List<HeroModel> filteredHeroes = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchHeroes();
    });
  }

  Future<void> fetchHeroes() async {
    final String response = await DefaultAssetBundle.of(context).loadString('assets/heroes.json');
    final List<dynamic> heroList = json.decode(response);

    setState(() {
      heroes = heroList.map((data) => HeroModel.fromJson(data)).toList();
      filteredHeroes = heroes;
      isLoading = false;
    });
  }

  void filterHeroes(String query) {
    setState(() {
      searchQuery = query;
      filteredHeroes = heroes.where((hero) {
        return hero.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(hintText: 'Search Heroes...'),
          onChanged: filterHeroes,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: filteredHeroes.length,
              itemBuilder: (context, index) {
                final hero = filteredHeroes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HeroDetailScreen(hero: hero),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(hero.images.sm),
                        SizedBox(height: 10),
                        Text(hero.name),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// Hero Detail Screen
class HeroDetailScreen extends StatelessWidget {
  final HeroModel hero;

  HeroDetailScreen({required this.hero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hero.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Image.network(hero.images.lg),
            SizedBox(height: 10),
            Text("Full Name: ${hero.biography.fullName}", style: TextStyle(fontSize: 18)),
            Text("Superpowers: Strength ${hero.powerstats.strength}, Speed ${hero.powerstats.speed}", style: TextStyle(fontSize: 18)),
            Text("Place of Birth: ${hero.biography.placeOfBirth}", style: TextStyle(fontSize: 18)),
            Text("First Appearance: ${hero.biography.firstAppearance}", style: TextStyle(fontSize: 18)),
            Text("Group Affiliation: ${hero.connections.groupAffiliation}", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
