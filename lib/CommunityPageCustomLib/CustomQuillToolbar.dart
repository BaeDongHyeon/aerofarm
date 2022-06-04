import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'CustomFontSizeButton.dart';
import 'camera_button.dart';
import 'i18n_widget.dart';
import '../themeData.dart';

class CustomQuillToolbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomQuillToolbar({
    required this.children,
    this.toolbarHeight = 30,
    this.toolbarIconAlignment = WrapAlignment.center,
    this.toolbarSectionSpacing = 4,
    this.multiRowsDisplay = true,
    this.color,
    this.filePickImpl,
    this.customIcons = const [],
    this.locale,
    Key? key,
  }) : super(key: key);

  factory CustomQuillToolbar.basic({
    required quill.QuillController controller,
    required double toolbarHeight,
    double toolbarIconSize = quill.kDefaultIconSize,
    double toolbarSectionSpacing = 4,
    WrapAlignment toolbarIconAlignment = WrapAlignment.center,
    bool showDividers = true,
    bool showFontSize = true,
    bool showBoldButton = true,
    bool showItalicButton = true,
    bool showSmallButton = false,
    bool showUnderLineButton = true,
    bool showStrikeThrough = true,
    bool showInlineCode = true,
    bool showColorButton = true,
    bool showBackgroundColorButton = true,
    bool showClearFormat = true,
    bool showAlignmentButtons = false,
    bool showLeftAlignment = true,
    bool showCenterAlignment = true,
    bool showRightAlignment = true,
    bool showJustifyAlignment = true,
    bool showHeaderStyle = true,
    bool showListNumbers = true,
    bool showListBullets = true,
    bool showListCheck = true,
    bool showCodeBlock = true,
    bool showQuote = true,
    bool showIndent = true,
    bool showLink = true,
    bool showUndo = true,
    bool showRedo = true,
    bool multiRowsDisplay = true,
    bool showImageButton = true,
    bool showVideoButton = true,
    bool showCameraButton = true,
    bool showDirection = false,
    quill.OnImagePickCallback? onImagePickCallback,
    quill.OnVideoPickCallback? onVideoPickCallback,
    quill.MediaPickSettingSelector? mediaPickSettingSelector,
    quill.FilePickImpl? filePickImpl,
    quill.WebImagePickImpl? webImagePickImpl,
    quill.WebVideoPickImpl? webVideoPickImpl,
    List<quill.QuillCustomIcon> customIcons = const [],

    ///Map of font sizes in string
    Map<String, String>? fontSizeValues,

    ///The theme to use for the icons in the toolbar, uses type [QuillIconTheme]
    quill.QuillIconTheme? iconTheme,

    ///The theme to use for the theming of the [LinkDialog()],
    ///shown when embedding an image, for example
    quill.QuillDialogTheme? dialogTheme,

    /// The locale to use for the editor toolbar, defaults to system locale
    /// More at https://github.com/singerdmx/flutter-quill#translation
    Locale? locale,
    Key? key,
  }) {
    final isButtonGroupShown = [
      showFontSize ||
          showBoldButton ||
          showItalicButton ||
          showSmallButton ||
          showUnderLineButton ||
          showStrikeThrough ||
          showInlineCode ||
          showColorButton ||
          showBackgroundColorButton ||
          showClearFormat ||
          onImagePickCallback != null ||
          onVideoPickCallback != null,
      showAlignmentButtons || showDirection,
      showLeftAlignment,
      showCenterAlignment,
      showRightAlignment,
      showJustifyAlignment,
      showHeaderStyle,
      showListNumbers || showListBullets || showListCheck || showCodeBlock,
      showQuote || showIndent,
      showLink
    ];

    //default font size values
    final fontSizes = fontSizeValues ??
        {'Small': 'small', 'Large': 'large', 'Huge': 'huge', 'Clear': '0'};

    return CustomQuillToolbar(
      color: MainColor.six,
      key: key,
      toolbarHeight: toolbarHeight,
      toolbarSectionSpacing: toolbarSectionSpacing,
      toolbarIconAlignment: toolbarIconAlignment,
      multiRowsDisplay: multiRowsDisplay,
      customIcons: customIcons,
      locale: locale,
      children: [
        if (showUndo)
          quill.HistoryButton(
            icon: Icons.undo_outlined,
            iconSize: toolbarIconSize,
            controller: controller,
            undo: true,
            iconTheme: iconTheme,
          ),
        if (showRedo)
          quill.HistoryButton(
            icon: Icons.redo_outlined,
            iconSize: toolbarIconSize,
            controller: controller,
            undo: false,
            iconTheme: iconTheme,
          ),
        if (showFontSize)
          CustomQuillFontSizeButton(
            iconTheme: iconTheme,
            iconSize: toolbarIconSize,
            attribute: quill.Attribute.size,
            controller: controller,
            items: [
              for (MapEntry<String, String> fontSize in fontSizes.entries)
                PopupMenuItem<String>(
                  key: ValueKey(fontSize.key),
                  value: fontSize.value,
                  child: Text(fontSize.key.toString(),
                      style: TextStyle(
                          color: fontSize.value == '0' ? Colors.red : null)),
                ),
            ],
            onSelected: (newSize) {
              controller.formatSelection(quill.Attribute.fromKeyValue(
                  'size', newSize == '0' ? null : getFontSize(newSize)));
            },
            rawItemsMap: fontSizes,
          ),
        if (showBoldButton)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.bold,
            icon: Icons.format_bold,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showItalicButton)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.italic,
            icon: Icons.format_italic,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showSmallButton)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.small,
            icon: Icons.format_size,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showUnderLineButton)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.underline,
            icon: Icons.format_underline,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showStrikeThrough)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.strikeThrough,
            icon: Icons.format_strikethrough,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showInlineCode)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.inlineCode,
            icon: Icons.code,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showColorButton)
          quill.ColorButton(
            icon: Icons.color_lens,
            iconSize: toolbarIconSize,
            controller: controller,
            background: false,
            iconTheme: iconTheme,
          ),
        if (showBackgroundColorButton)
          quill.ColorButton(
            icon: Icons.format_color_fill,
            iconSize: toolbarIconSize,
            controller: controller,
            background: true,
            iconTheme: iconTheme,
          ),
        if (showClearFormat)
          quill.ClearFormatButton(
            icon: Icons.format_clear,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showImageButton)
          quill.ImageButton(
            icon: Icons.image,
            iconSize: toolbarIconSize,
            controller: controller,
            onImagePickCallback: onImagePickCallback,
            filePickImpl: filePickImpl,
            webImagePickImpl: webImagePickImpl,
            mediaPickSettingSelector: mediaPickSettingSelector,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          ),
        if (showVideoButton)
          quill.VideoButton(
            icon: Icons.movie_creation,
            iconSize: toolbarIconSize,
            controller: controller,
            onVideoPickCallback: onVideoPickCallback,
            filePickImpl: filePickImpl,
            webVideoPickImpl: webImagePickImpl,
            mediaPickSettingSelector: mediaPickSettingSelector,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          ),
        if ((onImagePickCallback != null || onVideoPickCallback != null) &&
            showCameraButton)
          CameraButton(
            icon: Icons.photo_camera,
            iconSize: toolbarIconSize,
            controller: controller,
            onImagePickCallback: onImagePickCallback,
            onVideoPickCallback: onVideoPickCallback,
            filePickImpl: filePickImpl,
            webImagePickImpl: webImagePickImpl,
            webVideoPickImpl: webVideoPickImpl,
            iconTheme: iconTheme,
          ),
        if (showDividers &&
            isButtonGroupShown[0] &&
            (isButtonGroupShown[1] ||
                isButtonGroupShown[2] ||
                isButtonGroupShown[3] ||
                isButtonGroupShown[4] ||
                isButtonGroupShown[5]))
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        if (showAlignmentButtons)
          quill.SelectAlignmentButton(
            controller: controller,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
            showLeftAlignment: showLeftAlignment,
            showCenterAlignment: showCenterAlignment,
            showRightAlignment: showRightAlignment,
            showJustifyAlignment: showJustifyAlignment,
          ),
        if (showDirection)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.rtl,
            controller: controller,
            icon: Icons.format_textdirection_r_to_l,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showDividers &&
            isButtonGroupShown[1] &&
            (isButtonGroupShown[2] ||
                isButtonGroupShown[3] ||
                isButtonGroupShown[4] ||
                isButtonGroupShown[5]))
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        if (showHeaderStyle)
          quill.SelectHeaderStyleButton(
            controller: controller,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showDividers &&
            showHeaderStyle &&
            isButtonGroupShown[2] &&
            (isButtonGroupShown[3] ||
                isButtonGroupShown[4] ||
                isButtonGroupShown[5]))
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        if (showListNumbers)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.ol,
            controller: controller,
            icon: Icons.format_list_numbered,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showListBullets)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.ul,
            controller: controller,
            icon: Icons.format_list_bulleted,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showListCheck)
          quill.ToggleCheckListButton(
            attribute: quill.Attribute.unchecked,
            controller: controller,
            icon: Icons.check_box,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showCodeBlock)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.codeBlock,
            controller: controller,
            icon: Icons.code,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showDividers &&
            isButtonGroupShown[3] &&
            (isButtonGroupShown[4] || isButtonGroupShown[5]))
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        if (showQuote)
          quill.ToggleStyleButton(
            attribute: quill.Attribute.blockQuote,
            controller: controller,
            icon: Icons.format_quote,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showIndent)
          quill.IndentButton(
            icon: Icons.format_indent_increase,
            iconSize: toolbarIconSize,
            controller: controller,
            isIncrease: true,
            iconTheme: iconTheme,
          ),
        if (showIndent)
          quill.IndentButton(
            icon: Icons.format_indent_decrease,
            iconSize: toolbarIconSize,
            controller: controller,
            isIncrease: false,
            iconTheme: iconTheme,
          ),
        if (showDividers && isButtonGroupShown[4] && isButtonGroupShown[5])
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        if (showLink)
          quill.LinkStyleButton(
            controller: controller,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          ),
        if (customIcons.isNotEmpty)
          if (showDividers)
            VerticalDivider(
              indent: 12,
              endIndent: 12,
              color: Colors.grey.shade400,
            ),
        for (var customIcon in customIcons)
          quill.QuillIconButton(
              highlightElevation: 0,
              hoverElevation: 0,
              size: toolbarIconSize * quill.kIconButtonFactor,
              icon: Icon(customIcon.icon, size: toolbarIconSize),
              borderRadius: iconTheme?.borderRadius ?? 2,
              onPressed: customIcon.onTap),
      ],
    );
  }

  final List<Widget> children;
  final double toolbarHeight;
  final double toolbarSectionSpacing;
  final WrapAlignment toolbarIconAlignment;
  final bool multiRowsDisplay;

  /// The color of the toolbar.
  ///
  /// Defaults to [ThemeData.canvasColor] of the current [Theme] if no color
  /// is given.
  final Color? color;

  final quill.FilePickImpl? filePickImpl;

  /// The locale to use for the editor toolbar, defaults to system locale
  /// More https://github.com/singerdmx/flutter-quill#translation
  final Locale? locale;

  /// List of custom icons
  final List<quill.QuillCustomIcon> customIcons;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return I18n(
      initialLocale: locale,
      child: multiRowsDisplay
          ? Wrap(
        alignment: toolbarIconAlignment,
        runSpacing: 4,
        spacing: toolbarSectionSpacing,
        children: children,
      )
          : Container(
        constraints:
        BoxConstraints.tightFor(height: preferredSize.height),
        color: color ?? Theme.of(context).canvasColor,
        child: ArrowIndicatedButtonList(buttons: children),
      ),
    );
  }
}

