import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/common/passwordUtils.dart';
import 'package:sync_webdav/common/utils.dart';
import 'package:sync_webdav/model/class.dart';
import 'package:sync_webdav/model/model.dart';

class PassWordPage extends StatefulWidget {
  const PassWordPage({Key? key}) : super(key: key);

  @override
  State<PassWordPage> createState() => _PassWordPageState();
}

class _PassWordPageState extends State<PassWordPage> {
  final _formKey = GlobalKey<FormState>();
  List<PassWordData> webSiteAccountData = [];
  late PassWordData accountDetail;
  double _sliderValue = 16;

  @override
  initState() {

    super.initState();
  }

  Widget showPage(BuildContext context) {
    switch (Provider.of<GlobalParams>(context).page) {
      case 'webSite':
        {
          return webSiteList(context);
        }
      case 'account':
        {
          return webSiteAccount(context);
        }
      case 'detail':
        {
          return passwordDetail(context);
        }
      default:
        {
          return webSiteList(context);
        }
    }
  }

  onTouchWebSite(String webSite) {
    getWebSitePassword(webSite).then((value) => setState(() {
          webSiteAccountData = value;
        }));
  }

  Widget webSiteList(BuildContext context) {
    List<WebSite> webSiteList = Provider.of<GlobalParams>(context).webSiteList;
    // List<WebSite> webSiteList = [
    //   WebSite(icon: './assets/icons/google.ico',name: 'google',url:'https://www.google.com')
    // ];
    return ListView.separated(
      itemCount: webSiteList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var web = webSiteList[index];
        return ListTile(
          // leading:Image(image: AssetImage(web.icon)),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/icons/defaultWebsite.ico",
              image: web.icon!,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/icons/defaultWebsite.ico");
              },
            ),
          ),
          title: Text(web.name!),
          subtitle: Text(web.url!),
          selectedColor: Colors.blue,
          onTap: () {
            onTouchWebSite(web.name!);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.blue);
      },
    );
  }

  Widget webSiteAccount(BuildContext context) {
    return ListView.separated(
      itemCount: webSiteAccountData.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var account = webSiteAccountData[index];
        return ListTile(
          // leading:Image(image: AssetImage(web.icon)),
          // leading: Image.asset(web.icon),
          title: Text(account.userName),
          subtitle: const Text('*********'),
          onTap: () {
            Provider.of<GlobalParams>(context, listen: false)
                .ModifyPage("detail");
            accountDetail = account;
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.black);
      },
    );
  }

  passwordDetail(BuildContext context) {
    var windowsWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: windowsWidth * 0.85,
      child: Form(
        key: _formKey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(padding: EdgeInsets.only(top: 30)),
            TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.verified_user),
                  labelText: "用户名",
                )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(children: [
              SizedBox(
                width: windowsWidth * 0.75,
                child: TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.password),
                      labelText: "密码",
                    )),
              ),
              const Padding(padding: EdgeInsets.only(left: 15)),
              const Icon(Icons.add_alarm),
              // const SizedBox(
              //   width: 20,
              //   child: Icon(Icons.add_alarm),
              // )
            ]),
            Row(
              children: [
                const Text('位数'),
                SizedBox(
                  width: windowsWidth * 0.7,
                  child: Slider(
                    value: _sliderValue,
                    onChanged: (double value) {},
                    // onChanged: (double  data){
                    //   print('change:$data');
                    //   setState(() {
                    //     _sliderValue = data.ceilToDouble();
                    //   });
                    // },
                    // onChangeStart: (data){
                    //   print('start:$data');
                    // },
                    onChangeEnd: (data) {
                      setState(() {
                        _sliderValue = data.ceilToDouble();
                      });
                    },
                    min: 8.0,
                    max: 36.0,
                    divisions: 10,
                    label: '$_sliderValue',
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()} dollars}';
                    },
                  ),
                ),
                Text(_sliderValue.toString())
              ],
            ),
            TextFormField(
                decoration: const InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.speaker_notes_outlined),
              labelText: "备注",
            )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextFormField(
                decoration: const InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.speaker_notes_outlined),
              labelText: "备注",
            )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextFormField(
                decoration: const InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.speaker_notes_outlined),
              labelText: "备注",
            )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextFormField(
                decoration: const InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.speaker_notes_outlined),
              labelText: "备注",
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [const SearchPassword(), showPage(context)],
      )),
      onWillPop: () async {
        switch (Provider.of<GlobalParams>(context).page) {
          case 'webSite':
            {
              Navigator.pop(context);
              break;
            }
          case 'account':
            {
              Provider.of<GlobalParams>(context, listen: false)
                  .ModifyPage('webSite');
              break;
            }
          case 'detail':
            {
              Provider.of<GlobalParams>(context, listen: false)
                  .ModifyPage('account');
              break;
            }
          default:
            {
              return false;
            }
        }
        return false;
      },
    );
  }
}

