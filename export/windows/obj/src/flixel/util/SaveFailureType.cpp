// Generated by Haxe 4.3.6
#include <hxcpp.h>

#ifndef INCLUDED_flixel_util_SaveFailureType
#include <flixel/util/SaveFailureType.h>
#endif
#ifndef INCLUDED_haxe_Exception
#include <haxe/Exception.h>
#endif
namespace flixel{
namespace util{

::flixel::util::SaveFailureType SaveFailureType_obj::ENCODING( ::haxe::Exception e)
{
	return ::hx::CreateEnum< SaveFailureType_obj >(HX_("ENCODING",d3,1c,de,89),1,1)->_hx_init(0,e);
}

::flixel::util::SaveFailureType SaveFailureType_obj::STORAGE;

bool SaveFailureType_obj::__GetStatic(const ::String &inName, ::Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	if (inName==HX_("ENCODING",d3,1c,de,89)) { outValue = SaveFailureType_obj::ENCODING_dyn(); return true; }
	if (inName==HX_("STORAGE",1b,b3,7c,c4)) { outValue = SaveFailureType_obj::STORAGE; return true; }
	return super::__GetStatic(inName, outValue, inCallProp);
}

HX_DEFINE_CREATE_ENUM(SaveFailureType_obj)

int SaveFailureType_obj::__FindIndex(::String inName)
{
	if (inName==HX_("ENCODING",d3,1c,de,89)) return 1;
	if (inName==HX_("STORAGE",1b,b3,7c,c4)) return 0;
	return super::__FindIndex(inName);
}

STATIC_HX_DEFINE_DYNAMIC_FUNC1(SaveFailureType_obj,ENCODING,return)

int SaveFailureType_obj::__FindArgCount(::String inName)
{
	if (inName==HX_("ENCODING",d3,1c,de,89)) return 1;
	if (inName==HX_("STORAGE",1b,b3,7c,c4)) return 0;
	return super::__FindArgCount(inName);
}

::hx::Val SaveFailureType_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	if (inName==HX_("ENCODING",d3,1c,de,89)) return ENCODING_dyn();
	if (inName==HX_("STORAGE",1b,b3,7c,c4)) return STORAGE;
	return super::__Field(inName,inCallProp);
}

static ::String SaveFailureType_obj_sStaticFields[] = {
	HX_("STORAGE",1b,b3,7c,c4),
	HX_("ENCODING",d3,1c,de,89),
	::String(null())
};

::hx::Class SaveFailureType_obj::__mClass;

Dynamic __Create_SaveFailureType_obj() { return new SaveFailureType_obj; }

void SaveFailureType_obj::__register()
{

::hx::Static(__mClass) = ::hx::_hx_RegisterClass(HX_("flixel.util.SaveFailureType",ad,92,48,5c), ::hx::TCanCast< SaveFailureType_obj >,SaveFailureType_obj_sStaticFields,0,
	&__Create_SaveFailureType_obj, &__Create,
	&super::__SGetClass(), &CreateSaveFailureType_obj, 0
#ifdef HXCPP_VISIT_ALLOCS
    , 0
#endif
#ifdef HXCPP_SCRIPTABLE
    , 0
#endif
);
	__mClass->mGetStaticField = &SaveFailureType_obj::__GetStatic;
}

void SaveFailureType_obj::__boot()
{
STORAGE = ::hx::CreateConstEnum< SaveFailureType_obj >(HX_("STORAGE",1b,b3,7c,c4),0);
}


} // end namespace flixel
} // end namespace util