/// Scrollable list with arrow indicators.
///
/// The arrow indicators are automatically hidden if the list is not
/// scrollable in the direction of the respective arrow.
class ArrowIndicatedButtonList extends StatefulWidget {
  const ArrowIndicatedButtonList({required this.buttons, Key? key})
      : super(key: key);

  final List<Widget> buttons;

  @override
  _ArrowIndicatedButtonListState createState() =>
      _ArrowIndicatedButtonListState();
}

class _ArrowIndicatedButtonListState extends State<ArrowIndicatedButtonList>
    with WidgetsBindingObserver {
  final ScrollController _controller = ScrollController();
  bool _showLeftArrow = false;
  bool _showRightArrow = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleScroll);

    // Listening to the WidgetsBinding instance is necessary so that we can
    // hide the arrows when the window gets a new size and thus the toolbar
    // becomes scrollable/unscrollable.
    WidgetsBinding.instance.addObserver(this);

    // Workaround to allow the scroll controller attach to our ListView so that
    // we can detect if overflow arrows need to be shown on init.
    Timer.run(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildLeftArrow(),
        _buildScrollableList(),
        _buildRightColor(),
      ],
    );
  }

  @override
  void didChangeMetrics() => _handleScroll();

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _handleScroll() {
    if (!mounted) return;

    setState(() {
      _showLeftArrow =
          _controller.position.minScrollExtent != _controller.position.pixels;
      _showRightArrow =
          _controller.position.maxScrollExtent != _controller.position.pixels;
    });
  }

  Widget _buildLeftArrow() {
    return SizedBox(
      width: 8,
      child: Transform.translate(
        // Move the icon a few pixels to center it
        offset: const Offset(-5, 0),
        child: _showLeftArrow ? const Icon(Icons.arrow_left, size: 18) : null,
      ),
    );
  }

  Widget _buildScrollableList() {
    return Expanded(
      child: ScrollConfiguration(
        // Remove the glowing effect, as we already have the arrow indicators
        behavior: _NoGlowBehavior(),
        // The CustomScrollView is necessary so that the children are not
        // stretched to the height of the toolbar, https://bit.ly/3uC3bjI
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.buttons,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRightColor() {
    return SizedBox(
      width: 8,
      child: Transform.translate(
        // Move the icon a few pixels to center it
        offset: const Offset(-5, 0),
        child: _showRightArrow ? const Icon(Icons.arrow_right, size: 18) : null,
      ),
    );
  }
}

/// ScrollBehavior without the Material glow effect.
class _NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext _, Widget child, AxisDirection __) {
    return child;
  }
}



dynamic getFontSize(dynamic sizeValue) {
  if (sizeValue is String && ['small', 'large', 'huge'].contains(sizeValue)) {
    return sizeValue;
  }

  if (sizeValue is double) {
    return sizeValue;
  }

  if (sizeValue is int) {
    return sizeValue.toDouble();
  }

  assert(sizeValue is String);
  final fontSize = double.tryParse(sizeValue);
  if (fontSize == null) {
    throw 'Invalid size $sizeValue';
  }
  return fontSize;
}

