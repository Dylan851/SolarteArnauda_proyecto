import 'package:flutter/material.dart';
import 'package:flutter_application/config/utils/lenguage.dart';
import 'package:flutter_application/locale_bloc/locale_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildLanguageDropdown() {
  return BlocBuilder<LocaleBloc, LocaleState>(
    builder: (context, state) {
      return DropdownButtonHideUnderline(
        child: DropdownButton<Language>(
          value: state.selectedLanguage,
          iconEnabledColor: Colors.white,
          dropdownColor: Colors.white,
          items: const [
            DropdownMenuItem(
              value: Language.english,
              child: Text('EN'),
            ),
            DropdownMenuItem(
              value: Language.spanish,
              child: Text('ES'),
            ),
          ],
          onChanged: (lang) {
            if (lang != null) {
              context.read<LocaleBloc>().add(ChangeLanguage(lang));
            }
          },
        ),
      );
    },
  );
}