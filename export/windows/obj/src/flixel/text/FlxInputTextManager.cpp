// Generated by Haxe 4.3.6
#include <hxcpp.h>

#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
#endif
#ifndef INCLUDED_flixel_text_FlxInputTextManager
#include <flixel/text/FlxInputTextManager.h>
#endif
#ifndef INCLUDED_flixel_text_IFlxInputText
#include <flixel/text/IFlxInputText.h>
#endif
#ifndef INCLUDED_flixel_text_MoveCursorAction
#include <flixel/text/MoveCursorAction.h>
#endif
#ifndef INCLUDED_flixel_text_TypingAction
#include <flixel/text/TypingAction.h>
#endif
#ifndef INCLUDED_flixel_text_TypingCommand
#include <flixel/text/TypingCommand.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxDestroyable
#include <flixel/util/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxSignal
#include <flixel/util/IFlxSignal.h>
#endif
#ifndef INCLUDED_flixel_util__FlxSignal_FlxBaseSignal
#include <flixel/util/_FlxSignal/FlxBaseSignal.h>
#endif
#ifndef INCLUDED_flixel_util__FlxSignal_FlxSignal1
#include <flixel/util/_FlxSignal/FlxSignal1.h>
#endif
#ifndef INCLUDED_lime__internal_backend_native_NativeWindow
#include <lime/_internal/backend/native/NativeWindow.h>
#endif
#ifndef INCLUDED_lime_app_IModule
#include <lime/app/IModule.h>
#endif
#ifndef INCLUDED_lime_app__Event_lime_ui_KeyCode_lime_ui_KeyModifier_Void
#include <lime/app/_Event_lime_ui_KeyCode_lime_ui_KeyModifier_Void.h>
#endif
#ifndef INCLUDED_lime_ui_Window
#include <lime/ui/Window.h>
#endif
#ifndef INCLUDED_lime_ui__KeyModifier_KeyModifier_Impl_
#include <lime/ui/_KeyModifier/KeyModifier_Impl_.h>
#endif
#ifndef INCLUDED_openfl_Lib
#include <openfl/Lib.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObject
#include <openfl/display/DisplayObject.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObjectContainer
#include <openfl/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_openfl_display_IBitmapDrawable
#include <openfl/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_openfl_display_InteractiveObject
#include <openfl/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_openfl_display_MovieClip
#include <openfl/display/MovieClip.h>
#endif
#ifndef INCLUDED_openfl_display_Sprite
#include <openfl/display/Sprite.h>
#endif
#ifndef INCLUDED_openfl_display_Stage
#include <openfl/display/Stage.h>
#endif
#ifndef INCLUDED_openfl_events_Event
#include <openfl/events/Event.h>
#endif
#ifndef INCLUDED_openfl_events_EventDispatcher
#include <openfl/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_IEventDispatcher
#include <openfl/events/IEventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_TextEvent
#include <openfl/events/TextEvent.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_13_new,"flixel.text.FlxInputTextManager","new",0x67b2214b,"flixel.text.FlxInputTextManager.new","flixel/text/FlxInputTextManager.hx",13,0x35d474e5)
HX_LOCAL_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_57_destroy,"flixel.text.FlxInputTextManager","destroy",0xf076cf65,"flixel.text.FlxInputTextManager.destroy","flixel/text/FlxInputTextManager.hx",57,0x35d474e5)
HX_LOCAL_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_66_addEvents,"flixel.text.FlxInputTextManager","addEvents",0x71bcd745,"flixel.text.FlxInputTextManager.addEvents","flixel/text/FlxInputTextManager.hx",66,0x35d474e5)
HX_LOCAL_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_82_removeEvents,"flixel.text.FlxInputTextManager","removeEvents",0x8c4ba432,"flixel.text.FlxInputTextManager.removeEvents","flixel/text/FlxInputTextManager.hx",82,0x35d474e5)
HX_LOCAL_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_100_registerInputText,"flixel.text.FlxInputTextManager","registerInputText",0xb4c5551f,"flixel.text.FlxInputTextManager.registerInputText","flixel/text/FlxInputTextManager.hx",100,0x35d474e5)
HX_LOCAL_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_117_unregisterInputText,"flixel.text.FlxInputTextManager","unregisterInputText",0x20ba5b66,"flixel.text.FlxInputTextManager.unregisterInputText","flixel/text/FlxInputTextManager.hx",117,0x35d474e5)
HX_LOCAL_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_130_setFocus,"flixel.text.FlxInputTextManager","setFocus",0xb95b440b,"flixel.text.FlxInputTextManager.setFocus","flixel/text/FlxInputTextManager.hx",130,0x35d474e5)
HX_LOCAL_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_152_onTextInput,"flixel.text.FlxInputTextManager","onTextInput",0x8317eae9,"flixel.text.FlxInputTextManager.onTextInput","flixel/text/FlxInputTextManager.hx",152,0x35d474e5)
HX_LOCAL_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_164_dispatchTypingAction,"flixel.text.FlxInputTextManager","dispatchTypingAction",0x8033a21c,"flixel.text.FlxInputTextManager.dispatchTypingAction","flixel/text/FlxInputTextManager.hx",164,0x35d474e5)
HX_LOCAL_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_173_onKeyDown,"flixel.text.FlxInputTextManager","onKeyDown",0x9720756d,"flixel.text.FlxInputTextManager.onKeyDown","flixel/text/FlxInputTextManager.hx",173,0x35d474e5)
HX_LOCAL_STACK_FRAME(_hx_pos_2d10bc6184b17ec4_311_get_isTyping,"flixel.text.FlxInputTextManager","get_isTyping",0xeb7107bf,"flixel.text.FlxInputTextManager.get_isTyping","flixel/text/FlxInputTextManager.hx",311,0x35d474e5)
namespace flixel{
namespace text{

void FlxInputTextManager_obj::__construct(){
            	HX_GC_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_13_new)
HXLINE(  38)		this->_mac = false;
HXLINE(  33)		this->_registeredInputTexts = ::Array_obj< ::Dynamic>::__new();
HXLINE(  28)		this->onTypingAction =  ::flixel::util::_FlxSignal::FlxSignal1_obj::__alloc( HX_CTX );
HXLINE(  50)		super::__construct();
            	}

Dynamic FlxInputTextManager_obj::__CreateEmpty() { return new FlxInputTextManager_obj; }

void *FlxInputTextManager_obj::_hx_vtable = 0;

Dynamic FlxInputTextManager_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< FlxInputTextManager_obj > _hx_result = new FlxInputTextManager_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool FlxInputTextManager_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x596f56df) {
		return inClassId==(int)0x00000001 || inClassId==(int)0x596f56df;
	} else {
		return inClassId==(int)0x7ccf8994;
	}
}

