import 'package:flutter/material.dart';

class EShopCheckOutScreen extends StatelessWidget {
  const EShopCheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CartItem(
              image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
              title: 'Xbox series X',
              subtitle: '1 TB',
              price: 570.00,
            ),
            CartItem(
              image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
              title: 'Wireless Controller',
              subtitle: 'Blue',
              price: 77.00,
            ),
            CartItem(
              image:
                  'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg', 
              title: 'Razer Kaira Pro',
              subtitle: 'Green',
              price: 153.00,
            ),
            PromoCodeSection(),
            TotalSection(),
            Spacer(),
            CheckoutButton(),
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final double price;

  CartItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.network(image, width: 60, height: 60),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.grey)),
                Text('\$$price', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}


class PromoCodeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Promo code',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(onPressed: () {}, child: Text('Apply'))
        ],
      ),
    );
  }
}

class TotalSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal: ', style: TextStyle(fontSize: 16)),
              Text('\$800.00', style: TextStyle(fontSize: 16)),
              // Text('Delivery Fee: \$5.00', style: TextStyle(fontSize: 16)),
              // Text('\$5.00', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             
              Text('Delivery Fee:', style: TextStyle(fontSize: 16)),
              Text('\$5.00', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             
           
       
        Text('Total:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('\$480.00',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        
      ],
    );
  }
}

class CheckoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Checkout for \$480.00', style: TextStyle(color: Colors.black),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[200],
          minimumSize: Size(double.infinity, 50),
          textStyle: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
