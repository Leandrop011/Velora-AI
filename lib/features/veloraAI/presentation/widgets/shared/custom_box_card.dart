import 'package:flutter/material.dart';

class CustomBoxCard extends StatelessWidget {
  
  final Size size;
  final bool fountValue;
  final ColorScheme colorTheme;
  final TextTheme textTheme;
  final String title;
  final IconData icon;
  final String? description;
  
  const CustomBoxCard({
    super.key, 
    required this.size,
    required this.fountValue,
    required this.colorTheme,
    required this.textTheme, 
    required this.title, 
    required this.icon, 
    this.description,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.005,
          ),
          child: Container(
            width: size.width,
            height: size.height * 0.13,
            decoration: BoxDecoration(
              color: colorTheme.primaryContainer.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: fountValue ? Colors.white10 : Colors.black12),
            ),
    
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.1,
                    height: size.height * 0.055,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: colorTheme.primary.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Icon(
                        icon, 
                        color: colorTheme.primary,
                      ),
                    ),
                  ),
    
                  SizedBox(width: size.width * 0.03,),
                
                  SizedBox(
                    width: size.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: textTheme.titleMedium,
                        ),
                        SizedBox(height: size.height * 0.001,),
                        Text(
                          description ?? '',
                          style: textTheme.bodyMedium?.copyWith(
                            color: fountValue ? Colors.grey : Colors.black 
                          ),
                        )
                      ],
                    ),
                  ),
    
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
