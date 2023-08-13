import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/address_call_provider.dart';
import '../../../utils/constants/constants.dart';

class AddressKindSelector extends StatefulWidget {
  const AddressKindSelector({Key? key}) : super(key: key);



  @override
  State<AddressKindSelector> createState() => _AddressKindSelectorState();
}

class _AddressKindSelectorState extends State<AddressKindSelector> {
  String dropdownValue = kindList.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blue,
      ),
      child: DropdownButton<String>(
        iconSize: 0,
        borderRadius: BorderRadius.circular(16),
        value: dropdownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.black,fontSize: 14),
        underline: const Stack(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
          context.read<AddressCallProvider>().updateKind(dropdownValue);
        },
        items: kindList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              width: 45,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  // color: Colors.blue,
                ),
                child: Center(child: Text(value))),
          );
        }).toList(),
      ),
    );
  }
}