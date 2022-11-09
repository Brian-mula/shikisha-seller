import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:shikishaseller/models/products_model.dart';
import 'package:shikishaseller/providers/products_provider.dart';
import 'package:shikishaseller/widgets/custome_input.dart';
import 'package:shikishaseller/widgets/info_text.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? imgUrl;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadImage(String? inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery);
      final String fileName = path.basename(pickedImage!.name);
      File file = File(pickedImage.path);
      var snapshot =
          await storage.ref().child("images/$fileName").putFile(file);

      final downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imgUrl = downloadUrl;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final userProducts = ref.watch(userProduct);
    final product = ref.watch(productProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: InfoText(
          text: "Your Prodcts",
          textStyle: theme.textTheme.headline6!
              .copyWith(color: Colors.orange.shade600),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange.shade600)),
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => Form(
                          child: AlertDialog(
                            title: Center(
                                child: InfoText(
                              text: "Add new Product",
                              textStyle: theme.textTheme.headline6!
                                  .copyWith(color: Colors.orange.shade600),
                            )),
                            scrollable: true,
                            content: Column(
                              children: [
                                CustomeInput(
                                    controller: nameController, label: "Name"),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomeInput(
                                    controller: descriptionController,
                                    label: "Description"),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomeInput(
                                    controller: priceController,
                                    label: "Price"),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton.icon(
                                    onPressed: () async {
                                      await uploadImage('');
                                    },
                                    icon: const Icon(Icons.file_copy),
                                    label: InfoText(
                                      text: "Upload image",
                                      textStyle: theme.textTheme.bodyLarge!
                                          .copyWith(color: Colors.white),
                                    ))
                              ],
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red.shade600)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      label: InfoText(
                                        text: "Cancel",
                                        textStyle: theme.textTheme.bodyLarge!
                                            .copyWith(color: Colors.white),
                                      )),
                                  ElevatedButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green.shade600)),
                                      onPressed: () async {
                                        ProductModel productModel =
                                            ProductModel(
                                          isVerified: false,
                                          title: nameController.text,
                                          category: "category",
                                          description:
                                              descriptionController.text,
                                          img: imgUrl!,
                                          price:
                                              int.parse(priceController.text),
                                          seller: auth.currentUser!.phoneNumber,
                                        );
                                        await product.addProduct(
                                            productModel,
                                            auth.currentUser!.phoneNumber,
                                            context);
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      label: InfoText(
                                        text: "Save",
                                        textStyle: theme.textTheme.bodyLarge!
                                            .copyWith(color: Colors.white),
                                      ))
                                ],
                              )
                            ],
                          ),
                        )),
                icon: const Icon(Icons.add, color: Colors.white, size: 30),
                label: InfoText(
                  text: "New Product",
                  textStyle:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                )),
            SizedBox(
                height: 650,
                child: userProducts.when(
                    data: (data) {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: ListTile(
                                leading: Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                          image: NetworkImage(data[index].img),
                                          fit: BoxFit.cover)),
                                ),
                                title: InfoText(text: data[index].title),
                                subtitle: InfoText(
                                  text: data[index].isVerified
                                      ? "Approved"
                                      : "Not Approved",
                                  textStyle: data[index].isVerified
                                      ? theme.textTheme.bodyLarge!.copyWith(
                                          color: Colors.green.shade600)
                                      : theme.textTheme.bodyLarge!
                                          .copyWith(color: Colors.red.shade600),
                                ),
                                trailing: InfoText(
                                  text: "Ksh. ${data[index].price}",
                                  textStyle: theme.textTheme.bodyLarge!
                                      .copyWith(color: Colors.orange.shade600),
                                ),
                              ),
                            );
                          });
                    },
                    error: (error, stackTrace) =>
                        InfoText(text: error.toString()),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        )))
          ],
        ),
      ),
    );
  }
}
