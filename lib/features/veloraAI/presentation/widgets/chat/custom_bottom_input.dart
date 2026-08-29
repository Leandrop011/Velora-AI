import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/features/veloraAI/presentation/providers/config/app_fount_value_provider.dart';
import 'package:gemini_app/features/veloraAI/presentation/widgets/shared/custom_snack_bar.dart';
import 'package:image_picker/image_picker.dart';

class CustomBottomInput extends ConsumerStatefulWidget {
  final Function(types.PartialText, {List<XFile> images}) onSend;
  final Function()? onAttachmentPressed;

  const CustomBottomInput({
    super.key,
    required this.onSend,
    this.onAttachmentPressed,
  });

  @override
  ConsumerState<CustomBottomInput> createState() => _CustomBottomInputState();
}

class _CustomBottomInputState extends ConsumerState<CustomBottomInput> {
  String text = '';
  List<XFile> images = [];
  // ? CONTROLLER DEL INPUT
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final fountValue = ref.watch(appFountValueProvider).value;

    // ? FUNCION TEXTCHANGED, QUE CAMBIARA LA PROPERTY TEXT CADA QUE CAMBIA 
    // ? EL CONTENIDO DEL INPUT, CAPTURARA EL VALUE
    void onTextChanged(String value) {
      setState(() {
        text = value;
      });
    }

    // ? METODO QUE SE EJECUTA CUANDO EXISTE TEXT EN EL INPUT Y OBTIENE 
    // ? EL VALUE DE TEXT DEL INPUT EJECUTA LA FUNCION ONSEND Y LIMPIA CAMPOS
    void onSend() {
      if (text.isEmpty) return;
      final partialText = types.PartialText(text: text);

      // * FUNCION ONSEND QUE SE COMUNICA CON OTROS WIDGETS (EN EL CHAT SCREEN)
      // * EJECUTAMOS ESTA FUNCION PARA MANDAR EL TEXTO Y LAS IMAGES AL PROVIDER
      widget.onSend(partialText, images: images);
      setState(() {
        text = '';
        controller.clear();
        images = [];
      });
    }

    // ? METODO QUE EJECUTA UNA INSTANCIA DE IMAGEPICKER Y RECOPILA IMAGES 
    // ? DEL USER Y CAMBIA EL STATE DE UNA PROPERTY (LIST DE IMAGES)
    void onAttachmentPressed() async {
      ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage(limit: 4);
      if (images.isEmpty) return;

      // * snackbar si supera las 4 fotos
      if (images.length > 4){
        return CustomSnackBar.snackBar(
          // ignore: use_build_context_synchronously
          context, 
          'Se permite un maximo de 4 fotos por mensaje', 
          textTheme,
          colorTheme,
          fountValue,
        );
      }

      setState(() {
        this.images = images;
      });
    }

    void onDeleteImage(String path) {
      setState(() {
        images.removeWhere((element) => element.path == path);
      });
    }

    return Padding(
      padding: const EdgeInsetsGeometry.symmetric( vertical: 10, horizontal: 10 ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(10),
        child: Container(
          padding: const EdgeInsets.only(bottom: 5, top: 10),
          decoration: BoxDecoration(color: colorTheme.primary.withOpacity(0.1)),
          child: SafeArea(
            child: Column(
              children: [
        
                // ? Imágenes adjuntas
                if (images.isNotEmpty)
                  _ImageAttachments(images: images, onDeleteImage: onDeleteImage),
        
                Row(
                  children: [
                    // ? Botón para adjuntar archivos
                    IconButton(
                      onPressed: onAttachmentPressed,
                      icon: const Icon(Icons.attach_file_outlined),
                    ),
        
                    // ? Campo de texto expandible
                    _TextInput(
                      onTextChanged: onTextChanged,
                      controller: controller,
                    ),
        
                    // ? Botón de enviar con ícono de avión
                    IconButton(
                      onPressed: text.isEmpty ? null : onSend,
                      icon: Icon(
                        Icons.send,
                        color: text.isEmpty ? Colors.grey : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// * INPUT (AREA DEL TEXTO)
class _TextInput extends StatelessWidget {
  final Function(String) onTextChanged;
  final TextEditingController controller;

  const _TextInput({required this.onTextChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: TextField(
        
        controller: controller,
        // ? Función que se ejecuta cuando el texto cambia
        onChanged: onTextChanged,

        maxLines: 4, // ? Permite múltiples líneas
        minLines: 1, // ? Comienza con una línea

        decoration: InputDecoration(
          hintText: 'Escribe un mensaje...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: theme.colorScheme.primaryContainer,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),

        // Limita a 4 líneas máximo
      ),
    );
  }
}

// * IMAGENES CON SUS ACCIONES, ITERACION DE CADA UNA
class _ImageAttachments extends StatelessWidget {
  final List<XFile> images;
  final Function(String) onDeleteImage;

  const _ImageAttachments({required this.images, required this.onDeleteImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            images
                .map(
                  (e) => _ImageAttachment(
                    path: e.path,
                    onDeleteImage: onDeleteImage,
                  ),
                )
                .toList(),
      ),
    );
  }
}

// * ACCIONES DE CADA IMAGEN
class _ImageAttachment extends StatelessWidget {
  final String path;
  final Function(String) onDeleteImage;

  const _ImageAttachment({required this.path, required this.onDeleteImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        // ? Mostrar imagen en pantalla completa o realizar alguna acción
        showDialog(
          context: context,
          builder:
              (context) => Dialog(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(File(path)),
                  ),
                ),
              ),
        );
      },
      
      // ? Eliminar imagen
      onDoubleTap: () {
        onDeleteImage(path);
      },

      // ? imagen seleccionada
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(File(path), fit: BoxFit.cover),
        ),
      ),
    );
  }
}