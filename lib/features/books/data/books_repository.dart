import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/book.dart';

class BooksRepository {
  // Nota: En un entorno real, usaríamos una URL base. 
  // Aquí simulamos las peticiones HTTP para cumplir con el requerimiento del informe.
  final String _baseUrl = 'https://api.bookshelfclub.com/v1';

  // Simulación de una base de datos local para el prototipo
  final List<Book> _mockDb = [
    Book(
      id: '1',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      description: 'A story of wealth, love, and the American Dream in the 1920s.',
      coverUrl: 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1490528560i/4671.jpg',
      rating: 4.5,
      status: 'Finished',
    ),
    Book(
      id: '2',
      title: '1984',
      author: 'George Orwell',
      description: 'A dystopian social science fiction novel and cautionary tale.',
      coverUrl: 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1532714506i/40961427.jpg',
      rating: 4.8,
      status: 'Reading',
    ),
    Book(
      id: '3',
      title: 'Brave New World',
      author: 'Aldous Huxley',
      description: 'A searching vision of an unequal, technologically advanced future.',
      coverUrl: 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1547137435i/375802.jpg',
      rating: 0.0,
      status: 'To Read',
    ),
  ];

  Future<List<Book>> getBooks() async {
    // Ejemplo de implementación GET
    // final response = await http.get(Uri.parse('$_baseUrl/books'));
    // if (response.statusCode == 200) { ... }
    
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_mockDb);
  }

  Future<Book> createBook(Book book) async {
    // Ejemplo de implementación POST
    // final response = await http.post(
    //   Uri.parse('$_baseUrl/books'),
    //   body: jsonEncode(book.toJson()),
    // );
    
    await Future.delayed(const Duration(seconds: 1));
    final newBook = book.copyWith(id: DateTime.now().millisecondsSinceEpoch.toString());
    _mockDb.add(newBook);
    return newBook;
  }

  Future<void> updateBook(Book book) async {
    // Ejemplo de implementación PUT
    // await http.put(
    //   Uri.parse('$_baseUrl/books/${book.id}'),
    //   body: jsonEncode(book.toJson()),
    // );
    
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockDb.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      _mockDb[index] = book;
    }
  }

  Future<void> deleteBook(String id) async {
    // Ejemplo de implementación DELETE
    // await http.delete(Uri.parse('$_baseUrl/books/$id'));
    
    await Future.delayed(const Duration(milliseconds: 500));
    _mockDb.removeWhere((b) => b.id == id);
  }
}
