import 'package:flutter/material.dart';

class Slideuphandel extends StatelessWidget {
	const Slideuphandel({ Key? key }) : super(key: key);
	@override
	Widget build(BuildContext context) {
		return Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 100, 49, 49),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
	}
}