part of pages;

///Sign-up & Sign-in Page.
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _phoneNumberKey = GlobalKey<FormState>();
  final _verifyPhoneKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _verifyPhoneController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      key: _scaffoldKey,
      body: ListView(
        padding: const EdgeInsets.only(top: 50, left: 60, right: 60),
        children: [
          //Title 1.
          Center(
            child: Text(
              'Give It',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          //Title 2
          Center(
            child: Text(
              '''Give what  you don't want,
         to people in need !''',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),

          const SizedBox(height: 30),
          Form(
            key: _phoneNumberKey,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                prefixText: '+962 ',
                labelText: 'Phone number',
                prefixStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) return 'Phone number cannot be empty';

                if (!isPhoneNumberFormatValid('+962 ${value.trim()}'))
                  return 'Invalid phone number';

                return null;
              },
            ),
          ),

          const SizedBox(height: 20),

          BigButton(
            text: 'Continue',
            onTap: () async {
              if (_phoneNumberKey.currentState.validate()) {
                if (!(await sendVerificationPhoneMessage(
                    '+962 ${_phoneNumberController.text.trim()}'))) {
                  showSnackBar(_scaffoldKey, content: 'Invalid Phone number');
                  return;
                }

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Verify phone number',
                        style: TextStyle(fontSize: 25),
                      ),
                      content: Form(
                        key: _verifyPhoneKey,
                        child: TextFormField(
                          controller: _verifyPhoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Verification code',
                          ),
                          validator: (value) {
                            if (value.isEmpty) return 'cannot be empty';
                            if (value == ' ') return 'Wrong code';

                            return null;
                          },
                        ),
                      ),
                      actions: [
                        FlatButton(
                          color: grey,
                          child: Text(
                            'Cancel',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).maybePop(context);
                          },
                        ),
                        FlatButton(
                          color: grey,
                          child: Text(
                            'Verify',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (!_verifyPhoneKey.currentState.validate())
                              return;

                            if (await verifyPhoneNumber(
                                _verifyPhoneController.text.trim())) {
                              addUser(
                                phoneNumber: user.phoneNumber,
                                country: 'jordan',
                                token: user.uid,
                              );

                              while (await Navigator.of(context).maybePop());
                            } else {
                              _verifyPhoneController.text = ' ';
                              _verifyPhoneKey.currentState.validate();
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}
