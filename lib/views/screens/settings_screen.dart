import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../controllers/quiz_controller.dart';
import '../../utils/image_path/images_path.dart';
import '../widgets/custom_drawer.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm({super.key});

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  final List<TextEditingController> _answerControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final _correctAnswerController = TextEditingController();
  late QuizController questionController;

  @override
  void initState() {
    super.initState();
    questionController = context.read<QuizController>();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _correctAnswerController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addAnswerField() {
    if (_answerControllers.length < 4) {
      setState(() {
        _answerControllers.add(TextEditingController());
      });
    }
  }

  void _removeAnswerField(int index) {
    if (_answerControllers.length > 2) {
      setState(() {
        _answerControllers.removeAt(index);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final question = _textEditingController.text;
      final answers =
          _answerControllers.map((controller) => controller.text).toList();
      final correct = int.tryParse(_correctAnswerController.text);

      if (correct != null && correct >= 0 && correct < answers.length) {
        questionController.addQuestion(
          answers,
          correct,
          question,
        );

        _textEditingController.clear();
        _correctAnswerController.clear();
        for (var controller in _answerControllers) {
          controller.clear();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid correct answer index')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return Scaffold(
      key: _key,
      backgroundColor: const Color(0xff7b7bce),
      appBar: AppBar(
        leadingWidth: 85,
        leading: GestureDetector(
          onTap: () => _key.currentState!.openDrawer(),
          child: Image.asset("assets/icons/face.gif"),
        ),
        title: const Text(
          'Add Question',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.hue),
            image: AssetImage(
              AppImages.onHasan,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 80),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                        width: 3.5,
                        color: Colors.blue,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                        width: 3.5,
                        color: Colors.blue,
                      ),
                    ),
                    labelText: 'Question',
                    labelStyle: TextStyle(color: Colors.red,fontSize: 24),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a question';
                    }
                    return null;
                  },
                ),
                const Gap(15.0),
                ..._answerControllers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final controller = entry.value;
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(
                                    width: 3.5,
                                    color: Colors.blue,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(
                                    width: 3.5,
                                    color: Colors.blue,
                                  ),
                                ),
                                labelText: 'Answer ${index + 1}',
                                labelStyle:
                                    const TextStyle(color: Colors.red,fontSize: 24),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an answer';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      if (_answerControllers.length > 2)
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _removeAnswerField(index),
                        ),
                    ],
                  );
                }).toList(),
                TextFormField(
                  controller: _correctAnswerController,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          width: 3.5,
                          color: Colors.blue,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Colors.white,
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.red,fontSize: 24),
                      labelText: 'Correct Answer Index (0-based)'),
                  validator: (value) {
                    final index = int.tryParse(value ?? '');
                    if (index == null ||
                        index < 0 ||
                        index >= _answerControllers.length) {
                      return 'Please enter a valid index';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade200),
                      onPressed: _addAnswerField,
                      child: const Text('Add Answer'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade200),
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
