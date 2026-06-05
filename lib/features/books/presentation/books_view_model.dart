import 'package:flutter/material.dart';
import '../data/books_repository.dart';
import '../domain/book.dart';

class BooksViewModel extends ChangeNotifier {
  final BooksRepository _booksRepository;

  BooksViewModel({required BooksRepository booksRepository}) : _booksRepository = booksRepository;

  List<Book> _books = [];
  bool _isLoading = false;

  List<Book> get books => _books;
  bool get isLoading => _isLoading;

  // Filtrado reactivo para las secciones del Dashboard
  List<Book> get toReadBooks => _books.where((b) => b.status == 'To Read').toList();
  List<Book> get readingBooks => _books.where((b) => b.status == 'Reading').toList();
  List<Book> get finishedBooks => _books.where((b) => b.status == 'Finished').toList();

  Future<void> loadBooks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _books = await _booksRepository.getBooks();
    } catch (e) {
      // Manejo de errores para el reporte
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBook(String title, String author, String description) async {
    final newBook = Book(
      id: '', 
      title: title, 
      author: author, 
      description: description, 
      coverUrl: 'https://via.placeholder.com/150', 
      rating: 0.0, 
      status: 'To Read'
    );
    await _booksRepository.createBook(newBook);
    await loadBooks();
  }

  Future<void> updateStatus(Book book, String newStatus) async {
    final updatedBook = book.copyWith(status: newStatus);
    await _booksRepository.updateBook(updatedBook);
    await loadBooks();
  }

  Future<void> deleteBook(String id) async {
    await _booksRepository.deleteBook(id);
    await loadBooks();
  }
}
