import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/book.dart';
import 'books_view_model.dart';

class BookFormView extends StatefulWidget {
  final Book? book;

  const BookFormView({super.key, this.book});

  @override
  State<BookFormView> createState() => _BookFormViewState();
}

class _BookFormViewState extends State<BookFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _descriptionController;
  String _status = 'To Read';
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorController = TextEditingController(text: widget.book?.author ?? '');
    _descriptionController = TextEditingController(text: widget.book?.description ?? '');
    _status = widget.book?.status ?? 'To Read';
    _rating = widget.book?.rating ?? 0.0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.book != null;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Book' : 'Add New Book'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title_rounded),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter an author' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Text(
                'Reading Status',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: colorScheme.primary),
              ),
              const SizedBox(height: 12),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'To Read', label: Text('To Read')),
                  ButtonSegment(value: 'Reading', label: Text('Reading')),
                  ButtonSegment(value: 'Finished', label: Text('Finished')),
                ],
                selected: {_status},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    _status = newSelection.first;
                  });
                },
              ),
              if (_status == 'Finished') ...[
                const SizedBox(height: 24),
                Text(
                  'Your Rating',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: colorScheme.primary),
                ),
                Slider(
                  value: _rating,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  label: _rating.toString(),
                  onChanged: (value) => setState(() => _rating = value),
                ),
              ],
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final viewModel = context.read<BooksViewModel>();
                    if (isEditing) {
                      final updatedBook = widget.book!.copyWith(
                        title: _titleController.text,
                        author: _authorController.text,
                        description: _descriptionController.text,
                        status: _status,
                        rating: _rating,
                      );
                      await viewModel.updateStatus(updatedBook, _status);
                    } else {
                      await viewModel.addBook(
                        _titleController.text,
                        _authorController.text,
                        _descriptionController.text,
                      );
                    }
                    if (mounted) Navigator.pop(context);
                  }
                },
                child: Text(isEditing ? 'Save Changes' : 'Add to Library'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
