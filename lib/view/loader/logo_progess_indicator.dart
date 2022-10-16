import 'package:flutter/material.dart';
import 'package:sw_app/configuration/dynamic_configuration.dart';

///
/// Adapt the image to be displayed
/// depending on the current theme (sith or jedi side)
///
class LogoProgressIndicator extends StatelessWidget {
  const LogoProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                color: Colors.black,
                child: Image.asset(
                  DynamicConfiguration.of(context).isDark
                      ? 'assets/images/imperial_logo_loading.gif'
                      : 'assets/images/jedi_logo_loading.gif',
                  height: 125.0,
                  width: 125.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
