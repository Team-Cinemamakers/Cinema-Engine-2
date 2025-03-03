// Generated by Haxe 4.3.6
#include <hxcpp.h>

#ifndef INCLUDED_flixel_util_FlxSaveStatus
#include <flixel/util/FlxSaveStatus.h>
#endif
#ifndef INCLUDED_flixel_util_LoadFailureType
#include <flixel/util/LoadFailureType.h>
#endif
#ifndef INCLUDED_flixel_util_SaveFailureType
#include <flixel/util/SaveFailureType.h>
#endif
namespace flixel{
namespace util{

::flixel::util::FlxSaveStatus FlxSaveStatus_obj::BOUND(::String name,::String path)
{
	return ::hx::CreateEnum< FlxSaveStatus_obj >(HX_("BOUND",1e,e8,ea,34),1,2)->_hx_init(0,name)->_hx_init(1,path);
}

::flixel::util::FlxSaveStatus FlxSaveStatus_obj::EMPTY;

::flixel::util::FlxSaveStatus FlxSaveStatus_obj::ERROR(::String msg)
{
	return ::hx::CreateEnum< FlxSaveStatus_obj >(HX_("ERROR",a8,03,18,f1),4,1)->_hx_init(0,msg);
}

::flixel::util::FlxSaveStatus FlxSaveStatus_obj::LOAD_ERROR( ::flixel::util::LoadFailureType type)
{
	return ::hx::CreateEnum< FlxSaveStatus_obj >(HX_("LOAD_ERROR",8f,cd,1c,ad),3,1)->_hx_init(0,type);
}

::flixel::util::FlxSaveStatus FlxSaveStatus_obj::SAVE_ERROR( ::flixel::util::SaveFailureType type)
{
	return ::hx::CreateEnum< FlxSaveStatus_obj >(HX_("SAVE_ERROR",e6,29,ab,40),2,1)->_hx_init(0,type);
}

bool FlxSaveStatus_obj::__GetStatic(const ::String &inName, ::Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	if (inName==HX_("BOUND",1e,e8,ea,34)) { outValue = FlxSaveStatus_obj::BOUND_dyn(); return true; }
	if (inName==HX_("EMPTY",6d,72,c8,ed)) { outValue = FlxSaveStatus_obj::EMPTY; return true; }
	if (inName==HX_("ERROR",a8,03,18,f1)) { outValue = FlxSaveStatus_obj::ERROR_dyn(); return true; }
	if (inName==HX_("LOAD_ERROR",8f,cd,1c,ad)) { outValue = FlxSaveStatus_obj::LOAD_ERROR_dyn(); return true; }
	if (inName==HX_("SAVE_ERROR",e6,29,ab,40)) { outValue = FlxSaveStatus_obj::SAVE_ERROR_dyn(); return true; }
	return super::__GetStatic(inName, outValue, inCallProp);
}

HX_DEFINE_CREATE_ENUM(FlxSaveStatus_obj)

int FlxSaveStatus_obj::__FindIndex(::String inName)
{
	if (inName==HX_("BOUND",1e,e8,ea,34)) return 1;
	if (inName==HX_("EMPTY",6d,72,c8,ed)) return 0;
	if (inName==HX_("ERROR",a8,03,18,f1)) return 4;
	if (inName==HX_("LOAD_ERROR",8f,cd,1c,ad)) return 3;
	if (inName==HX_("SAVE_ERROR",e6,29,ab,40)) return 2;
	return super::__FindIndex(inName);
}

STATIC_HX_DEFINE_DYNAMIC_FUNC2(FlxSaveStatus_obj,BOUND,return)

STATIC_HX_DEFINE_DYNAMIC_FUNC1(FlxSaveStatus_obj,ERROR,return)

STATIC_HX_DEFINE_DYNAMIC_FUNC1(FlxSaveStatus_obj,LOAD_ERROR,return)

STATIC_HX_DEFINE_DYNAMIC_FUNC1(FlxSaveStatus_obj,SAVE_ERROR,return)

int FlxSaveStatus_obj::__FindArgCount(::String inName)
{
	if (inName==HX_("BOUND",1e,e8,ea,34)) return 2;
	if (inName==HX_("EMPTY",6d,72,c8,ed)) return 0;
	if (inName==HX_("ERROR",a8,03,18,f1)) return 1;
	if (inName==HX_("LOAD_ERROR",8f,cd,1c,ad)) return 1;
	if (inName==HX_("SAVE_ERROR",e6,29,ab,40)) return 1;
	return super::__FindArgCount(inName);
}

::hx::Val FlxSaveStatus_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	if (inName==HX_("BOUND",1e,e8,ea,34)) return BOUND_dyn();
	if (inName==HX_("EMPTY",6d,72,c8,ed)) return EMPTY;
	if (inName==HX_("ERROR",a8,03,18,f1)) return ERROR_dyn();
	if (inName==HX_("LOAD_ERROR",8f,cd,1c,ad)) return LOAD_ERROR_dyn();
	if (inName==HX_("SAVE_ERROR",e6,29,ab,40)) return SAVE_ERROR_dyn();
	return super::__Field(inName,inCallProp);
}

static ::String FlxSaveStatus_obj_sStaticFields[] = {
	HX_("EMPTY",6d,72,c8,ed),
	HX_("BOUND",1e,e8,ea,34),
	HX_("SAVE_ERROR",e6,29,ab,40),
	HX_("LOAD_ERROR",8f,cd,1c,ad),
	HX_("ERROR",a8,03,18,f1),
	::String(null())
};

::hx::Class FlxSaveStatus_obj::__mClass;

Dynamic __Create_FlxSaveStatus_obj() { return new FlxSaveStatus_obj; }

void FlxSaveStatus_obj::__register()
{

::hx::Static(__mClass) = ::hx::_hx_RegisterClass(HX_("flixel.util.FlxSaveStatus",a7,aa,c7,52), ::hx::TCanCast< FlxSaveStatus_obj >,FlxSaveStatus_obj_sStaticFields,0,
	&__Create_FlxSaveStatus_obj, &__Create,
	&super::__SGetClass(), &CreateFlxSaveStatus_obj, 0
#ifdef HXCPP_VISIT_ALLOCS
    , 0
#endif
#ifdef HXCPP_SCRIPTABLE
    , 0
#endif
);
	__mClass->mGetStaticField = &FlxSaveStatus_obj::__GetStatic;
}

void FlxSaveStatus_obj::__boot()
{
EMPTY = ::hx::CreateConstEnum< FlxSaveStatus_obj >(HX_("EMPTY",6d,72,c8,ed),0);
}


} // end namespace flixel
} // end namespace util
