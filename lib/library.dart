import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class Game {
  final String title;
  final String image;
  final double price;
  final int? discount;
  final DateTime? releaseDate; 

  Game(this.title, this.image, this.price, {this.discount, this.releaseDate});
}

class LibraryPage extends StatelessWidget {

  final List<Game> gameList = [
    Game('Devil May Cry 5', 'image/thumb-1920-926723.jpg', 29.99,
        releaseDate: DateTime(2019, 3, 8)),
    Game('Resident Evil 4', 'image/ResidentEvil4-Remake-PS5-Wallpapers-0.jpg',
        49.99,
        releaseDate: DateTime(2023, 3, 24)),
    Game('Pummel Party', 'image/capsule_616x353.jpg', 10.99,
        releaseDate: DateTime(2021, 10, 27)),
    Game('Left 4 Dead 2', 'image/left.jpg', 10.99,
        releaseDate: DateTime(2009, 11, 17)),
    Game('Rainbow Six Siege', 'image/r6s.jpg', 15.99,
        releaseDate: DateTime(2015, 12, 1)),
    Game('Call Of Duty War', 'image/cod.jpg', 49.99,
        releaseDate: DateTime(2020, 11, 13)),
    Game('Pay Day 3', 'image/payday-3.jpg', 28.99,
        discount: 60, releaseDate: DateTime(2024, 10, 15)),
    Game('Forza Horizon 5', 'image/forza.jpg', 46.99,
        discount: 50, releaseDate: DateTime(2024, 11, 22)),
    Game('Euro Truck Simulator', 'image/euro_truck.jpg', 11.99,
        discount: 75, releaseDate: DateTime(2024, 12, 05)),
    Game('Grand Theft Auto 5', 'image/gta_v.jpg', 39.99,
        discount: 66, releaseDate: DateTime(2024, 09, 30)),
  ];

  LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: gameList.length,
          itemBuilder: (context, index) {
            return gameList[index].discount != null
                ? DiscountedGameCard(
                    game: gameList[index],
                  )
                : GameCard(
                    game: gameList[index],
                  );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: const Text(
          'All Game',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 120,
            child: Image.asset(
              game.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black
                  .withOpacity(0.5), 
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${game.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                  if (game.releaseDate !=
                      null) 
                    const SizedBox(height: 4),
                  Text(
                    'Release Date: ${DateFormat('MMMM d, yyyy').format(game.releaseDate!)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscountedGameCard extends StatelessWidget {
  final Game game;

  const DiscountedGameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final double discountedPrice = game.price * (1 - game.discount! / 100);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 120,
            child: Image.asset(
              game.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black
                  .withOpacity(0.5),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${discountedPrice.toStringAsFixed(2)} (Discount ${game.discount}%)',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Original Price: \$${game.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  if (game.releaseDate !=
                      null)
                    const SizedBox(height: 4),
                  Text(
                    'Release Date: ${DateFormat('MMMM d, yyyy').format(game.releaseDate!)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
