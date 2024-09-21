// ignore_for_file: library_private_types_in_public_api

import 'package:espace/build_appbart.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Contact', context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Envoyez-nous un message',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child: _buildContactForm(),
          ),
          const SizedBox(height: 30),
            const Text(
                'Contactez-nous',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(children: [
            
              _buildContactInfo(),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
                Icons.phone, FontAwesomeIcons.whatsapp, '+221 77 224 62 78'),
            const SizedBox(height: 10),
            _buildInfoRow(
                Icons.phone, FontAwesomeIcons.whatsapp, '+221 77 317 38 93'),
            const SizedBox(height: 10),
            _buildInfoRow(
                Icons.phone, FontAwesomeIcons.whatsapp, '+221 77 870 37 79'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.email, null, 'info@espace.beeggee.com'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.location_on, null,
                'Thiès Azur, près de la mosquée Route de dakar 2')
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon1, IconData? icon2, String text) {
    return Row(
      children: [
        Icon(icon1, color: Theme.of(context).primaryColor),
        if (icon2 != null) ...[
          const SizedBox(width: 5),
          Icon(icon2, color: Theme.of(context).primaryColor),
        ],
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _buildContactForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nom',
            filled: true,
            fillColor:Color.fromRGBO(198, 196, 197, 0.663),
           /*   enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green), // Color of the line when enabled
                  ), */
            ),
            
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre nom';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email',
            filled: true,
            fillColor:Color.fromRGBO(198, 196, 197, 0.663),
           /*  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green), // Color of the line when enabled
                  ), */
                  ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(labelText: 'Message',
            filled: true,
            fillColor:Color.fromRGBO(198, 196, 197, 0.663),
        /*     enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green), // Color of the line when enabled
                  ), */
                  ),
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre message';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Envoyer'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'khaly.drame@gmail.com',
        query: encodeQueryParameters(<String, String>{
          'subject': 'Nouveau message de ${_nameController.text}',
          'body':
              'Nom: ${_nameController.text}\nEmail: ${_emailController.text}\n\nMessage:\n${_messageController.text}'
        }),
      );
      launchUrl(emailLaunchUri);
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