void FlxInputTextManager_obj::destroy(){
            	HX_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_57_destroy)
HXLINE(  58)		this->super::destroy();
HXLINE(  60)		this->focus = null();
HXLINE(  61)		this->_registeredInputTexts->resize(0);
HXLINE(  62)		this->removeEvents();
            	}


void FlxInputTextManager_obj::addEvents(){
            	HX_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_66_addEvents)
HXLINE(  68)		::openfl::Lib_obj::get_current()->stage->addEventListener(HX_("textInput",1d,54,0b,57),this->onTextInput_dyn(),null(),null(),null());
HXLINE(  71)		::openfl::Lib_obj::get_current()->stage->window->onKeyDown->add(this->onKeyDown_dyn(),false,1000);
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxInputTextManager_obj,addEvents,(void))

void FlxInputTextManager_obj::removeEvents(){
            	HX_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_82_removeEvents)
HXLINE(  83)		::openfl::Lib_obj::get_current()->stage->removeEventListener(HX_("textInput",1d,54,0b,57),this->onTextInput_dyn(),null());
HXLINE(  84)		::openfl::Lib_obj::get_current()->stage->window->onKeyDown->remove(this->onKeyDown_dyn());
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxInputTextManager_obj,removeEvents,(void))

void FlxInputTextManager_obj::registerInputText(::Dynamic input){
            	HX_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_100_registerInputText)
