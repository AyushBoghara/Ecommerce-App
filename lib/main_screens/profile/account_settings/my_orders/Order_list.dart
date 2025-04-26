import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/beginning/animation_loader.dart';
import 'package:onboarding/cmn_files/rounded_container.dart';
import 'package:onboarding/features/shop/controllers/product/order_controller.dart';
import 'package:onboarding/main_screens/home/navigation_menu.dart';
import 'package:onboarding/order_model.dart';
import 'package:onboarding/reviewAndRating/add_review.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/enums.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/cloud_helper_functions.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = THelperFunctions.isDarkMode(context);

    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        final emptyWidget = TAnimationLoaderWidget(
          text: "Woops! No orders Yet",
          animation: TImages.cartAnimation,
          showAction: true,
          actionText: "Let's fill it",
          onActionPressed: () => Get.off(() => NavigationMenu()),
        );
        final response = TCloudHelperFunctions.checkMultipleRecordState(
            snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        final orders = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: TSizes.spaceBtwItems * 1.7),
          itemBuilder: (_, index) {
            final order = orders[index];

            return TRoundedContainer(
              showBorder: true,
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Column(
                children: [
                  /// Row 1: Order Status and Date
                  Row(
                    children: [
                      const Icon(Iconsax.ship),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              order.orderStatusText,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                      color: TColors.primary,
                                      fontWeightDelta: 1),
                            ),
                            Text(order.formattedOrderDate,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                      ),

                      /// Download Invoice Button
                      IconButton(
                        onPressed: () => _downloadInvoice(order),
                        icon: const Icon(Iconsax.arrow_right_34,
                            size: TSizes.iconSm),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Row 2: Order ID and Shipping Date
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.tag),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order ID',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  Text(order.id,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Shipping Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  Text(order.formattedDeliveryDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Obx(() {
                  //       print('status1: ${order.orderStatusText}');
                  //       final status = order.orderStatusText; // Ensure this is reactive
                  //       print('status2: $status');
                  //
                  //       if (status == 'Delivered') {
                  //         print('Condition Matched: Showing AddReviewRatingScreen');
                  //         return  Expanded(child: AddReviewRatingScreen());
                  //       } else {
                  //         print('Condition NOT Matched: Returning SizedBox');
                  //         return const SizedBox();
                  //       }
                  //     }),
                  //   ],
                  // )
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Function to generate and download PDF invoice
  Future<void> _downloadInvoice(OrderModel order) async {
    if (await _requestStoragePermission()) {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // INVOICE (Bold, Centered)
              pw.Center(
                child: pw.Text(
                  'INVOICE',
                  style: pw.TextStyle(
                    fontSize: 36,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blueAccent,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),

              // Company Name "Style Zone"
              pw.Center(
                child: pw.Text(
                  'Style Zone',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.SizedBox(height: 70),

              // Order ID (Left) & Order Date (Right) - Same Line
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Order ID: ${order.id}',
                      style:
                          pw.TextStyle(fontSize: 16, color: PdfColors.black)),
                  pw.Text('Order Date: ${order.formattedOrderDate}',
                      style:
                          pw.TextStyle(fontSize: 16, color: PdfColors.black)),
                ],
              ),
              pw.SizedBox(height: 10),

              // User ID
              pw.Text('User ID: ${order.userId}',
                  style: pw.TextStyle(fontSize: 16)),

              pw.SizedBox(height: 20),

              // Payment Method
              pw.Text('Payment Method: ${order.paymentMethod}',
                  style: pw.TextStyle(fontSize: 16, color: PdfColors.black)),

              pw.SizedBox(height: 20), // Two-line space

              // Shipping Address Heading (Bold)
              pw.Text(
                'Shipping Address:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),

              // Shipping Address Details
              if (order.address != null) ...[
                pw.Text('Name: ${order.address!.name}'),
                pw.Text('Phone Number: ${order.address!.phoneNumber}'),
                pw.Text(
                    'Address: ${order.address!.street}, ${order.address!.city}, ${order.address!.state}, ${order.address!.country}'),
                pw.Text('Postal Code: ${order.address!.postalCode}'),
              ],
              pw.SizedBox(height: 15),

              // Items Table
              pw.Text(
                'Items:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                columnWidths: {
                  0: pw.FlexColumnWidth(2),
                  1: pw.FlexColumnWidth(1),
                  2: pw.FlexColumnWidth(1),
                  3: pw.FlexColumnWidth(1.5),
                },
                children: [
                  // Table Header
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Product Title',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Quantity',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Price',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Subtotal',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Table Rows
                  ...order.items.map((item) => pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(item.title ?? 'No title'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(item.quantity.toString()),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child:
                                pw.Text('\$${item.price.toStringAsFixed(2)}'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              '\$${(item.quantity * item.price).toStringAsFixed(2)}',
                            ),
                          ),
                        ],
                      )),
                ],
              ),

              pw.SizedBox(height: 15),

              // Additional Costs: Shipping & Tax
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Shipping Cost:', style: pw.TextStyle(fontSize: 16)),
                  pw.Text('\$${order.shippingCost.toStringAsFixed(2)}',
                      style: pw.TextStyle(fontSize: 16)),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Tax:', style: pw.TextStyle(fontSize: 16)),
                  pw.Text('\$${order.taxCost.toStringAsFixed(2)}',
                      style: pw.TextStyle(fontSize: 16)),
                ],
              ),
              pw.SizedBox(height: 15),

              // Total Amount Row
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Amount',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16,
                          color: PdfColors.black)),
                  pw.Text('\$${order.totalAmount.toStringAsFixed(2)}',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16,
                          color: PdfColors.black)),
                ],
              ),
            ],
          ),
        ),
      );

      // Save to Downloads folder
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final file = File('${directory.path}/Invoice_${order.id}.pdf');
      await file.writeAsBytes(await pdf.save());

      Get.snackbar('Success', 'Invoice downloaded: ${file.path}');
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
        return true; // API < 30
      } else if (await Permission.manageExternalStorage.request().isGranted) {
        return true; // API 30+
      } else if (await Permission.storage.isPermanentlyDenied) {
        Get.snackbar('Permission Required',
            'Please enable storage permission in settings.');
        await openAppSettings();
      }
    }
    return false;
  }
}
