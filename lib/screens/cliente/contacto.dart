import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/models/User.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

class contacto extends StatelessWidget {
  final AppUser user;
  const contacto({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundColor,
        title: Text(l10n.contactTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: buildLanguageDropdown(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LOGO
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Appcolor.backgroundColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.fitness_center,
                  size: 60,
                  color: Appcolor.backgroundColor,
                ),
              ),
              const SizedBox(height: 20),

              // NOMBRE EMPRESA
              const Text(
                "SolarteArnauda",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Appcolor.backgroundColor,
                ),
              ),
              const Text(
                "Suplementos Deportivos",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // INFORMACIÓN
              _buildContactInfo(Icons.email, "info@solartearnuda.com"),
              const SizedBox(height: 15),
              _buildContactInfo(Icons.phone, "+34 123 456 789"),
              const SizedBox(height: 15),
              _buildContactInfo(
                Icons.location_on,
                "Calle Principal 123, Madrid",
              ),
              const SizedBox(height: 15),
              _buildContactInfo(Icons.schedule, "Lunes - Viernes 9:00-18:00"),
              const SizedBox(height: 40),

              // DESCRIPCIÓN
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Appcolor.backgroundColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "SolarteArnauda es tu aliado en nutrición deportiva. "
                  "Con más de 10 años de experiencia, ofrecemos suplementos "
                  "de calidad para ayudarte a alcanzar tus objetivos fitness.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, height: 1.6),
                ),
              ),
              const SizedBox(height: 40),

              // BOTÓN VOLVER
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.backgroundColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: Text(
                  l10n.back,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Appcolor.backgroundColor, size: 22),
        const SizedBox(width: 15),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
