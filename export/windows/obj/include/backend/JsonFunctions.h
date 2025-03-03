// Generated by Haxe 4.3.6
#ifndef INCLUDED_backend_JsonFunctions
#define INCLUDED_backend_JsonFunctions

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(backend,JsonFunctions)

namespace backend{


class HXCPP_CLASS_ATTRIBUTES JsonFunctions_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef JsonFunctions_obj OBJ_;
		JsonFunctions_obj();

	public:
		enum { _hx_ClassId = 0x78cac55f };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="backend.JsonFunctions")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"backend.JsonFunctions"); }

		inline static ::hx::ObjectPtr< JsonFunctions_obj > __new() {
			::hx::ObjectPtr< JsonFunctions_obj > __this = new JsonFunctions_obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< JsonFunctions_obj > __alloc(::hx::Ctx *_hx_ctx) {
			JsonFunctions_obj *__this = (JsonFunctions_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(JsonFunctions_obj), false, "backend.JsonFunctions"));
			*(void **)__this = JsonFunctions_obj::_hx_vtable;
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~JsonFunctions_obj();

		HX_DO_RTTI_ALL;
		static bool __GetStatic(const ::String &inString, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("JsonFunctions",f3,72,e8,88); }

		static ::String loadJson(::String jsonPath);
		static ::Dynamic loadJson_dyn();

};

} // end namespace backend

#endif /* INCLUDED_backend_JsonFunctions */ 
