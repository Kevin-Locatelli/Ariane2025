import 'package:flutter/material.dart';
import 'package:ariane_app/constants.dart'; // Import the constants file

class ParametrePage extends StatefulWidget {
  @override
  _ParametrePageState createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  double _musiqueVolume = 0.9;
  double _effetsSonoresVolume = 0.4;
  String _selectedLanguage = 'Français';

  final List<String> _languages = [
    'Français',
    'English',
    'Español',
    'Deutsch',
    'Italiano',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kCardColor,
        elevation: kElevation,
        shadowColor: Colors.black.withOpacity(0.1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: kIconSize),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            // Red panda mascot
            SizedBox(
              width: kMascotSize,
              height: kMascotSize,
              child: Image.asset(
                'assets/red_panda.png', // Replace with your red panda asset
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: kSizedBoxWidthMedium),
            Text(
              'Paramètre',
              style: TextStyle(
                color: Colors.black,
                fontSize: kFontSizeLarge,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        toolbarHeight: kAppBarHeight,
      ),
      body: Padding(
        padding: EdgeInsets.all(kPaddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAudioSection(),
            SizedBox(height: kSizedBoxHeightLarge),
            _buildSystemSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioSection() {
    return _buildSectionContainer(
      title: 'Audio',
      children: [
        _buildSliderContainer(
          label: 'Musique',
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
          label: 'Effets sonores',
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

  Widget _buildSystemSection() {
    return _buildSectionContainer(
      title: 'Système',
      children: [
        _buildLanguageDropdown(),
      ],
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(kPaddingExtraLarge),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
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
              color: kInactiveColor,
            ),
          ),
          SizedBox(height: kSizedBoxHeightLarge),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSliderContainer({
    required String label,
    required IconData icon,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(kPaddingLarge),
      decoration: BoxDecoration(
        color: kLightGreyColor,
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
                  color: kInactiveColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: kSizedBoxWidthSmall),
              Icon(
                icon,
                color: Colors.black54,
                size: kIconSize - 6, // Adjusted size for consistency
              ),
            ],
          ),
          SizedBox(height: kSizedBoxHeightMedium),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: kPrimaryColor,
              inactiveTrackColor: kBorderColor,
              thumbColor: kCardColor,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: kThumbRadius),
              overlayColor: kPrimaryColor.withOpacity(0.2),
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

  Widget _buildLanguageDropdown() {
    return Container(
      padding: EdgeInsets.all(kPaddingLarge),
      decoration: BoxDecoration(
        color: kLightGreyColor,
        borderRadius: BorderRadius.circular(kSmallBorderRadius),
        border: Border.all(color: kBorderColor, width: 0.5),
      ),
      child: Row(
        children: [
          Text(
            'Langue :',
            style: TextStyle(
              fontSize: kFontSizeSmall,
              color: kInactiveColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: kSizedBoxWidthLarge),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kPaddingMedium, vertical: kPaddingSmall),
            decoration: BoxDecoration(
              color: kCardColor,
              borderRadius: BorderRadius.circular(kTinyBorderRadius),
              border: Border.all(color: kDropdownBorderColor),
            ),
            child: DropdownButton<String>(
              value: _selectedLanguage,
              underline: SizedBox(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: kInactiveColor,
                size: kIconSize,
              ),
              style: TextStyle(
                color: kInactiveColor,
                fontSize: kFontSizeSmall,
                fontWeight: FontWeight.w400,
              ),
              items: _languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
