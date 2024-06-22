// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpFeedbackPage extends StatelessWidget {
  final List<QuestionAnswer> faq = [
    QuestionAnswer(
      question: 'How do I login?',
      answer: 'To login, click on the login button and enter your credentials.',
    ),
    QuestionAnswer(
      question: 'How do I reset my password?',
      answer:
          'To reset your password, click on the "Forgot Password?" link on the login page and follow the instructions.',
    ),
    QuestionAnswer(
      question: 'How do I sign up?',
      answer:
          'To sign up, click on the sign-up button and fill in the required information.',
    ),
  ];

  HelpFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Feedback'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 22),
            child: const Text(
              'Popular help resources?',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: faq.length,
            itemBuilder: (context, index) {
              return _buildQuestionTile(faq[index]);
            },
          ),
          Container(
            height: 13.0,
            color: const Color.fromARGB(255, 194, 193, 193),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.only(left: 22),
            child: const Text(
              'Need more help?',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              _launchEmail('flutteremperor@gmail.com');
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 234, 234),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 20.0),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'Tell us more and we will help you.',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              _launchEmail('flutteremperor@gmail.com');
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 234, 234),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 20.0),
                      Text(
                        'FAQ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'this is help.please take and go.yes',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchEmail(String toEmail) async {
    String emailUrl = 'mailto:$toEmail';
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }

  Widget _buildQuestionTile(QuestionAnswer questionAnswer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 3.0),
      child: ExpansionTile(
        title: Row(
          children: [
            const Icon(Icons.question_answer_sharp),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                questionAnswer.question,
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 8.0, bottom: 8.0),
            child: Text(questionAnswer.answer),
          ),
        ],
      ),
    );
  }
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({required this.question, required this.answer});
}