HXDLIN( 100)		if (!(this->_registeredInputTexts->contains(input))) {
HXLINE( 102)			this->_registeredInputTexts->push(input);
HXLINE( 104)			if (!(::openfl::Lib_obj::get_current()->stage->window->onKeyDown->has(this->onKeyDown_dyn()))) {
HXLINE( 106)				this->addEvents();
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxInputTextManager_obj,registerInputText,(void))

void FlxInputTextManager_obj::unregisterInputText(::Dynamic input){
            	HX_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_117_unregisterInputText)
HXDLIN( 117)		if (this->_registeredInputTexts->contains(input)) {
HXLINE( 119)			this->_registeredInputTexts->remove(input);
HXLINE( 121)			bool _hx_tmp;
HXDLIN( 121)			if ((this->_registeredInputTexts->length == 0)) {
HXLINE( 121)				_hx_tmp = ::openfl::Lib_obj::get_current()->stage->window->onKeyDown->has(this->onKeyDown_dyn());
            			}
            			else {
HXLINE( 121)				_hx_tmp = false;
            			}
HXDLIN( 121)			if (_hx_tmp) {
HXLINE( 123)				this->removeEvents();
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxInputTextManager_obj,unregisterInputText,(void))

void FlxInputTextManager_obj::setFocus(::Dynamic value){
            	HX_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_130_setFocus)
HXDLIN( 130)		if (::hx::IsInstanceNotEq( this->focus,value )) {
HXLINE( 132)			if (::hx::IsNotNull( this->focus )) {
HXLINE( 134)				::flixel::text::IFlxInputText_obj::endFocus(this->focus);
            			}
HXLINE( 137)			this->focus = value;
HXLINE( 139)			if (::hx::IsNotNull( this->focus )) {
HXLINE( 141)				::flixel::text::IFlxInputText_obj::startFocus(this->focus);
            			}
HXLINE( 144)			{
HXLINE( 144)				 ::lime::ui::Window _this = ::openfl::Lib_obj::get_current()->stage->window;
HXDLIN( 144)				_this->_hx___backend->setTextInputEnabled(::hx::IsNotNull( this->focus ));
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxInputTextManager_obj,setFocus,(void))

void FlxInputTextManager_obj::onTextInput( ::openfl::events::TextEvent event){
            	HX_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_152_onTextInput)
HXLINE( 154)		bool _hx_tmp;
HXDLIN( 154)		if ((event->text.length == 1)) {
HXLINE( 154)			_hx_tmp = ::hx::IsEq( event->text.charCodeAt(0),13 );
            		}
            		else {
HXLINE( 154)			_hx_tmp = false;
            		}
HXDLIN( 154)		if (_hx_tmp) {
HXLINE( 155)			return;
            		}
HXLINE( 157)		if (::hx::IsNotNull( this->focus )) {
HXLINE( 159)			this->dispatchTypingAction(::flixel::text::TypingAction_obj::ADD_TEXT(event->text));
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxInputTextManager_obj,onTextInput,(void))

void FlxInputTextManager_obj::dispatchTypingAction( ::flixel::text::TypingAction action){
            	HX_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_164_dispatchTypingAction)
HXLINE( 165)		::flixel::text::IFlxInputText_obj::dispatchTypingAction(this->focus,action);
HXLINE( 166)		this->onTypingAction->dispatch(action);
            	}


HX_DEFINE_DYNAMIC_FUNC1(FlxInputTextManager_obj,dispatchTypingAction,(void))

void FlxInputTextManager_obj::onKeyDown(int key,int modifier){
            	HX_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_173_onKeyDown)
HXLINE( 174)		if (::hx::IsNull( this->focus )) {
HXLINE( 175)			return;
            		}
HXLINE( 184)		bool commandPressed;
HXDLIN( 184)		if (this->_mac) {
HXLINE( 184)			commandPressed = ::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_metaKey(modifier);
            		}
            		else {
HXLINE( 184)			commandPressed = ::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_ctrlKey(modifier);
            		}
HXLINE( 187)		bool wordModPressed = ::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_altKey(modifier);
HXLINE( 190)		bool lineModPressed = commandPressed;
HXLINE( 192)		switch((int)(key)){
            			case (int)8: {
HXLINE( 197)				this->dispatchTypingAction(::flixel::text::TypingAction_obj::COMMAND(::flixel::text::TypingCommand_obj::DELETE_LEFT_dyn()));
            			}
            			break;
            			case (int)97: {
HXLINE( 236)				if (commandPressed) {
HXLINE( 237)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::COMMAND(::flixel::text::TypingCommand_obj::SELECT_ALL_dyn()));
            				}
            			}
            			break;
            			case (int)99: {
HXLINE( 228)				if (commandPressed) {
HXLINE( 229)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::COMMAND(::flixel::text::TypingCommand_obj::COPY_dyn()));
            				}
            			}
            			break;
            			case (int)118: {
HXLINE( 233)				if (commandPressed) {
HXLINE( 234)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::COMMAND(::flixel::text::TypingCommand_obj::PASTE_dyn()));
            				}
            			}
            			break;
            			case (int)120: {
HXLINE( 230)				if (commandPressed) {
HXLINE( 231)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::COMMAND(::flixel::text::TypingCommand_obj::CUT_dyn()));
            				}
            			}
            			break;
            			case (int)127: {
HXLINE( 199)				this->dispatchTypingAction(::flixel::text::TypingAction_obj::COMMAND(::flixel::text::TypingCommand_obj::DELETE_RIGHT_dyn()));
            			}
            			break;
            			case (int)1073741898: {
HXLINE( 220)				bool _hx_tmp;
HXDLIN( 220)				if (!(this->_mac)) {
HXLINE( 220)					_hx_tmp = commandPressed;
            				}
            				else {
HXLINE( 220)					_hx_tmp = false;
            				}
HXDLIN( 220)				if (_hx_tmp) {
HXLINE( 221)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::TOP_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            				}
            				else {
HXLINE( 223)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::LINE_LEFT_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            				}
            			}
            			break;
            			case (int)1073741901: {
HXLINE( 224)				bool _hx_tmp1;
HXDLIN( 224)				if (!(this->_mac)) {
HXLINE( 224)					_hx_tmp1 = commandPressed;
            				}
            				else {
HXLINE( 224)					_hx_tmp1 = false;
            				}
HXDLIN( 224)				if (_hx_tmp1) {
HXLINE( 225)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::BOTTOM_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            				}
            				else {
HXLINE( 227)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::LINE_RIGHT_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            				}
            			}
            			break;
            			case (int)1073741903: {
HXLINE( 206)				if (lineModPressed) {
HXLINE( 207)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::LINE_RIGHT_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            				}
            				else {
HXLINE( 208)					if (wordModPressed) {
HXLINE( 209)						this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::WORD_RIGHT_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            					}
            					else {
HXLINE( 211)						this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::RIGHT_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            					}
            				}
            			}
            			break;
            			case (int)1073741904: {
HXLINE( 200)				if (lineModPressed) {
HXLINE( 201)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::LINE_LEFT_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            				}
            				else {
HXLINE( 202)					if (wordModPressed) {
HXLINE( 203)						this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::WORD_LEFT_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            					}
            					else {
HXLINE( 205)						this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::LEFT_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            					}
            				}
            			}
            			break;
            			case (int)1073741905: {
HXLINE( 216)				bool _hx_tmp2;
HXDLIN( 216)				if (this->_mac) {
HXLINE( 216)					_hx_tmp2 = commandPressed;
            				}
            				else {
HXLINE( 216)					_hx_tmp2 = false;
            				}
HXDLIN( 216)				if (_hx_tmp2) {
HXLINE( 217)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::BOTTOM_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            				}
            				else {
HXLINE( 219)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::DOWN_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            				}
            			}
            			break;
            			case (int)1073741906: {
HXLINE( 212)				bool _hx_tmp3;
HXDLIN( 212)				if (this->_mac) {
HXLINE( 212)					_hx_tmp3 = commandPressed;
            				}
            				else {
HXLINE( 212)					_hx_tmp3 = false;
            				}
HXDLIN( 212)				if (_hx_tmp3) {
HXLINE( 213)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::TOP_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            				}
            				else {
HXLINE( 215)					this->dispatchTypingAction(::flixel::text::TypingAction_obj::MOVE_CURSOR(::flixel::text::MoveCursorAction_obj::UP_dyn(),::lime::ui::_KeyModifier::KeyModifier_Impl__obj::get_shiftKey(modifier)));
            				}
            			}
            			break;
            			case (int)13: case (int)1073741912: {
HXLINE( 195)				this->dispatchTypingAction(::flixel::text::TypingAction_obj::COMMAND(::flixel::text::TypingCommand_obj::NEW_LINE_dyn()));
            			}
            			break;
            			default:{
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC2(FlxInputTextManager_obj,onKeyDown,(void))

bool FlxInputTextManager_obj::get_isTyping(){
            	HX_STACKFRAME(&_hx_pos_2d10bc6184b17ec4_311_get_isTyping)
HXDLIN( 311)		if (::hx::IsNotNull( this->focus )) {
HXDLIN( 311)			return ( (bool)(this->focus->__Field(HX_("editable",a4,04,a6,d5),::hx::paccDynamic)) );
            		}
            		else {
HXDLIN( 311)			return false;
            		}
HXDLIN( 311)		return false;
            	}


HX_DEFINE_DYNAMIC_FUNC0(FlxInputTextManager_obj,get_isTyping,return )


::hx::ObjectPtr< FlxInputTextManager_obj > FlxInputTextManager_obj::__new() {
	::hx::ObjectPtr< FlxInputTextManager_obj > __this = new FlxInputTextManager_obj();
	__this->__construct();
	return __this;
}

::hx::ObjectPtr< FlxInputTextManager_obj > FlxInputTextManager_obj::__alloc(::hx::Ctx *_hx_ctx) {
	FlxInputTextManager_obj *__this = (FlxInputTextManager_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(FlxInputTextManager_obj), true, "flixel.text.FlxInputTextManager"));
	*(void **)__this = FlxInputTextManager_obj::_hx_vtable;
	__this->__construct();
	return __this;
}

