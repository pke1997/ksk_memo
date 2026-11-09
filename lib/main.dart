
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cash Memo App',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: ExpenseInputScreen(),
    );
  }
}

class ExpenseItem {
  String name;
  double rate;
  int qty;

  ExpenseItem({required this.name, required this.rate, required this.qty});

  double get amount => rate * qty;
}

class ShopDetails {
  String shopName;
  String address;
  String contact;
  String email;
  String memoNo;
  String date;
  String customerName;

  ShopDetails({
    required this.shopName,
    required this.address,
    required this.contact,
    required this.email,
    required this.memoNo,
    required this.date,
    required this.customerName,
  });
}

class ExpenseInputScreen extends StatefulWidget {
  @override
  _ExpenseInputScreenState createState() => _ExpenseInputScreenState();
}

class _ExpenseInputScreenState extends State<ExpenseInputScreen> {
  List<ExpenseItem> items = [
    ExpenseItem(name: 'Bulb', rate: 2800, qty: 2),
    ExpenseItem(name: 'Fan', rate: 2500, qty: 5),
  ];

  void _addNewRow() {
    setState(() {
      items.add(ExpenseItem(name: '', rate: 0.0, qty: 1));
    });
  }

  double get grandTotal {
    return items.fold(0.0, (sum, item) => sum + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cash Memo - Expenses'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text('My Expenses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              color: Colors.blueGrey[100],
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('Rate', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: TextEditingController(text: items[index].name)
                              ..selection = TextSelection.fromPosition(TextPosition(offset: items[index].name.length)),
                            decoration: InputDecoration(hintText: 'item name'),
                            onChanged: (val) => items[index].name = val,
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: TextEditingController(text: items[index].rate == 0 ? '' : items[index].rate.toStringAsFixed(0))
                              ..selection = TextSelection.fromPosition(TextPosition(offset: (items[index].rate == 0 ? '' : items[index].rate.toStringAsFixed(0)).length)),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Rate'),
                            onChanged: (val) {
                              setState(() {
                                items[index].rate = double.tryParse(val) ?? 0.0;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: TextEditingController(text: items[index].qty.toString())
                              ..selection = TextSelection.fromPosition(TextPosition(offset: items[index].qty.toString().length)),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Qty'),
                            onChanged: (val) {
                              setState(() {
                                items[index].qty = int.tryParse(val) ?? 1;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: Text(
                            items[index].amount.toStringAsFixed(0),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.add_box, color: Colors.teal, size: 36),
                  onPressed: _addNewRow,
                ),
                Text(
                  'Total: ${grandTotal.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 45),
              ),
              child: Text('Next Step (Shop Info) ->', style: TextStyle(color: Colors.white, fontSize: 16)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopDetailsScreen(items: items, totalAmount: grandTotal),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShopDetailsScreen extends StatefulWidget {
  final List<ExpenseItem> items;
  final double totalAmount;

  ShopDetailsScreen({required this.items, required this.totalAmount});

  @override
  _ShopDetailsScreenState createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  final _shopNameController = TextEditingController(text: 'KsK Electronics');
  final _addressController = TextEditingController(text: 'Mansehra');
  final _contactController = TextEditingController(text: '03170015034');
  final _emailController = TextEditingController(text: 'pke1997@gmail.com');
  final _memoNoController = TextEditingController(text: '520');
  final _dateController = TextEditingController(text: 'Fri 06/11/2026');
  final _customerController = TextEditingController(text: 'Quotation');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filename: My Expenses'),
        backgroundColor: Colors.brown[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _shopNameController,
              decoration: InputDecoration(labelText: 'Name of Shop/Store/Company'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(labelText: 'Contact no.'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _memoNoController,
              decoration: InputDecoration(labelText: 'Sl no/Cash Memo no'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _customerController,
              decoration: InputDecoration(labelText: 'Customer name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[800],
                minimumSize: Size(double.infinity, 45),
              ),
              child: Text('Generate Print View', style: TextStyle(color: Colors.white, fontSize: 16)),
              onPressed: () {
                ShopDetails details = ShopDetails(
                  shopName: _shopNameController.text,
                  address: _addressController.text,
                  contact: _contactController.text,
                  email: _emailController.text,
                  memoNo: _memoNoController.text,
                  date: _dateController.text,
                  customerName: _customerController.text,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrintInvoiceScreen(
                      items: widget.items,
                      details: details,
                      totalAmount: widget.totalAmount,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PrintInvoiceScreen extends StatelessWidget {
  final List<ExpenseItem> items;
  final ShopDetails details;
  final double totalAmount;

  PrintInvoiceScreen({
    required this.items,
    required this.details,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Preview'),
        backgroundColor: Colors.brown[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.brown.shade800, width: 2),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details.shopName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown[900]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Mob: ${details.contact}', style: TextStyle(fontSize: 10)),
                      Text('Mail: ${details.email}', style: TextStyle(fontSize: 10)),
                      Text('Add: ${details.address}', style: TextStyle(fontSize: 10)),
                    ],
                  )
                ],
              ),
              Divider(thickness: 1.5, color: Colors.brown[900]),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.brown[900],
                      padding: EdgeInsets.all(4),
                      child: Text('CUSTOMER NAME', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.brown[900],
                          width: double.infinity,
                          padding: EdgeInsets.all(4),
                          child: Text('REF.NO', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown.shade900),
                          ),
                          width: double.infinity,
                          padding: EdgeInsets.all(4),
                          child: Text(details.memoNo, textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.brown.shade900),
                      ),
                      padding: EdgeInsets.all(6),
                      child: Text(details.customerName, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.brown[900],
                          width: double.infinity,
                          padding: EdgeInsets.all(4),
                          child: Text('DATE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown.shade900),
                          ),
                          width: double.infinity,
                          padding: EdgeInsets.all(4),
                          child: Text(details.date, textAlign: TextAlign.center, style: TextStyle(fontSize: 9)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Table(
                border: TableBorder.all(color: Colors.brown.shade900),
                columnWidths: {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1.2),
                  2: FlexColumnWidth(0.8),
                  3: FlexColumnWidth(1.5),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.brown[900]),
                    children: [
                      Padding(padding: EdgeInsets.all(4), child: Text('PARTICULAR', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(4), child: Text('RATE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                      Padding(padding: EdgeInsets.all(4), child: Text('QTY', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                      Padding(padding: EdgeInsets.all(4), child: Text('AMOUNT', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                    ],
                  ),
                  ...items.where((i) => i.name.isNotEmpty).map((item) {
                    return TableRow(
                      children: [
                        Padding(padding: EdgeInsets.all(4), child: Text(item.name, style: TextStyle(fontSize: 10))),
                        Padding(padding: EdgeInsets.all(4), child: Text(item.rate.toStringAsFixed(0), style: TextStyle(fontSize: 10), textAlign: TextAlign.center)),
                        Padding(padding: EdgeInsets.all(4), child: Text(item.qty.toString(), style: TextStyle(fontSize: 10), textAlign: TextAlign.center)),
                        Padding(padding: EdgeInsets.all(4), child: Text(item.amount.toStringAsFixed(0), style: TextStyle(fontSize: 10), textAlign: TextAlign.center)),
                      ],
                    );
                  }).toList(),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown.shade900),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(color: Colors.brown[900], padding: EdgeInsets.all(4), child: Text('Subtotal', style: TextStyle(color: Colors.white, fontSize: 9))),
                            Expanded(child: Text(totalAmount.toStringAsFixed(0), textAlign: TextAlign.center, style: TextStyle(fontSize: 9))),
                          ],
                        ),
                        Divider(height: 1, color: Colors.brown[900]),
                        Row(
                          children: [
                            Container(color: Colors.brown[900], padding: EdgeInsets.all(4), child: Text('Total', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),
                            Expanded(child: Text(totalAmount.toStringAsFixed(0), textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown.shade900),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(color: Colors.brown[900], width: double.infinity, padding: EdgeInsets.all(2), child: Text('AUTHORIZED SIGN', style: TextStyle(color: Colors.white, fontSize: 7), textAlign: TextAlign.center)),
                      ],
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
