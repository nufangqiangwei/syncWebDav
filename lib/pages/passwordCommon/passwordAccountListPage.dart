import 'package:flutter/material.dart';
import 'package:sync_webdav/pages/passwordCommon/passwordUtils.dart';

import '../../common/cacheNetImage.dart';
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
    PassWordDataController.listenerWebSiteChange((){
      if(mounted){
        setState((){});
      }
      });
  }

  @override
  dispose(){
    super.dispose();
    PassWordDataController.removeListenerWebSiteChange((){
      if(mounted){
        setState((){});
      }
    });
  }

  Widget? addIcon() {
    return FloatingActionButton(
      onPressed: () {
        PassWordDataController.blackPage("detail");
        PassWordDataController.selectAccount(-1);
      },
      tooltip: '添加账号',
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
          title:  Text("${PassWordDataController.selectWebSite.name}  账号列表"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: DefaultWebSiteIcon(
                url:PassWordDataController.selectWebSite.icon,
                width: 45,
                height: 45,
                fit: BoxFit.fill,
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

class AccountPage extends StatelessWidget {
  const AccountPage(
      {required this.index,
        Key? key})
      : super(key: key);
  final int index;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PassWordDataController.blackPage("detail");
        PassWordDataController.selectAccount(index);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: secundario,
          borderRadius: BorderRadius.circular(10.0), //圆角
        ),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DefaultUserIcon(
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                      url: PassWordDataController.selectWebSite.icon,
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
                            PassWordDataController.webSiteAccount[index].userName,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            PassWordDataController.webSiteAccount[index].password,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
