// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../../../controllers/api.dart';

// class ProductListWidget extends StatefulWidget {
//   @override
//   _ProductListWidgetState createState() => _ProductListWidgetState();
// }

// class _ProductListWidgetState extends State<ProductListWidget> {

//   Future<void> fetchProducts() async {
//     final response = await http.get(Uri.parse(API.apiproducts)); // Replace YOUR_API_ENDPOINT_HERE with your API endpoint

//     if (response.statusCode == 200) {
//       // If the server returns a 200 OK response, parse the JSON
//       final List<dynamic> responseData = json.decode(response.body);
//       setState(() {
//         // Clear the existing list and populate with new data
//       });
//     } else {
//       // If the server did not return a 200 OK response, throw an exception
//       throw Exception('Failed to load products');
//     }
//   }

//   @override
//   void initState() {
//     fetchProducts();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product List'),
//       ),
//       body: productList.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: productList.length,
//               itemBuilder: (context, index) {
//                 final product = productList[index];
//                 return ListTile(
//                   title: Text(product.productName),
//                   subtitle: Text(product.brand),
//                   trailing: Text(product.price),
//                 );
//               },
//             ),
//     );
//   }
// }
