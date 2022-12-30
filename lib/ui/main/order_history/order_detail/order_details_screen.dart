import 'dart:convert';

import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendorapp/core/core.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class OrderDetailsScreen extends StatefulWidget {
  List<Orderitems>? orderitems;
  CustomerOrderData? customerOrderData;
  OrderDetailsScreen(
      {super.key, required this.orderitems, this.customerOrderData});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List<Orderitems>? orderitems;
  CustomerOrderData? customerOrderData;
  @override
  void initState() {
    super.initState();
    orderitems = widget.orderitems;
    customerOrderData = widget.customerOrderData;
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(jsonEncode(orderitems));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appRed,
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppTheme.appWhite),
        title: Container(
          height: 50,
          margin: const EdgeInsets.only(right: 40),
          alignment: Alignment.center,
          child: Text(
            StringConstant.orderDetails,
            style: TextStyle(
                color: AppTheme.appWhite,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontFamily: StringConstant.fontFamily),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body:
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppTheme.appWhite,
        child: PdfPreview(
          allowPrinting: true,
          allowSharing: true,
          useActions: true,
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
          pdfFileName: 'MundaReceipt${customerOrderData!.id}',
          build: (format) => _generatePdf(format, 'Munda App'),
        ),
      ),
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       ListTile(
      //         title: Text('${customerOrderData!.name}',
      //             style: TextStyle(
      //                 color: AppTheme.appBlack,
      //                 fontSize: 16,
      //                 fontStyle: FontStyle.normal,
      //                 fontFamily: StringConstant.fontFamily)),
      //         subtitle: Text("${customerOrderData!.address}",
      //             style: TextStyle(
      //                 color: AppTheme.appBlack,
      //                 fontSize: 14,
      //                 fontWeight: FontWeight.w600,
      //                 fontStyle: FontStyle.normal,
      //                 fontFamily: StringConstant.fontFamily)),
      //         trailing: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Text(StringConstant.bill,
      //                 style: TextStyle(
      //                     color: AppTheme.appBlack,
      //                     fontSize: 16,
      //                     fontStyle: FontStyle.normal,
      //                     fontFamily: StringConstant.fontFamily)),
      //             Text(
      //                 '${StringConstant.rupeeSymbol}${customerOrderData!.finalamount}',
      //                 style: TextStyle(
      //                     color: AppTheme.appBlack,
      //                     fontSize: 16,
      //                     fontStyle: FontStyle.normal,
      //                     fontFamily: StringConstant.fontFamily)),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         child: Table(
      //             columnWidths: const {
      //               0: FlexColumnWidth(3),
      //               1: FlexColumnWidth(2),
      //               2: FlexColumnWidth(2),
      //               3: FlexColumnWidth(2),
      //               4: FlexColumnWidth(2),
      //             },
      //             border: TableBorder(
      //               top: BorderSide(color: AppTheme.appBlack),
      //               bottom: BorderSide(color: AppTheme.appBlack),
      //             ), // Allows to add a border decoration around your table
      //             children: [
      //               TableRow(
      //                   // decoration: BoxDecoration(
      //                   //     color:  AppTheme.appYellow
      //                   //         .withAlpha(40)),
      //                   children: [
      //                     Container(
      //                       padding: const EdgeInsets.all(4),
      //                       child: Text(
      //                         StringConstant.itemName,
      //                         style: TextStyle(
      //                             color: AppTheme.appBlack,
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w600),
      //                       ),
      //                     ),
      //                     Container(
      //                       padding: const EdgeInsets.all(4),
      //                       child: Text(
      //                         StringConstant.qty,
      //                         style: TextStyle(
      //                             color: AppTheme.appBlack,
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w600),
      //                       ),
      //                     ),
      //                     Container(
      //                       padding: const EdgeInsets.all(4),
      //                       child: Text(
      //                         StringConstant.rate,
      //                         style: TextStyle(
      //                             color: AppTheme.appBlack,
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w600),
      //                       ),
      //                     ),
      //                     Container(
      //                       padding: const EdgeInsets.all(4),
      //                       child: Text(
      //                         StringConstant.gst,
      //                         style: TextStyle(
      //                             color: AppTheme.appBlack,
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w600),
      //                       ),
      //                     ),
      //                     Container(
      //                       padding: const EdgeInsets.all(4),
      //                       child: Text(
      //                         StringConstant.total,
      //                         style: TextStyle(
      //                             color: AppTheme.appBlack,
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w600),
      //                       ),
      //                     ),
      //                   ]),
      //             ]),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.only(left: 10, right: 10),
      //         child: orderitems == null
      //             ? const SizedBox.shrink()
      //             : ListView.builder(
      //                 scrollDirection: Axis.vertical,
      //                 itemCount: orderitems!.length,
      //                 physics: const ClampingScrollPhysics(),
      //                 shrinkWrap: true,
      //                 itemBuilder: (context, index) {
      //                   return Container(
      //                     width: MediaQuery.of(context).size.width,
      //                     alignment: Alignment.topLeft,
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       children: [
      //                         // ListTile(
      //                         //   title: Text(
      //                         //       '${orderitems![index].name!} ( ${orderitems![index].unitqty} ${orderitems![index].unitqtyname})',
      //                         //       style: TextStyle(
      //                         //           color: AppTheme.appBlack,
      //                         //           fontSize: 16,
      //                         //           fontStyle: FontStyle.normal,
      //                         //           fontFamily: StringConstant.fontFamily)),
      //                         //   subtitle: Text(
      //                         //       "${StringConstant.rupeeSymbol}${orderitems![index].price}",
      //                         //       style: TextStyle(
      //                         //           color: AppTheme.appBlack,
      //                         //           fontSize: 16,
      //                         //           fontWeight: FontWeight.w600,
      //                         //           fontStyle: FontStyle.normal,
      //                         //           fontFamily: StringConstant.fontFamily)),
      //                         // ),
      //                         Table(columnWidths: const {
      //                           0: FlexColumnWidth(3),
      //                           1: FlexColumnWidth(2),
      //                           2: FlexColumnWidth(2),
      //                           3: FlexColumnWidth(2),
      //                           4: FlexColumnWidth(2),
      //                         }, children: [
      //                           TableRow(children: [
      //                             Container(
      //                               padding: const EdgeInsets.all(4),
      //                               child: Text(
      //                                 orderitems![index].name!,
      //                                 style: TextStyle(
      //                                   color: AppTheme.appBlack,
      //                                   fontSize: 14,
      //                                 ),
      //                               ),
      //                             ),
      //                             Container(
      //                               padding: const EdgeInsets.all(4),
      //                               child: Text(
      //                                 '${orderitems![index].qty}',
      //                                 style: TextStyle(
      //                                   color: AppTheme.appBlack,
      //                                   fontSize: 14,
      //                                 ),
      //                               ),
      //                             ),
      //                             Container(
      //                               padding: const EdgeInsets.all(4),
      //                               child: Text(
      //                                 '${orderitems![index].unitprice}',
      //                                 style: TextStyle(
      //                                   color: AppTheme.appBlack,
      //                                   fontSize: 14,
      //                                 ),
      //                               ),
      //                             ),
      //                             Container(
      //                               padding: const EdgeInsets.all(4),
      //                               child: Text(
      //                                 '${orderitems![index].gst}',
      //                                 style: TextStyle(
      //                                   color: AppTheme.appBlack,
      //                                   fontSize: 14,
      //                                 ),
      //                               ),
      //                             ),
      //                             Container(
      //                               padding: const EdgeInsets.all(4),
      //                               child: Text(
      //                                 '${orderitems![index].price}',
      //                                 style: TextStyle(
      //                                   color: AppTheme.appBlack,
      //                                   fontSize: 14,
      //                                 ),
      //                               ),
      //                             ),
      //                           ]),
      //                         ]),
      //                       ],
      //                     ),
      //                   );
      //                 }),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         child: Table(
      //             columnWidths: const {
      //               0: FlexColumnWidth(3),
      //               1: FlexColumnWidth(2),
      //               2: FlexColumnWidth(2),
      //               3: FlexColumnWidth(2),
      //               4: FlexColumnWidth(2),
      //             },
      //             border: TableBorder(
      //               top: BorderSide(color: AppTheme.appBlack),
      //               bottom: BorderSide(color: AppTheme.appBlack),
      //             ), // Allows to add a border decoration around your table
      //             children: [
      //               TableRow(children: [
      //                 Container(
      //                   padding: const EdgeInsets.all(4),
      //                   child: Text(
      //                     StringConstant.total,
      //                     style: TextStyle(
      //                         color: AppTheme.appBlack,
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w600),
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: const EdgeInsets.all(4),
      //                   child: Text(
      //                     '',
      //                     style: TextStyle(
      //                         color: AppTheme.appBlack,
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w600),
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: const EdgeInsets.all(4),
      //                   child: Text(
      //                     '',
      //                     style: TextStyle(
      //                         color: AppTheme.appBlack,
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w600),
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: const EdgeInsets.all(4),
      //                   child: Text(
      //                     '',
      //                     style: TextStyle(
      //                         color: AppTheme.appBlack,
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w600),
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: const EdgeInsets.all(4),
      //                   child: Text(
      //                     '${customerOrderData!.finalamount}',
      //                     style: TextStyle(
      //                         color: AppTheme.appBlack,
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w600),
      //                   ),
      //                 ),
      //               ]),
      //             ]),
      //       ),
      //
      //       Container(
      //         height: 400,
      //         color: AppTheme.appWhite,
      //         child: PdfPreview(
      //           allowPrinting: true,
      //           allowSharing: true,
      //           useActions: true,
      //           canChangePageFormat: false,
      //           canChangeOrientation: false,
      //           canDebug: false,
      //           build: (format) => _generatePdf(format, 'Kirana App'),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
  // Future<void> printPdf(BuildContext context) async {
  //
  // }
  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    // final font = await PdfGoogleFonts.nunitoExtraLight();
    // final fontText = await PdfGoogleFonts.montserratThin();
    PdfColor pdfBlack=    const PdfColor(0,0,0);
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
          pw.Container(
              margin:const pw.EdgeInsets.only(top: 10) ,
              child: pw.Text('$title',
                  style: pw.TextStyle(
                    color: pdfBlack,
                    fontSize: 22,))),
              pw.Container(
                margin:const pw.EdgeInsets.only(left: 10,right: 10) ,
                child:pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
             children:  [
               pw.Text('${customerOrderData!.name}',
                    style: pw.TextStyle(
                        color: pdfBlack,
                        fontSize: 16,)),
               pw.Text(StringConstant.bill,
                   style: pw.TextStyle(
                     color: pdfBlack,
                     fontSize: 16,)),
             ]
              ),),
              pw.Container(
                margin:const pw.EdgeInsets.only(left: 10,right: 10) ,
                  child:pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children:  [
                    pw.Text('${customerOrderData!.address}',
                        style: pw.TextStyle(
                          color: pdfBlack,
                          fontSize: 16,)),
                    pw.Text('${customerOrderData!.finalamount}',
                        style: pw.TextStyle(
                          color: pdfBlack,
                          fontSize: 16,)),
                  ]
              ),),
              pw.SizedBox(height: 20),
              pw.Container(
                margin: const pw.EdgeInsets.all(10),
                  child: pw.Table(
                columnWidths: const {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(2),
                  2: pw.FlexColumnWidth(2),
                  3: pw.FlexColumnWidth(2),
                  4: pw.FlexColumnWidth(2),
                },
                border: pw.TableBorder(
                  top: pw.BorderSide(color: pdfBlack),
                  bottom: pw.BorderSide(color:  pdfBlack),
                ),
                  children: [
                    pw.TableRow(
                      // decoration: BoxDecoration(
                      //     color:  AppTheme.appYellow
                      //         .withAlpha(40)),
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              StringConstant.itemName,
                              style: pw.TextStyle(
                                  color: pdfBlack,
                                  fontSize: 14,
                                  ),
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              StringConstant.qty,
                              style: pw.TextStyle(
                                  color:pdfBlack,
                                  fontSize: 14,
                                 ),
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              StringConstant.rate,
                              style: pw.TextStyle(
                                  color:pdfBlack,
                                  fontSize: 14,),
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              StringConstant.gst,
                              style: pw.TextStyle(
                                  color: pdfBlack,
                                  fontSize: 14,
                                 ),
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              StringConstant.total,
                              style: pw.TextStyle(
                                  color: pdfBlack,
                                  fontSize: 14,
                                  ),
                            ),
                          ),
                        ]),
                  ]
              ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                child: orderitems == null
                    ?  pw.SizedBox.shrink()
                    : pw.ListView.builder(
                    itemCount: orderitems!.length,
                    // physics: const ClampingScrollPhysics(),
                    // shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return pw.Container(
                        alignment: pw.Alignment.topLeft,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Table(columnWidths: const {
                              0: pw.FlexColumnWidth(3),
                              1: pw.FlexColumnWidth(2),
                              2: pw.FlexColumnWidth(2),
                              3: pw.FlexColumnWidth(2),
                              4: pw.FlexColumnWidth(2),
                            }, children: [
                              pw.TableRow(children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Text(
                                    orderitems![index].name!,
                                    style: pw.TextStyle(
                                      color: pdfBlack,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Text(
                                    '${orderitems![index].qty}',
                                    style: pw.TextStyle(
                                      color: pdfBlack,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Text(
                                    '${orderitems![index].unitprice}',
                                    style: pw.TextStyle(
                                      color:pdfBlack,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Text(
                                    '${orderitems![index].gst}',
                                    style: pw.TextStyle(
                                      color: pdfBlack,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(4),
                                  child:pw.Text(
                                    '${orderitems![index].price}',
                                    style: pw.TextStyle(
                                      color:pdfBlack,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ]),
                            ]),
                          ],
                        ),
                      );
                    }),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.all(10),
                child: pw.Table(
                    columnWidths: const {
                      0: pw.FlexColumnWidth(3),
                      1: pw.FlexColumnWidth(2),
                      2: pw.FlexColumnWidth(2),
                      3: pw.FlexColumnWidth(2),
                      4: pw.FlexColumnWidth(2),
                    },
                    border: pw.TableBorder(
                      top: pw.BorderSide(color: pdfBlack),
                      bottom: pw.BorderSide(color:  pdfBlack),
                    ),
                    children: [
                      pw.TableRow(
                        // decoration: BoxDecoration(
                        //     color:  AppTheme.appYellow
                        //         .withAlpha(40)),
                          children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                StringConstant.total,
                                style: pw.TextStyle(
                                  color: pdfBlack,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                '',
                                style: pw.TextStyle(
                                  color:pdfBlack,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                '',
                                style: pw.TextStyle(
                                  color:pdfBlack,
                                  fontSize: 14,),
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                '',
                                style: pw.TextStyle(
                                  color: pdfBlack,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                '${customerOrderData!.finalamount}',
                                style: pw.TextStyle(
                                  color: pdfBlack,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ]),
                    ]
                ),
              ),

            ],
          );
        },
      ),
    );

    return pdf.save();
  }


  Future<void> printReceipt(BuildContext context) async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    final PosPrintResult res =
        await printer.connect('192.168.0.123', port: 9100);

    if (res == PosPrintResult.success) {
      printDemoReceipt(printer);
      printer.disconnect();
    }

    print('Print result: ${res.msg}');

  }

  Future<void> printDemoReceipt(NetworkPrinter printer) async {
    printer.text('Kirana App',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    printer.row([
      PosColumn(text: '${customerOrderData!.name}', width: 7),
      PosColumn(text: StringConstant.bill, width: 3),
    ]);
    printer.row([
      PosColumn(text: '${customerOrderData!.address}', width: 7),
      PosColumn(
          text:
              '${StringConstant.rupeeSymbol}${customerOrderData!.finalamount}',
          width: 3),
    ]);
    // printer.text('${customerOrderData!.name}', styles: PosStyles(align: PosAlign.left));
    // printer.text('${customerOrderData!.address}',
    //     styles: PosStyles(align: PosAlign.left), linesAfter: 1);

    printer.hr();

    printer.row([
      PosColumn(text: StringConstant.itemName, width: 7),
      PosColumn(text: StringConstant.qty, width: 1),
      PosColumn(
          text: StringConstant.rate,
          width: 2,
          styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: StringConstant.gst,
          width: 2,
          styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: StringConstant.total,
          width: 2,
          styles: const PosStyles(align: PosAlign.right)),
    ]);

    for (int i = 0; i < orderitems!.length; i++) {
      printer.row([
        PosColumn(text: orderitems![i].name!, width: 7),
        PosColumn(text: orderitems![i].qty.toString(), width: 1),
        PosColumn(
            text: orderitems![i].unitprice.toString(),
            width: 2,
            styles: const PosStyles(align: PosAlign.right)),
        PosColumn(
            text: orderitems![i].gst.toString(),
            width: 2,
            styles: const PosStyles(align: PosAlign.right)),
        PosColumn(
            text: orderitems![i].price.toString(),
            width: 2,
            styles: const PosStyles(align: PosAlign.right)),
      ]);
    }

    // printer.row([
    //   PosColumn(text: 'ONION RINGS', width: 7),
    //   PosColumn(text: '2', width: 1),
    //   PosColumn(
    //       text: '0.99', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: '1.98', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: '1.98', width: 2, styles: PosStyles(align: PosAlign.right)),
    // ]);

    printer.hr();

    printer.row([
      PosColumn(
          text: StringConstant.total,
          width: 6,
          styles: const PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
          text:
              '${StringConstant.rupeeSymbol}${customerOrderData!.finalamount}',
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    printer.hr(ch: '=', linesAfter: 1);

    printer.feed(1);

    printer.cut();
  }
}
