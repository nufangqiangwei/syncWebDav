import 'package:flutter/material.dart';
import 'package:sync_webdav/pages/passwordCommon/passwordUtils.dart';

import '../../model/JsonModel.dart';
import '../../pkg/save/model.dart';
import './searchPage.dart';
import 'data.dart';

class AccountListPage extends StatefulWidget {
  const AccountListPage({
    Key? key,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {

  @override
  initState(){
    super.initState();
    PassWordDataController.listenerWebSiteChange((){setState((){});});
  }


  Widget? addIcon() {
    return FloatingActionButton(
      onPressed: () {
        PassWordDataController.selectAccount(-1);
      },
      tooltip: 'Increment',
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: pageThem,
      child: Scaffold(
        appBar: AppBar(
          leading: const IconButton(
            onPressed: PassWordDataController.blackPage,
            icon: Icon(Icons.arrow_back),
          ),
          title: const Text("账号列表"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: FadeInImage.assetNetwork(
                width: 45,
                height: 45,
                fit: BoxFit.fill,
                placeholder: "assets/icons/defaultWebsite.ico",
                image: "assets/icons/defaultWebsite.ico",
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/icons/defaultWebsite.ico",
                    width: 45,
                    height: 45,
                    fit: BoxFit.fill,
                  );
                },
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: PassWordDataController.webSiteAccount.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                child: SAppBarSearch(),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(
                  left: 15, top: 15, right: 15, bottom: 0),
              child: AccountPage(
                password: PassWordDataController.webSiteAccount[index - 1],
                index: index - 1,
              ),
            );
          },
        ),
        floatingActionButton: addIcon(),
      ),
    );
  }
}

class AccountPage extends StatefulWidget {
  const AccountPage(
      {required this.password,
        required this.index,
        Key? key})
      : super(key: key);
  final AccountData password;
  final int index;

  @override
  State<StatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: secundario,
        borderRadius: BorderRadius.circular(10.0), //圆角
      ),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                PassWordDataController.selectAccount(widget.index);
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FadeInImage.assetNetwork(
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                      placeholder: "assets/icons/defaultUser.png",
                      image: "assets/icons/defaultUser.png",
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/icons/defaultUser.png",
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 360),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.password.userName,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.password.password,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}