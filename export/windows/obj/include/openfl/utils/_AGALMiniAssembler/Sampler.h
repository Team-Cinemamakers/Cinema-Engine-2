// Generated by Haxe 4.3.6
#ifndef INCLUDED_openfl_utils__AGALMiniAssembler_Sampler
#define INCLUDED_openfl_utils__AGALMiniAssembler_Sampler

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS3(openfl,utils,_AGALMiniAssembler,Sampler)

namespace openfl{
namespace utils{
namespace _AGALMiniAssembler{


class HXCPP_CLASS_ATTRIBUTES Sampler_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef Sampler_obj OBJ_;
		Sampler_obj();

	public:
		enum { _hx_ClassId = 0x313f9cb2 };

		void __construct(::String name,int flag,int mask);
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="openfl.utils._AGALMiniAssembler.Sampler")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"openfl.utils._AGALMiniAssembler.Sampler"); }
		static ::hx::ObjectPtr< Sampler_obj > __new(::String name,int flag,int mask);
		static ::hx::ObjectPtr< Sampler_obj > __alloc(::hx::Ctx *_hx_ctx,::String name,int flag,int mask);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~Sampler_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("Sampler",e8,ec,1a,51); }

		static void __boot();
		static  ::Dynamic __meta__;
		int flag;
		int mask;
		::String name;
		virtual ::String toString();
		::Dynamic toString_dyn();

};

} // end namespace openfl
} // end namespace utils
} // end namespace _AGALMiniAssembler

#endif /* INCLUDED_openfl_utils__AGALMiniAssembler_Sampler */ 
