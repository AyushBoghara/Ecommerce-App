class SettingsModel {
  final String appName;
  final double freeShippingThreshold;
  final double shippingCost;
  final double taxRate;

  SettingsModel({
    required this.appName,
    required this.freeShippingThreshold,
    required this.shippingCost,
    required this.taxRate,
  });

  factory SettingsModel.fromMap(Map<String, dynamic> data) {
    return SettingsModel(
      appName: data['appName'] ?? 'My App',
      freeShippingThreshold: (data['freeShippingThreshold'] ?? 0.0).toDouble(),
      shippingCost: (data['shippingCost'] ?? 0.0).toDouble(),
      taxRate: (data['taxRate'] ?? 0.0).toDouble(),
    );
  }
}