class AvatarItem{
  final String name;
  final String image;
  AvatarItem({required this.name, required this.image});
  static final List<AvatarItem> items = [
    AvatarItem(name: 'All', image: 'assets/all.png'),
    AvatarItem(name: 'Business', image: 'assets/business.png'),
    AvatarItem(name: 'Sports', image: 'assets/sports.png'),
    AvatarItem(name: 'Health', image: 'assets/health.png'),
    AvatarItem(name: 'Entertainment', image: 'assets/entertainment.png'),
    AvatarItem(name: 'Science', image: 'assets/science.png'),
    AvatarItem(name: 'Technology', image: 'assets/technology.png'),

  ];
}