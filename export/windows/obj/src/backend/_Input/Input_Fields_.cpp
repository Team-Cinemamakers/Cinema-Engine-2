// Generated by Haxe 4.3.6
#include <hxcpp.h>

#ifndef INCLUDED_backend__Input_Input_Fields_
#include <backend/_Input/Input_Fields_.h>
#endif

namespace backend{
namespace _Input{

void Input_Fields__obj::__construct() { }

Dynamic Input_Fields__obj::__CreateEmpty() { return new Input_Fields__obj; }

void *Input_Fields__obj::_hx_vtable = 0;

Dynamic Input_Fields__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< Input_Fields__obj > _hx_result = new Input_Fields__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool Input_Fields__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x55ba6cba;
}

::Array< ::Dynamic> Input_Fields__obj::inputs;


Input_Fields__obj::Input_Fields__obj()
{
}

bool Input_Fields__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"inputs") ) { outValue = ( inputs ); return true; }
	}
	return false;
}

bool Input_Fields__obj::__SetStatic(const ::String &inName,Dynamic &ioValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"inputs") ) { inputs=ioValue.Cast< ::Array< ::Dynamic> >(); return true; }
	}
	return false;
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *Input_Fields__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo Input_Fields__obj_sStaticStorageInfo[] = {
	{::hx::fsObject /* ::Array< ::Dynamic> */ ,(void *) &Input_Fields__obj::inputs,HX_("inputs",29,c5,ed,9b)},
	{ ::hx::fsUnknown, 0, null()}
};
#endif

static void Input_Fields__obj_sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Input_Fields__obj::inputs,"inputs");
};

#ifdef HXCPP_VISIT_ALLOCS
static void Input_Fields__obj_sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Input_Fields__obj::inputs,"inputs");
};

#endif

::hx::Class Input_Fields__obj::__mClass;

static ::String Input_Fields__obj_sStaticFields[] = {
	HX_("inputs",29,c5,ed,9b),
	::String(null())
};

void Input_Fields__obj::__register()
{
	Input_Fields__obj _hx_dummy;
	Input_Fields__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("backend._Input.Input_Fields_",28,55,95,46);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &Input_Fields__obj::__GetStatic;
	__mClass->mSetStaticField = &Input_Fields__obj::__SetStatic;
	__mClass->mMarkFunc = Input_Fields__obj_sMarkStatics;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(Input_Fields__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< Input_Fields__obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = Input_Fields__obj_sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = Input_Fields__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = Input_Fields__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace backend
} // end namespace _Input
