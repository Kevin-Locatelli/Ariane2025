import 'package:ariane_app/providers/language_provider.dart';
import 'package:ariane_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:ariane_app/constants.dart';
import 'package:provider/provider.dart';

class ParametrePage extends StatefulWidget {
  const ParametrePage({super.key});

  @override
    ParametrePageState createState() => ParametrePageState();
}

class ParametrePageState extends State<ParametrePage> {
  double _musiqueVolume = 0.9;
  double _effetsSonoresVolume = 0.4;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    String selectedLanguage = languageProvider.currentLocale.languageCode == 'fr' ? 'Français' : 'English';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary, size: kIconSize),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          AppStrings.get(context, 'parametres'),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: kFontSizeLarge,
            fontWeight: FontWeight.w400,
          ),
        ),
        toolbarHeight: kAppBarHeight,
      ),
      body: Padding(
        padding: EdgeInsets.all(kPaddingLarge),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAudioSection(context),
              SizedBox(height: kSizedBoxHeightLarge),
              _buildSystemSection(context, _selectedLanguage),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAudioSection(BuildContext context) {
    return _buildSectionContainer(
      context: context,
      title: AppStrings.get(context, 'audio'),
      children: [
        _buildSliderContainer(
          context: context,
          label: AppStrings.get(context, 'musique'),
          icon: Icons.volume_up,
          value: _musiqueVolume,
          onChanged: (value) {
            setState(() {
              _musiqueVolume = value;
            });
          },
        ),
        SizedBox(height: kSizedBoxHeightMedium),
        _buildSliderContainer(
          context: context,
          label: AppStrings.get(context, 'effets_sonores'),
          icon: Icons.graphic_eq,
          value: _effetsSonoresVolume,
          onChanged: (value) {
            setState(() {
              _effetsSonoresVolume = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSystemSection(BuildContext context, String selectedLanguage) {
    return _buildSectionContainer(
      context: context,
      title: AppStrings.get(context, 'systeme'),
      children: [
        _buildLanguageDropdown(context, selectedLanguage),
      ],
    );
  }

  Widget _buildSectionContainer({
    required BuildContext context,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(kPaddingExtraLarge),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: kShadowColor,
            spreadRadius: kSpreadRadius,
            blurRadius: kBlurRadius,
            offset: Offset(kOffsetX, kOffsetY),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: kFontSizeMedium,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          SizedBox(height: kSizedBoxHeightLarge),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSliderContainer({
    required BuildContext context,
    required String label,
    required IconData icon,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(kPaddingLarge),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(kSmallBorderRadius),
        border: Border.all(color: kBorderColor, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: kFontSizeSmall,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: kSizedBoxWidthSmall),
              Icon(
                icon,
                color: kTextColorSecondary,
                size: kIconSize - 6,
              ),
            ],
          ),
          SizedBox(height: kSizedBoxHeightMedium),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: kBorderColor,
              thumbColor: Theme.of(context).cardColor,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: kThumbRadius),
              overlayColor: Theme.of(context).colorScheme.primary.withAlpha(51),
              overlayShape: RoundSliderOverlayShape(overlayRadius: kOverlayRadius),
              trackHeight: kTrackHeight,
            ),
            child: Slider(
              value: value,
              min: 0.0,
              max: 1.0,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context, String selectedLanguage) {
    return Container(
      padding: EdgeInsets.all(kPaddingLarge),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(kSmallBorderRadius),
        border: Border.all(color: kBorderColor, width: 0.5),
      ),
      child: Row(
        children: [
          Text(
            '${AppStrings.get(context, 'langue')} :',
            style: TextStyle(
              fontSize: kFontSizeSmall,
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: kSizedBoxWidthLarge),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kPaddingMedium, vertical: kPaddingSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(kTinyBorderRadius),
              border: Border.all(color: kBorderColor),
            ),
            child: DropdownButton<String>(
              value: selectedLanguage,
              underline: SizedBox(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: kTextColorSecondary,
                size: kIconSize,
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: kFontSizeSmall,
                fontWeight: FontWeight.w400,
              ),
              items: ['Français', 'English'].map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
                  if (newValue == 'English') {
                    languageProvider.setLocale(const Locale('en'));
                  } else {
                    languageProvider.setLocale(const Locale('fr'));
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
