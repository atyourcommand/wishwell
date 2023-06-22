enum AssetType {
  property,
  cash,
  shares,
  chattels,
}

Map<String, AssetType> mapOfAssetType = {
  "Property": AssetType.property,
  "Cash": AssetType.cash,
  "Shares": AssetType.shares,
  "Chattels": AssetType.chattels,
};

extension Imagepath on AssetType {
  String get imagePath {
    switch (this) {
      case AssetType.property:
        return "https://png.pngtree.com/png-vector/20190223/ourmid/pngtree-vector-house-icon-png-image_695726.jpg";

      case AssetType.cash:
        return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdcTBPG918Pt-HmZb-9uZmzowYaa5YMc4wE1L4-KyZug&usqp=CAU&ec=48665701";

      case AssetType.shares:
        return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2qwIMxrRjpMh6GOAMLBlKW9YTMf4R70rWY5nGkZim5g&usqp=CAU&ec=48665701";

      case AssetType.chattels:
        return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3At5dR9gqHtmxJo9PfWP_r_iXYJU4tpAY9BU7rRR6cA&usqp=CAU&ec=48665701";
    }
  }
}

extension FontAwesomeName on AssetType {
  String get fontAwesomeName {
    switch (this) {
      case AssetType.property:
        return "FontAwesomeIcons.user";

      case AssetType.cash:
        return "FontAwesomeIcons.user";

      case AssetType.shares:
        return "FontAwesomeIcons.user";

      case AssetType.chattels:
        return "FontAwesomeIcons.user";
    }
  }
}
