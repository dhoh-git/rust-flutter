import 'custom_email_dropdown.dart';
import 'package:flutter/material.dart';

class CustomTextFieldDropdownPage extends StatefulWidget {
  const CustomTextFieldDropdownPage({Key? key}) : super(key: key);

  @override
  State<CustomTextFieldDropdownPage> createState() => _CustomTextFieldDropdownPageState();
}

class _CustomTextFieldDropdownPageState extends State<CustomTextFieldDropdownPage> {
  // 이메일.
  late TextEditingController _emailController;
  late FocusNode _emailFocusNode;
  OverlayEntry? _overlayEntry; // 이메일 자동 추천 드롭 박스.
  final LayerLink _layerLink = LayerLink();

  // 이메일 드롭박스 해제.
  void _removeEmailOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode()
      ..addListener(() {
        //if (_emailFocusNode.hasFocus) {
          //debugPrint("focusnode called!! hasfocus");
          //이것때문에 오버레이 클릭 시 닫혀버린다. _removeEmailOverlay();
          //_removeEmailOverlay();
          //_showEmailOverlay()
        //}
        //else {
          //debugPrint("focusnode called!! not hasfocus");
          //_removeEmailOverlay();
        //}
      });
    debugPrint("dropdown init() called!!");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _overlayEntry?.dispose();
    _emailFocusNode.dispose();
    super.dispose();
    debugPrint("dropdown dispose() called!!");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //debugPrint("dropdown ontap() called!!");
        final _currentFocus = FocusScope.of(context);
        if (!_currentFocus.hasPrimaryFocus) {
          debugPrint("dropdown ontap() not hasprimaryfocus");
          //_currentFocus.unfocus();
        }
        else {
          debugPrint("dropdown ontap() hasprimaryfocus");
        }
        _removeEmailOverlay();
      },
      child: Scaffold(
        body: Center(
          child: _emailTextField(),
        ),
      ),
    );
  }

  // 이메일 입력창.
  Widget _emailTextField() {
    // 테두리 스타일.
    final _border = OutlineInputBorder(
      borderSide: BorderSide(
        color: (_emailFocusNode.hasFocus) ? Colors.black : Colors.grey,
      ),
      borderRadius: BorderRadius.circular(5),
    );

    // 이메일 자동 입력 드롭박스 출력.
    void _showEmailOverlay() { //onChanged()
      // 이메일 자동 입력 드롭박스.
      if (_emailFocusNode.hasFocus) {
        if (_emailController.text.isNotEmpty) {
          final _email = _emailController.text;
          debugPrint("email text = $_email");
          // 이메일 자동 입력 드롭박스 출력.
          if (!_email.contains('@')) {
            if (_overlayEntry == null) {
              _overlayEntry = _emailListOverlayEntry(width : context.size?.width);
              Overlay.of(context).insert(_overlayEntry!);
            }
            //else{
              _overlayEntry?.markNeedsBuild();
            //}
          }
          // 이메일 자동 입력 드롭박스 해제.
          else {
            _removeEmailOverlay();
          }
        } else {
          _removeEmailOverlay();
        }
      }
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 48,
          child: TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(fontSize: 16),
            onTap: () => _showEmailOverlay(),  // 진입했을때도 오버레이 노출
            onChanged: (_) => _showEmailOverlay(),
            decoration: InputDecoration(
              // 여백.
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),

              // 테두리.
              border: _border,
              disabledBorder: _border,
              enabledBorder: _border,
              errorBorder: _border,
              focusedBorder: _border,
              focusedErrorBorder: _border,

              // 카운터.
              counter: null,
              counterText: '',

              // 힌트 메세지.
              hintText: 'abc@email.com',
              hintStyle: const TextStyle(
                fontSize: 16,
                height: 22 / 16,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 이메일 자동 입력창.
  OverlayEntry _emailListOverlayEntry({required width}) {
    return customDropdown.emailRecommendation(
      //width: MediaQuery.of(context).size.width,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      layerLink: _layerLink,
      controller: _emailController,
      onPressed: () {
        setState(() {
          _emailFocusNode.unfocus();
          _removeEmailOverlay();
        });
      },
    );
  }
}
