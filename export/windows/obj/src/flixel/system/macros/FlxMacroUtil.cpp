// Generated by Haxe 4.3.6
#include <hxcpp.h>

#ifndef INCLUDED_flixel_system_macros_FlxMacroUtil
#include <flixel/system/macros/FlxMacroUtil.h>
#endif

namespace flixel{
namespace _hx_system{
namespace macros{

void FlxMacroUtil_obj::__construct() { }

Dynamic FlxMacroUtil_obj::__CreateEmpty() { return new FlxMacroUtil_obj; }

void *FlxMacroUtil_obj::_hx_vtable = 0;

Dynamic FlxMacroUtil_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< FlxMacroUtil_obj > _hx_result = new FlxMacroUtil_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool FlxMacroUtil_obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x5efd4bf6;
}


FlxMacroUtil_obj::FlxMacroUtil_obj()
{
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *FlxMacroUtil_obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo *FlxMacroUtil_obj_sStaticStorageInfo = 0;
#endif

::hx::Class FlxMacroUtil_obj::__mClass;

void FlxMacroUtil_obj::__register()
{
	FlxMacroUtil_obj _hx_dummy;
	FlxMacroUtil_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("flixel.system.macros.FlxMacroUtil",36,eb,79,b7);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< FlxMacroUtil_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = FlxMacroUtil_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = FlxMacroUtil_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace flixel
} // end namespace system
} // end namespace macros
