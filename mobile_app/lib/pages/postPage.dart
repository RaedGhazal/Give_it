part of pages;

class PostPage extends StatefulWidget {
  final String category;

  const PostPage({@required this.category});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.category),
      ),
    );
  }
}
