part of pages;

class AddPostBody extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  AddPostBody(this.scaffoldKey);

  @override
  _AddPostBodyState createState() => _AddPostBodyState();
}

class _AddPostBodyState extends State<AddPostBody> {
  Location location = Location();

  String category;
  List<String> categories = ['text1', 'test2'];

  final _descriptionKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  final _subCategoryKey = GlobalKey<FormState>();
  final _subCategoryController = TextEditingController();

  FilePickerResult filePickerResult;

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return ListView(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        children: [
          //Add images.
          Text(
            'Add one image at least',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Container(
            height: 250,
            width: double.infinity,
            child: GridView(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1,
              ),
              children: [
                GestureDetector(
                  child: Container(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    color: lightGrey,
                  ),
                  onTap: () async {
                    filePickerResult = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      allowCompression: true,
                      allowMultiple: true,
                      withData: true,
                    );

                    setState(() {});
                  },
                ),
                if (filePickerResult != null)
                  for (int i = 0; i < filePickerResult.files.length; i++)
                    Image.memory(
                      filePickerResult.files[i].bytes,
                      fit: BoxFit.cover,
                    ),
              ],
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          //Location
          const SizedBox(
            height: 15,
          ),
          PickLocation(location),

          const SizedBox(
            height: 15,
          ),

          //Category
          RoundedDropDownButton(
            DropdownButton<String>(
              hint: Text('Category'),
              value: category,
              items: <DropdownMenuItem<String>>[
                for (int i = 0; i < categories.length; i++)
                  DropdownMenuItem<String>(
                    value: categories[i],
                    child: Text(categories[i]),
                  )
              ],
              onChanged: (value) {
                setState(() {
                  category = value;
                });
              },
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //Sub-category
          MyForm(
            labelText: 'Sub category',
            formKey: _subCategoryKey,
            controller: _subCategoryController,
            validator: (value) {
              if (value.trim().isEmpty) return 'Sub category cannot be empty';
              return null;
            },
          ),

          const SizedBox(
            height: 10,
          ),

          //Description.
          MyForm(
            labelText: 'Description',
            formKey: _descriptionKey,
            controller: _descriptionController,
            validator: (value) {
              if (value.trim().length == 0)
                return 'Description cannot be empty';

              return null;
            },
          ),

          const SizedBox(
            height: 10,
          ),

          //Upload
          FlatButton(
            color: grey,
            child: Text('Upload',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white,
                    )),
            onPressed: () async {
              if (filePickerResult == null) {
                showSnackBar(widget.scaffoldKey,
                    content: 'Choose at least one image');

                return;
              }
              if (filePickerResult.files.length > 5) {
                showSnackBar(widget.scaffoldKey,
                    content:
                        'Maximum number of images is 5 , please reduce the number of images');

                return;
              }

              _descriptionKey.currentState.validate();
              _subCategoryKey.currentState.validate();

              if (category == null) {
                showSnackBar(widget.scaffoldKey,
                    content: 'category cannot be empty');
                return;
              }

              if (location == null) {
                showSnackBar(widget.scaffoldKey,
                    content: 'location cannot be empty');
                return;
              }

              final images = List<List<String>>();
              for (var i = 0; i < filePickerResult.files.length; i++)
                images.add([
                  base64Encode(filePickerResult.files[i].bytes),
                  filePickerResult.files[i].name
                ]);

              //TODO: TEST ONLY , FIX IT.
              addPost(
                phoneNumber: null,
                userToken: null,
                images: images,
                categoryId: 1,
                subCategoryId: 1,
                country: 'jordan',
                city: location.governorate,
                description: _descriptionController.text.trim(),
              );

              setState(() {});
            },
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: FlatButton(
              child: Text(
                'Sign in',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white),
              ),
              color: grey,
              onPressed: () async {
                await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );

                setState(() {});
              },
            ),
          ),
        ],
      );
    }
  }
}

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add post'),
      ),
      body: AddPostBody(_scaffoldKey),
    );
  }
}
