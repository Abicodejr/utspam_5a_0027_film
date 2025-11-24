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
        title: 'Money Heist',
        genre: 'Crime Thriller',
        price: 55000,
        poster: 'images/Money Heist.jpg',
        schedules: ['10:00 AM', '02:30 PM', '07:00 PM', '09:45 PM'],
      ),
      Film(
        title: 'The Godfather',
        genre: 'Crime Drama',
        price: 60000,
        poster: 'images/The Godfather.jpg',
        schedules: ['11:30 AM', '03:15 PM', '06:45 PM', '10:00 PM'],
      ),
      Film(
        title: 'Scarface',
        genre: 'Crime Drama',
        price: 50000,
        poster: 'images/Scarface.jpg',
        schedules: ['09:00 AM', '01:00 PM', '04:30 PM', '08:15 PM'],
      ),
      Film(
        title: 'Breaking Bad',
        genre: 'Crime Drama',
        price: 65000,
        poster: 'images/Breaking Bad.jpg',
        schedules: ['12:00 PM', '03:45 PM', '07:30 PM', '10:30 PM'],
      ),
      Film(
        title: 'The Departed',
        genre: 'Crime Thriller',
        price: 58000,
        poster: 'images/The Departed.jpg',
        schedules: ['10:30 AM', '02:00 PM', '05:45 PM', '09:00 PM'],
      ),
      Film(
        title: 'Narcos',
        genre: 'Crime Drama',
        price: 62000,
        poster: 'images/Narcos.jpg',
        schedules: ['11:00 AM', '02:45 PM', '06:15 PM', '09:30 PM'],
      ),
      Film(
        title: 'Heat',
        genre: 'Crime Action',
        price: 53000,
        poster: 'images/Heat.jpg',
        schedules: ['09:30 AM', '01:30 PM', '05:00 PM', '08:45 PM'],
      ),
      Film(
        title: 'The Town',
        genre: 'Crime Thriller',
        price: 57000,
        poster: 'images/The Town.jpg',
        schedules: ['10:15 AM', '02:15 PM', '06:00 PM', '09:15 PM'],
      ),
    ];
  }
}
