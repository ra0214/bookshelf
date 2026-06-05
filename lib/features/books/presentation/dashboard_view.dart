import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/book.dart';
import 'books_view_model.dart';
import 'book_form_view.dart';
import '../../auth/presentation/auth_view_model.dart';
import '../../auth/presentation/login_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    // Carga inicial de datos siguiendo el patrón MVVM
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BooksViewModel>().loadBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final booksViewModel = context.watch<BooksViewModel>();
    final authViewModel = context.watch<AuthViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('My Library'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const BookFormView()),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout_rounded),
                onPressed: () {
                  authViewModel.logout();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginView()),
                  );
                },
              ),
            ],
          ),
          if (booksViewModel.isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else ...[
            _buildSectionHeader(context, 'Current Readings'),
            _buildBookList(booksViewModel.readingBooks),
            _buildSectionHeader(context, 'To Read'),
            _buildBookList(booksViewModel.toReadBooks),
            _buildSectionHeader(context, 'Finished'),
            _buildBookList(booksViewModel.finishedBooks, isFinished: true),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const BookFormView()),
        ),
        icon: const Icon(Icons.menu_book_rounded),
        label: const Text('Add Book'),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
        ),
      ),
    );
  }

  Widget _buildBookList(List<Book> books, {bool isFinished = false}) {
    if (books.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'No books in this section.',
            style: TextStyle(color: Colors.grey.shade600, fontStyle: FontStyle.italic),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final book = books[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => BookFormView(book: book)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          book.coverUrl,
                          width: 70,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 70,
                            height: 100,
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: const Icon(Icons.book_rounded),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              book.author,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade700,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              book.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            if (isFinished) ...[
                              const SizedBox(height: 8),
                              Row(
                                children: List.generate(5, (i) => Icon(
                                  i < book.rating ? Icons.star_rounded : Icons.star_outline_rounded,
                                  size: 16,
                                  color: Colors.amber,
                                )),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          _buildStatusAction(context, book),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, size: 20),
                            color: Theme.of(context).colorScheme.error,
                            onPressed: () => _confirmDelete(context, book.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: books.length,
        ),
      ),
    );
  }

  Widget _buildStatusAction(BuildContext context, Book book) {
    if (book.status == 'To Read') {
      return IconButton(
        icon: const Icon(Icons.play_circle_outline_rounded, color: Colors.green),
        onPressed: () => context.read<BooksViewModel>().updateStatus(book, 'Reading'),
      );
    } else if (book.status == 'Reading') {
      return IconButton(
        icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.blue),
        onPressed: () => context.read<BooksViewModel>().updateStatus(book, 'Finished'),
      );
    }
    return const SizedBox.shrink();
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Book'),
        content: const Text('Are you sure you want to remove this book from your library?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              context.read<BooksViewModel>().deleteBook(id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
