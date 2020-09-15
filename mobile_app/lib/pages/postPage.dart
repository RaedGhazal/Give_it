part of pages;

class PostPage extends StatefulWidget {
  final String category;

  const PostPage({@required this.category});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var val;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: val,
                icon: Icon(Icons.sort),
                items: [
                  DropdownMenuItem(
                    child: Text('Test'),
                    value: 'Test',
                  ),
                  DropdownMenuItem(
                    child: Text('Test'),
                    value: 'Test',
                  ),
                  DropdownMenuItem(
                    child: Text('Test'),
                    value: 'Test',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    val = value;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
