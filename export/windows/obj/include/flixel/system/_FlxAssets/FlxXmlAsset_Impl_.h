// Generated by Haxe 4.3.6
#ifndef INCLUDED_flixel_system__FlxAssets_FlxXmlAsset_Impl_
#define INCLUDED_flixel_system__FlxAssets_FlxXmlAsset_Impl_

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(Xml)
HX_DECLARE_CLASS3(flixel,_hx_system,_FlxAssets,FlxXmlAsset_Impl_)

namespace flixel{
namespace _hx_system{
namespace _FlxAssets{


class HXCPP_CLASS_ATTRIBUTES FlxXmlAsset_Impl__obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef FlxXmlAsset_Impl__obj OBJ_;
		FlxXmlAsset_Impl__obj();

	public:
		enum { _hx_ClassId = 0x0b3e938a };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="flixel.system._FlxAssets.FlxXmlAsset_Impl_")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"flixel.system._FlxAssets.FlxXmlAsset_Impl_"); }

		inline static ::hx::ObjectPtr< FlxXmlAsset_Impl__obj > __new() {
			::hx::ObjectPtr< FlxXmlAsset_Impl__obj > __this = new FlxXmlAsset_Impl__obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< FlxXmlAsset_Impl__obj > __alloc(::hx::Ctx *_hx_ctx) {
			FlxXmlAsset_Impl__obj *__this = (FlxXmlAsset_Impl__obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(FlxXmlAsset_Impl__obj), false, "flixel.system._FlxAssets.FlxXmlAsset_Impl_"));
			*(void **)__this = FlxXmlAsset_Impl__obj::_hx_vtable;
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~FlxXmlAsset_Impl__obj();

		HX_DO_RTTI_ALL;
		static bool __GetStatic(const ::String &inString, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("FlxXmlAsset_Impl_",eb,51,c5,99); }

		static  ::Xml getXml( ::Dynamic this1);
		static ::Dynamic getXml_dyn();

		static  ::Xml fromPath(::String path);
		static ::Dynamic fromPath_dyn();

		static  ::Xml fromXmlString(::String data);
		static ::Dynamic fromXmlString_dyn();

};

} // end namespace flixel
} // end namespace system
} // end namespace _FlxAssets

#endif /* INCLUDED_flixel_system__FlxAssets_FlxXmlAsset_Impl_ */ 
