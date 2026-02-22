import 'package:flutter/material.dart';

class WordContainer extends StatelessWidget {

  final String word;
  final String translate;
  final bool isEdit;
  final Function() onPressed;

  const WordContainer({super.key, required this.word, required this.translate, required this.isEdit, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(

              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          word,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Container(
                          height: 1.5,
                          width: double.infinity,
                          color: Colors.blue,
                        ),

                        const SizedBox(height: 6),

                        Text(
                          translate,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  (isEdit)?IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.edit, color: Colors.blue,),
                  ):IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.blue,),
                  )
                ],
              )
          );

  }
}