class SearchPassword extends StatefulWidget {
  const SearchPassword({Key? key}) : super(key: key);

  @override
  State<SearchPassword> createState() => _SearchPassword();
}

class _SearchPassword extends State<SearchPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white12,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.black.withOpacity(0.1),
      ),
      child: const SearchInput(),
    );
  }
}

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchInput();
}

class _SearchInput extends State<SearchInput> {
  FocusNode focusNode = FocusNode();

  RelativeRect _position(RenderBox popupButtonObject, RenderBox overlay) {
    // var Left = popupButtonObject.localToGlobal(
    //     popupButtonObject.size.bottomLeft(Offset.zero),
    //     ancestor: overlay);
    // var Right = popupButtonObject.localToGlobal(
    //     popupButtonObject.size.bottomRight(Offset.zero),
    //     ancestor: overlay);
    // print('Left X:${Left.dx},Left Y: ${Left.dy}');
    // print('Right X:${Right.dx},Right Y: ${Right.dy}');
    // // Calculate the show-up area for the dropdown using button's size & position based on the `overlay` used as the coordinate space.
    // var xx = RelativeRect.fromSize(
    //   Rect.fromPoints(Left,Right),
    //   Size(overlay.size.width, overlay.size.height),
    // );
    // print('xx.left${xx.left}, xx.top${xx.top}, xx.right${xx.right}, xx.bottom${xx.bottom}');
    return const RelativeRect.fromLTRB(41, 107, 41, 900);
  }

  ///openMenu
  _openMenu() {
    // Here we get the render object of our physical button, later to get its size & position
    final popupButtonObject = context.findRenderObject() as RenderBox;
    // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
    var overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    print('windowHeight: ${window.physicalSize.width}');
    // print('popupButtonObjectWidth: ${popupButtonObject.size.width}, popupButtonObjectHeight: ${popupButtonObject.size.height}');
    // print('overlayWidth: ${overlay.size.width},overlayHeight: ${overlay.size.height}');
    showMenu(
      context: context,
      position: _position(popupButtonObject, overlay),
      items: <PopupMenuEntry>[
        const PopupMenuItem(
            child: Text("RNG")), // Menu Item
        const PopupMenuItem(child: Text("342")), // Menu Item
        const PopupMenuItem(child: Text("sdrf")), // Menu Item
        const PopupMenuItem(child: Text("rt34")), // Menu Item
        const PopupMenuItem(child: Text("wgerfg")), // Menu Item
        const PopupMenuItem(child: Text("dtg34")), // Menu Item
        const PopupMenuItem(child: Text("345ref")), // Menu Item
        const PopupMenuItem(child: Text("45yrt")), // Menu Item
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        _openMenu();
        // Provider.of<GlobalParams>(context,listen: false).ModifyWebSiteList(initDatabaseData());
      },
      focusNode: focusNode,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.blue[500],
        ),
        hintText: "搜索",
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
