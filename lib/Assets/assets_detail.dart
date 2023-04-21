import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/client_model.dart';
import '../provider/asset_provider.dart';
import 'edit_assets.dart';

class AssetsPage extends StatelessWidget {
  final Assets asset;

  const AssetsPage({
    Key? key,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AssetsEdit(
                      asset: asset,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: SizedBox.expand(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Icon(
              Icons.account_circle_outlined,
              color: Colors.grey.shade400,
              size: 80,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              asset.assetsType,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              asset.assetsName,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Asset value: ${asset.value.toDouble().toString()}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: asset.shares.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${asset.shares[index].clientName.toString()} :",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          " ${asset.shares[index].shareValue.toString()}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            const SizedBox(height: 30),
            OutlinedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    scrollable: true,
                    title: const Text('Delete'),
                    content: const Text('Do You Want to delete it ?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<AssetsProvider>()
                              .deleteByIdAssets(asset.id);
                          context
                              .read<AssetsProvider>()
                              .clienAssets
                              .remove(asset);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Client deleted'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      )
                    ],
                  ),
                );
                // AllData.deleteClient('1');
              },
              child: const Text('Delete this person from your Will'),
            ),
            Container(
              child: (const Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 1.0, top: 0.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                    color: Colors.black12,
                  )),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Add assets list view here'),
                  ),
                ),
              )),
            ),
          ]),
        ),
      ),
    );
  }
}
