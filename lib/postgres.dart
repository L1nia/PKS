//  class DatabaseHelper {
//   final PostgreSQLConnection connection;

//   DatabaseHelper()
//       : connection = PostgreSQLConnection(
//           'localhost', // Замените на адрес вашего сервера
//           5432, // Обычно 5432
//           'video_cards',
//           username: 'postgres',
//           password: '1973',
//         );

//   Future<void> open() async {
//     await connection.open();
//   }

//   Future<List<Map<String, dynamic>>> getVideoCards() async {
//     final results = await connection.query('SELECT * FROM video_cards');
//     return results.map((row) => {
//       'id': row[0],
//       'name': row[1],
//       'image_url': row[2],
//       'price': row[3],
//     }).toList();
//   }

//   Future<void> close() async {
//     await connection.close();
//   }
// }