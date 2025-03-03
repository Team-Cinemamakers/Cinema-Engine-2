// Generated by Haxe 4.3.6
#ifndef INCLUDED_flixel_input_gamepad_id__LogitechID_LogitechID_Impl_
#define INCLUDED_flixel_input_gamepad_id__LogitechID_LogitechID_Impl_

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS3(flixel,input,gamepad,FlxTypedGamepadAnalogStick)
HX_DECLARE_CLASS5(flixel,input,gamepad,id,_LogitechID,LogitechID_Impl_)

namespace flixel{
namespace input{
namespace gamepad{
namespace id{
namespace _LogitechID{


class HXCPP_CLASS_ATTRIBUTES LogitechID_Impl__obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef LogitechID_Impl__obj OBJ_;
		LogitechID_Impl__obj();

	public:
		enum { _hx_ClassId = 0x0bb8f89d };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="flixel.input.gamepad.id._LogitechID.LogitechID_Impl_")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"flixel.input.gamepad.id._LogitechID.LogitechID_Impl_"); }

		inline static ::hx::ObjectPtr< LogitechID_Impl__obj > __new() {
			::hx::ObjectPtr< LogitechID_Impl__obj > __this = new LogitechID_Impl__obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< LogitechID_Impl__obj > __alloc(::hx::Ctx *_hx_ctx) {
			LogitechID_Impl__obj *__this = (LogitechID_Impl__obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(LogitechID_Impl__obj), false, "flixel.input.gamepad.id._LogitechID.LogitechID_Impl_"));
			*(void **)__this = LogitechID_Impl__obj::_hx_vtable;
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~LogitechID_Impl__obj();

		HX_DO_RTTI_ALL;
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("LogitechID_Impl_",16,d2,12,04); }

		static void __boot();
		static int ONE;
		static int TWO;
		static int THREE;
		static int FOUR;
		static int FIVE;
		static int SIX;
		static int SEVEN;
		static int EIGHT;
		static int NINE;
		static int TEN;
		static int LEFT_STICK_CLICK;
		static int RIGHT_STICK_CLICK;
		static int DPAD_UP;
		static int DPAD_DOWN;
		static int DPAD_LEFT;
		static int DPAD_RIGHT;
		static int LOGITECH;
		static int LEFT_STICK_UP;
		static int LEFT_STICK_DOWN;
		static int LEFT_STICK_LEFT;
		static int LEFT_STICK_RIGHT;
		static int RIGHT_STICK_UP;
		static int RIGHT_STICK_DOWN;
		static int RIGHT_STICK_LEFT;
		static int RIGHT_STICK_RIGHT;
		static  ::flixel::input::gamepad::FlxTypedGamepadAnalogStick LEFT_ANALOG_STICK;
		static  ::flixel::input::gamepad::FlxTypedGamepadAnalogStick RIGHT_ANALOG_STICK;
};

} // end namespace flixel
} // end namespace input
} // end namespace gamepad
} // end namespace id
} // end namespace _LogitechID

#endif /* INCLUDED_flixel_input_gamepad_id__LogitechID_LogitechID_Impl_ */ 
