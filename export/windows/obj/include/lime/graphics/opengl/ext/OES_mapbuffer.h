// Generated by Haxe 4.3.6
#ifndef INCLUDED_lime_graphics_opengl_ext_OES_mapbuffer
#define INCLUDED_lime_graphics_opengl_ext_OES_mapbuffer

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_STACK_FRAME(_hx_pos_c25d4af8f239f11a_4_new)
HX_DECLARE_CLASS4(lime,graphics,opengl,ext,OES_mapbuffer)

namespace lime{
namespace graphics{
namespace opengl{
namespace ext{


class HXCPP_CLASS_ATTRIBUTES OES_mapbuffer_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef OES_mapbuffer_obj OBJ_;
		OES_mapbuffer_obj();

	public:
		enum { _hx_ClassId = 0x404f464c };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="lime.graphics.opengl.ext.OES_mapbuffer")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"lime.graphics.opengl.ext.OES_mapbuffer"); }

		inline static ::hx::ObjectPtr< OES_mapbuffer_obj > __new() {
			::hx::ObjectPtr< OES_mapbuffer_obj > __this = new OES_mapbuffer_obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< OES_mapbuffer_obj > __alloc(::hx::Ctx *_hx_ctx) {
			OES_mapbuffer_obj *__this = (OES_mapbuffer_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(OES_mapbuffer_obj), false, "lime.graphics.opengl.ext.OES_mapbuffer"));
			*(void **)__this = OES_mapbuffer_obj::_hx_vtable;
{
            	HX_STACKFRAME(&_hx_pos_c25d4af8f239f11a_4_new)
HXLINE(   9)		( ( ::lime::graphics::opengl::ext::OES_mapbuffer)(__this) )->BUFFER_MAP_POINTER_OES = 35005;
HXLINE(   8)		( ( ::lime::graphics::opengl::ext::OES_mapbuffer)(__this) )->BUFFER_MAPPED_OES = 35004;
HXLINE(   7)		( ( ::lime::graphics::opengl::ext::OES_mapbuffer)(__this) )->BUFFER_ACCESS_OES = 35003;
HXLINE(   6)		( ( ::lime::graphics::opengl::ext::OES_mapbuffer)(__this) )->WRITE_ONLY_OES = 35001;
            	}
		
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~OES_mapbuffer_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("OES_mapbuffer",1a,2d,9e,e1); }

		int WRITE_ONLY_OES;
		int BUFFER_ACCESS_OES;
		int BUFFER_MAPPED_OES;
		int BUFFER_MAP_POINTER_OES;
};

} // end namespace lime
} // end namespace graphics
} // end namespace opengl
} // end namespace ext

#endif /* INCLUDED_lime_graphics_opengl_ext_OES_mapbuffer */ 
