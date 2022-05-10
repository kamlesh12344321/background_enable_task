import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/new_contact': (context) => NewContactView(),
      },
      home: const MyHomePage(title: 'Home Screen'),
    );
  }
}

class Contacts{
  final String name;
 const Contacts({ required this.name});
}

class ContactBook{
  ContactBook._sharedInstance();
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  final List<Contacts> _contacts = [];
  // Get method for getting contact list lenth
  int get length => _contacts.length;
  // Add Contact function

void add({required Contacts contacts}){
  _contacts.add(contacts);
}
  void remove({required Contacts contacts}){
    _contacts.remove(contacts);
  }

  // To return Contact
  Contacts? contacts({required int atIndex}) => _contacts.length > atIndex ? _contacts[atIndex] : null;
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final contactBook = ContactBook();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: contactBook.length,
          itemBuilder: (context, index){
            final contact = contactBook.contacts(atIndex: index)!;
            return ListTile(
              title: Text(contact.name),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/new_contact');
        },
        child: const Icon(Icons.add),
    ),
    );
  }
}

class NewContactView extends StatefulWidget {
  const NewContactView({Key? key}) : super(key: key);

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Add a new contact"),),
    body: Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText:'Enter a new contact name',
          ),
        ),
        TextButton(onPressed: (){
          final contact = Contacts(name: _controller.text);
          ContactBook().add(contacts: contact);
          Navigator.of(context).pop();
        },  child: const Text('add Contact'))
      ],
    ),);
  }
}



