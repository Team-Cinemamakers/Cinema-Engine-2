// Generated by Haxe 4.3.6
#ifndef INCLUDED_funkinMain_states_MainMenu
#define INCLUDED_funkinMain_states_MainMenu

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
HX_DECLARE_CLASS2(flixel,group,FlxTypedContainer)
HX_DECLARE_CLASS2(flixel,group,FlxTypedGroup)
HX_DECLARE_CLASS2(flixel,util,IFlxDestroyable)
HX_DECLARE_CLASS2(funkinMain,states,MainMenu)

namespace funkinMain{
namespace states{


class HXCPP_CLASS_ATTRIBUTES MainMenu_obj : public  ::flixel::FlxState_obj
{
	public:
		typedef  ::flixel::FlxState_obj super;
		typedef MainMenu_obj OBJ_;
		MainMenu_obj();

	public:
		enum { _hx_ClassId = 0x20550a50 };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="funkinMain.states.MainMenu")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"funkinMain.states.MainMenu"); }
		static ::hx::ObjectPtr< MainMenu_obj > __new();
		static ::hx::ObjectPtr< MainMenu_obj > __alloc(::hx::Ctx *_hx_ctx);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~MainMenu_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("MainMenu",98,76,8d,7a); }

		 ::flixel::FlxSprite bg;
		void create();

		void update(Float elapsed);

};

} // end namespace funkinMain
} // end namespace states

#endif /* INCLUDED_funkinMain_states_MainMenu */ 
