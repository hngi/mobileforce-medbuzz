class BadgeModel {
  final String name;
  final int points;
  final String image;

  BadgeModel({
    this.name,
    this.points,
    this.image,
  });
}

List<BadgeModel> badges = [
  BadgeModel(
    name: 'Rookie Badge',
    image: 'images/fitnessbadge-active.png',
    points: 50,
  ),
  BadgeModel(
    name: 'Demi Badge',
    image: 'images/dietbadge-active.png',
    points: 100,
  ),
  BadgeModel(
    name: 'Go-Getter Badge',
    points: 150,
    image: 'images/dietbadge-active.png',
  ),
  BadgeModel(
    name: 'Interminnet Badge',
    image: 'images/dietbadge-active.png',
    points: 200,
  ),
  BadgeModel(
    name: 'Oracle Badge',
    image: 'images/dietbadge-active.png',
    points: 250,
  ),
  BadgeModel(
    name: 'Neon Badge',
    image: 'images/dietbadge-active.png',
    points: 300,
  ),
  BadgeModel(
    name: 'Warrior',
    image: 'images/dietbadge-active.png',
    points: 350,
  ),
  BadgeModel(
    name: 'King',
    image: 'images/dietbadge-active.png',
    points: 400,
  ),
  BadgeModel(
    name: 'Sahara',
    image: 'images/dietbadge-active.png',
    points: 450,
  ),
];
