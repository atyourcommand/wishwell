import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import 'package:wishwell/client_model.dart';
import '../provider/asset_provider.dart';
//import '../utils/enums.dart';
import 'assets_model.dart';
import 'edit_assets.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AssetsPage extends StatelessWidget {
  final Assets asset;
  final double totalPercentage;

  const AssetsPage({
    Key? key,
    required this.asset,
    required this.totalPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Asset',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
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
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.grey.shade200,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      asset.assetsName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   asset.assetsType,
                //   style: Theme.of(context).textTheme.bodyMedium,
                // ),

                // Text(
                //   "Approximate value: \$${asset.value.toDouble().toString()}",
                //   style: Theme.of(context).textTheme.bodyMedium,
                // ),

                // Image.network(
                //   mapOfAssetType[asset.assetsType]?.imagePath ?? '',
                //   scale: 4.5,
                // ),

                CircularPercentIndicator(
                  radius: 90.0,
                  lineWidth: 30.0,
                  animation: true,
                  percent: (totalPercentage / 100),
                  center: Text(
                    '${totalPercentage.toString()}%',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: Text(
                    "\nApproximate value: ${formatCurrency.format(asset.value.toDouble()).toString()}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: const Color.fromARGB(255, 108, 142, 235),
                ),

                // Text(
                //   asset.assetsName,
                //   style: const TextStyle(
                //     fontSize: 30,
                //     fontWeight: FontWeight.w300,
                //     color: Colors.black,
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),

                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Divider(color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("${asset.assetsType} shared between:",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  height: 50,
                ),
                // const Text(
                //   "allocated to",
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w300,
                //     color: Colors.grey,
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: asset.shares.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${asset.shares[index].clientName.toString()} ${asset.shares[index].shareValue.toString()}%",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                // Text(
                                //   "",
                                //   style: const TextStyle(
                                //     fontSize: 22,
                                //     color: Colors.black,
                                //     fontWeight: FontWeight.w300,
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // const Text(
                            //   "Approximate value",
                            //   style: TextStyle(
                            //     fontSize: 22,
                            //     color: Colors.grey,
                            //     fontWeight: FontWeight.w300,
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // Text(
                            //   'Approximate value - ${formatCurrency.format(asset.shares[index].shareValue * asset.value * 0.01)}',
                            //   style: Theme.of(context).textTheme.bodySmall,
                            // ),
                            Text(
                              'Approximate value - ${formatCurrency.format(asset.shares[index].shareValue * asset.value * 0.01)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: 30,
                            )
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
                  child: const Text(
                    'Delete this asset',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                // Container(
                //   child: (const Padding(
                //     padding: EdgeInsets.only(
                //         left: 15.0, right: 15.0, bottom: 1.0, top: 0.0),
                //     child: Card(
                //       elevation: 0,
                //       shape: RoundedRectangleBorder(
                //           side: BorderSide(
                //         color: Colors.black12,
                //       )),
                //       child: Padding(
                //         padding: EdgeInsets.all(8.0),
                //         child: Text('Add assets list view here'),
                //       ),
                //     ),
                //   )),
                // ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