FlxInputTextManager_obj::FlxInputTextManager_obj()
{
}

void FlxInputTextManager_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(FlxInputTextManager);
	HX_MARK_MEMBER_NAME(focus,"focus");
	HX_MARK_MEMBER_NAME(onTypingAction,"onTypingAction");
	HX_MARK_MEMBER_NAME(_registeredInputTexts,"_registeredInputTexts");
	HX_MARK_MEMBER_NAME(_mac,"_mac");
	 ::flixel::FlxBasic_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void FlxInputTextManager_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(focus,"focus");
	HX_VISIT_MEMBER_NAME(onTypingAction,"onTypingAction");
	HX_VISIT_MEMBER_NAME(_registeredInputTexts,"_registeredInputTexts");
	HX_VISIT_MEMBER_NAME(_mac,"_mac");
	 ::flixel::FlxBasic_obj::__Visit(HX_VISIT_ARG);
}

::hx::Val FlxInputTextManager_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"_mac") ) { return ::hx::Val( _mac ); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"focus") ) { return ::hx::Val( focus ); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"destroy") ) { return ::hx::Val( destroy_dyn() ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"isTyping") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_isTyping() ); }
		if (HX_FIELD_EQ(inName,"setFocus") ) { return ::hx::Val( setFocus_dyn() ); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"addEvents") ) { return ::hx::Val( addEvents_dyn() ); }
		if (HX_FIELD_EQ(inName,"onKeyDown") ) { return ::hx::Val( onKeyDown_dyn() ); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"onTextInput") ) { return ::hx::Val( onTextInput_dyn() ); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"removeEvents") ) { return ::hx::Val( removeEvents_dyn() ); }
		if (HX_FIELD_EQ(inName,"get_isTyping") ) { return ::hx::Val( get_isTyping_dyn() ); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"onTypingAction") ) { return ::hx::Val( onTypingAction ); }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"registerInputText") ) { return ::hx::Val( registerInputText_dyn() ); }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"unregisterInputText") ) { return ::hx::Val( unregisterInputText_dyn() ); }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"dispatchTypingAction") ) { return ::hx::Val( dispatchTypingAction_dyn() ); }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"_registeredInputTexts") ) { return ::hx::Val( _registeredInputTexts ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val FlxInputTextManager_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"_mac") ) { _mac=inValue.Cast< bool >(); return inValue; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"focus") ) { focus=inValue.Cast< ::Dynamic >(); return inValue; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"onTypingAction") ) { onTypingAction=inValue.Cast<  ::flixel::util::_FlxSignal::FlxSignal1 >(); return inValue; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"_registeredInputTexts") ) { _registeredInputTexts=inValue.Cast< ::Array< ::Dynamic> >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void FlxInputTextManager_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("focus",d8,5f,89,04));
	outFields->push(HX_("isTyping",01,9a,a3,af));
	outFields->push(HX_("onTypingAction",4c,c1,10,1d));
	outFields->push(HX_("_registeredInputTexts",bd,74,79,c6));
	outFields->push(HX_("_mac",90,4f,1e,3f));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo FlxInputTextManager_obj_sMemberStorageInfo[] = {
	{::hx::fsObject /* ::Dynamic */ ,(int)offsetof(FlxInputTextManager_obj,focus),HX_("focus",d8,5f,89,04)},
	{::hx::fsObject /*  ::flixel::util::_FlxSignal::FlxSignal1 */ ,(int)offsetof(FlxInputTextManager_obj,onTypingAction),HX_("onTypingAction",4c,c1,10,1d)},
	{::hx::fsObject /* ::Array< ::Dynamic> */ ,(int)offsetof(FlxInputTextManager_obj,_registeredInputTexts),HX_("_registeredInputTexts",bd,74,79,c6)},
	{::hx::fsBool,(int)offsetof(FlxInputTextManager_obj,_mac),HX_("_mac",90,4f,1e,3f)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *FlxInputTextManager_obj_sStaticStorageInfo = 0;
#endif

static ::String FlxInputTextManager_obj_sMemberFields[] = {
	HX_("focus",d8,5f,89,04),
	HX_("onTypingAction",4c,c1,10,1d),
	HX_("_registeredInputTexts",bd,74,79,c6),
	HX_("_mac",90,4f,1e,3f),
	HX_("destroy",fa,2c,86,24),
	HX_("addEvents",1a,84,8e,4e),
	HX_("removeEvents",7d,ea,97,05),
	HX_("registerInputText",f4,5e,ff,ff),
	HX_("unregisterInputText",7b,44,ea,35),
	HX_("setFocus",d6,c8,bd,12),
	HX_("onTextInput",fe,36,4e,79),
	HX_("dispatchTypingAction",67,ab,ef,f4),
	HX_("onKeyDown",42,22,f2,73),
	HX_("get_isTyping",0a,4e,bd,64),
	::String(null()) };

::hx::Class FlxInputTextManager_obj::__mClass;

void FlxInputTextManager_obj::__register()
{
	FlxInputTextManager_obj _hx_dummy;
	FlxInputTextManager_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("flixel.text.FlxInputTextManager",d9,1f,87,1b);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(FlxInputTextManager_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< FlxInputTextManager_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = FlxInputTextManager_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = FlxInputTextManager_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace flixel
} // end namespace text
