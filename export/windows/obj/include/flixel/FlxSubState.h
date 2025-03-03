// Generated by Haxe 4.3.6
#ifndef INCLUDED_flixel_FlxSubState
#define INCLUDED_flixel_FlxSubState

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifndef INCLUDED_flixel_FlxState
#include <flixel/FlxState.h>
#endif
HX_DECLARE_CLASS1(flixel,FlxBasic)
HX_DECLARE_CLASS1(flixel,FlxObject)
HX_DECLARE_CLASS1(flixel,FlxSprite)
HX_DECLARE_CLASS1(flixel,FlxState)
HX_DECLARE_CLASS1(flixel,FlxSubState)
HX_DECLARE_CLASS2(flixel,group,FlxTypedContainer)
HX_DECLARE_CLASS2(flixel,group,FlxTypedGroup)
HX_DECLARE_CLASS2(flixel,_hx_system,FlxBGSprite)
HX_DECLARE_CLASS2(flixel,util,IFlxDestroyable)

namespace flixel{


class HXCPP_CLASS_ATTRIBUTES FlxSubState_obj : public  ::flixel::FlxState_obj
{
	public:
		typedef  ::flixel::FlxState_obj super;
		typedef FlxSubState_obj OBJ_;
		FlxSubState_obj();

	public:
		enum { _hx_ClassId = 0x5661ffbf };

		void __construct(::hx::Null< int >  __o_bgColor);
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="flixel.FlxSubState")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"flixel.FlxSubState"); }
		static ::hx::ObjectPtr< FlxSubState_obj > __new(::hx::Null< int >  __o_bgColor);
		static ::hx::ObjectPtr< FlxSubState_obj > __alloc(::hx::Ctx *_hx_ctx,::hx::Null< int >  __o_bgColor);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~FlxSubState_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("FlxSubState",e3,a6,41,10); }

		 ::Dynamic openCallback;
		Dynamic openCallback_dyn() { return openCallback;}
		 ::Dynamic closeCallback;
		Dynamic closeCallback_dyn() { return closeCallback;}
		 ::flixel::_hx_system::FlxBGSprite _bgSprite;
		 ::flixel::FlxState _parentState;
		int _bgColor;
		bool _created;
		void draw();

		void destroy();

		void close();
		::Dynamic close_dyn();

		int get_bgColor();

		int set_bgColor(int value);

};

} // end namespace flixel

#endif /* INCLUDED_flixel_FlxSubState */ 
