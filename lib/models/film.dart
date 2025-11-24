class Film {
  final String title;
  final String genre;
  final double price;
  final String poster;
  final List<String> schedules;

  Film({
    required this.title,
    required this.genre,
    required this.price,
    required this.poster,
    required this.schedules,
  });

  static List<Film> getDummyFilms() {
    return [
      Film(
        title: 'The Heist Syndicate',
        genre: 'Crime Thriller',
        price: 55000,
        poster: '💰',
        schedules: ['10:00 AM', '02:30 PM', '07:00 PM', '09:45 PM'],
      ),
      Film(
        title: 'Kingpin Rising',
        genre: 'Crime Drama',
        price: 60000,
        poster: '👑',
        schedules: ['11:30 AM', '03:15 PM', '06:45 PM', '10:00 PM'],
      ),
      Film(
        title: 'Blood Money',
        genre: 'Crime Action',
        price: 50000,
        poster: '💸',
        schedules: ['09:00 AM', '01:00 PM', '04:30 PM', '08:15 PM'],
      ),
      Film(
        title: 'The Cartel',
        genre: 'Crime Thriller',
        price: 65000,
        poster: '🔫',
        schedules: ['12:00 PM', '03:45 PM', '07:30 PM', '10:30 PM'],
      ),
      Film(
        title: 'Undercover Justice',
        genre: 'Crime Mystery',
        price: 58000,
        poster: '🕵️',
        schedules: ['10:30 AM', '02:00 PM', '05:45 PM', '09:00 PM'],
      ),
      Film(
        title: 'Mafia Vendetta',
        genre: 'Crime Drama',
        price: 62000,
        poster: '🎩',
        schedules: ['11:00 AM', '02:45 PM', '06:15 PM', '09:30 PM'],
      ),
      Film(
        title: 'Street Kings',
        genre: 'Crime Action',
        price: 53000,
        poster: '🚔',
        schedules: ['09:30 AM', '01:30 PM', '05:00 PM', '08:45 PM'],
      ),
      Film(
        title: 'The Fugitive',
        genre: 'Crime Thriller',
        price: 57000,
        poster: '⛓️',
        schedules: ['10:15 AM', '02:15 PM', '06:00 PM', '09:15 PM'],
      ),
    ];
  }
}
