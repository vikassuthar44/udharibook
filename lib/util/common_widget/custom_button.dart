import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.isLoading,
      required this.buttonLabel,
      required this.isButtonEnable,
      required this.onTap});

  final bool isLoading;
  final String buttonLabel;
  final bool isButtonEnable;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: screenSize.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: isButtonEnable == true
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            borderRadius: BorderRadius.circular(10)),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Center(
                  child: Text(
                    buttonLabel,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
      ),
    );
  }
}
