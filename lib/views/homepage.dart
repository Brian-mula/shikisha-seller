import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shikishaseller/widgets/custome_input.dart';
import 'package:shikishaseller/widgets/info_text.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    ThemeData theme = Theme.of(context);
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
                                      onPressed: () {},
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
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.check,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      label: InfoText(
                                        text: "Cancel",
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
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: ListTile(
                        leading: Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1528795259021-d8c86e14354c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fG1vYmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                                  fit: BoxFit.cover)),
                        ),
                        title: const InfoText(text: "Product title"),
                        subtitle: InfoText(
                          text: "Approved",
                          textStyle: theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.green.shade600),
                        ),
                        trailing: InfoText(
                          text: "Ksh. 30000",
                          textStyle: theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.orange.shade600),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
