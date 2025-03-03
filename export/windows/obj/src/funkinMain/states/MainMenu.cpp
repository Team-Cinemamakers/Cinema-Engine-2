// Generated by Haxe 4.3.6
#include <hxcpp.h>

#ifndef INCLUDED_backend_Input
#include <backend/Input.h>
#endif
#ifndef INCLUDED_backend_Paths
#include <backend/Paths.h>
#endif
#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
#endif
#ifndef INCLUDED_flixel_FlxG
#include <flixel/FlxG.h>
#endif
#ifndef INCLUDED_flixel_FlxObject
#include <flixel/FlxObject.h>
#endif
#ifndef INCLUDED_flixel_FlxSprite
#include <flixel/FlxSprite.h>
#endif
#ifndef INCLUDED_flixel_FlxState
#include <flixel/FlxState.h>
#endif
#ifndef INCLUDED_flixel_group_FlxTypedContainer
#include <flixel/group/FlxTypedContainer.h>
#endif
#ifndef INCLUDED_flixel_group_FlxTypedGroup
#include <flixel/group/FlxTypedGroup.h>
#endif
#ifndef INCLUDED_flixel_sound_FlxSound
#include <flixel/sound/FlxSound.h>
#endif
#ifndef INCLUDED_flixel_sound_FlxSoundGroup
#include <flixel/sound/FlxSoundGroup.h>
#endif
#ifndef INCLUDED_flixel_system_frontEnds_SoundFrontEnd
#include <flixel/system/frontEnds/SoundFrontEnd.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxDestroyable
#include <flixel/util/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_funkinMain_states_MainMenu
#include <funkinMain/states/MainMenu.h>
#endif
#ifndef INCLUDED_haxe_Log
#include <haxe/Log.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_0602c95667eab96f_5_new,"funkinMain.states.MainMenu","new",0xf8586ed2,"funkinMain.states.MainMenu.new","funkinMain/states/MainMenu.hx",5,0xacef52be)
HX_LOCAL_STACK_FRAME(_hx_pos_0602c95667eab96f_10_create,"funkinMain.states.MainMenu","create",0x199bdbca,"funkinMain.states.MainMenu.create","funkinMain/states/MainMenu.hx",10,0xacef52be)
HX_LOCAL_STACK_FRAME(_hx_pos_0602c95667eab96f_27_update,"funkinMain.states.MainMenu","update",0x2491fad7,"funkinMain.states.MainMenu.update","funkinMain/states/MainMenu.hx",27,0xacef52be)
namespace funkinMain{
namespace states{

void MainMenu_obj::__construct(){
            	HX_STACKFRAME(&_hx_pos_0602c95667eab96f_5_new)
HXDLIN(   5)		super::__construct();
            	}

Dynamic MainMenu_obj::__CreateEmpty() { return new MainMenu_obj; }

void *MainMenu_obj::_hx_vtable = 0;

Dynamic MainMenu_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< MainMenu_obj > _hx_result = new MainMenu_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool MainMenu_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x62817b24) {
		if (inClassId<=(int)0x563293a6) {
			if (inClassId<=(int)0x20550a50) {
				return inClassId==(int)0x00000001 || inClassId==(int)0x20550a50;
			} else {
				return inClassId==(int)0x563293a6;
			}
		} else {
			return inClassId==(int)0x62817b24;
		}
	} else {
		return inClassId==(int)0x7c795c9f || inClassId==(int)0x7ccf8994;
	}
}

void MainMenu_obj::create(){
            	HX_GC_STACKFRAME(&_hx_pos_0602c95667eab96f_10_create)
HXLINE(  11)		this->super::create();
HXLINE(  13)		::flixel::FlxG_obj::autoPause = false;
HXLINE(  15)		if (::hx::IsNull( ::flixel::FlxG_obj::sound->music )) {
HXLINE(  16)			 ::flixel::_hx_system::frontEnds::SoundFrontEnd _hx_tmp = ::flixel::FlxG_obj::sound;
HXDLIN(  16)			_hx_tmp->playMusic(::backend::Paths_obj::music(HX_("freakyMenu",15,c9,93,86)),null(),null(),null());
            		}
HXLINE(  19)		 ::flixel::FlxSprite _hx_tmp1 =  ::flixel::FlxSprite_obj::__alloc( HX_CTX ,null(),null(),null());
HXDLIN(  19)		this->bg = _hx_tmp1->loadGraphic(::backend::Paths_obj::stateAssets(HX_("mainMenu/menuBG",1b,37,f3,1e)),null(),null(),null(),null(),null());
HXLINE(  20)		{
HXLINE(  20)			 ::flixel::FlxSprite _this = this->bg;
HXDLIN(  20)			int axes = 17;
HXDLIN(  20)			bool _hx_tmp2;
HXDLIN(  20)			if ((axes != 1)) {
HXLINE(  20)				_hx_tmp2 = (axes == 17);
            			}
            			else {
HXLINE(  20)				_hx_tmp2 = true;
            			}
HXDLIN(  20)			if (_hx_tmp2) {
HXLINE(  20)				int _hx_tmp3 = ::flixel::FlxG_obj::width;
HXDLIN(  20)				_this->set_x(((( (Float)(_hx_tmp3) ) - _this->get_width()) / ( (Float)(2) )));
            			}
HXDLIN(  20)			bool _hx_tmp4;
HXDLIN(  20)			if ((axes != 16)) {
HXLINE(  20)				_hx_tmp4 = (axes == 17);
            			}
            			else {
HXLINE(  20)				_hx_tmp4 = true;
            			}
HXDLIN(  20)			if (_hx_tmp4) {
HXLINE(  20)				int _hx_tmp5 = ::flixel::FlxG_obj::height;
HXDLIN(  20)				_this->set_y(((( (Float)(_hx_tmp5) ) - _this->get_height()) / ( (Float)(2) )));
            			}
            		}
HXLINE(  21)		this->add(this->bg);
HXLINE(  22)		::haxe::Log_obj::trace(::backend::Input_obj::mainInputJson,::hx::SourceInfo(HX_("source/funkinMain/states/MainMenu.hx",4a,d3,ef,c2),22,HX_("funkinMain.states.MainMenu",e0,5d,e8,87),HX_("create",fc,66,0f,7c)));
            	}


void MainMenu_obj::update(Float elapsed){
            	HX_STACKFRAME(&_hx_pos_0602c95667eab96f_27_update)
HXDLIN(  27)		this->super::update(elapsed);
            	}



::hx::ObjectPtr< MainMenu_obj > MainMenu_obj::__new() {
	::hx::ObjectPtr< MainMenu_obj > __this = new MainMenu_obj();
	__this->__construct();
	return __this;
}

::hx::ObjectPtr< MainMenu_obj > MainMenu_obj::__alloc(::hx::Ctx *_hx_ctx) {
	MainMenu_obj *__this = (MainMenu_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(MainMenu_obj), true, "funkinMain.states.MainMenu"));
	*(void **)__this = MainMenu_obj::_hx_vtable;
	__this->__construct();
	return __this;
}

MainMenu_obj::MainMenu_obj()
{
}

void MainMenu_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(MainMenu);
	HX_MARK_MEMBER_NAME(bg,"bg");
	 ::flixel::FlxState_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void MainMenu_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(bg,"bg");
	 ::flixel::FlxState_obj::__Visit(HX_VISIT_ARG);
}

::hx::Val MainMenu_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 2:
		if (HX_FIELD_EQ(inName,"bg") ) { return ::hx::Val( bg ); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return ::hx::Val( create_dyn() ); }
		if (HX_FIELD_EQ(inName,"update") ) { return ::hx::Val( update_dyn() ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val MainMenu_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 2:
		if (HX_FIELD_EQ(inName,"bg") ) { bg=inValue.Cast<  ::flixel::FlxSprite >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void MainMenu_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("bg",c5,55,00,00));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo MainMenu_obj_sMemberStorageInfo[] = {
	{::hx::fsObject /*  ::flixel::FlxSprite */ ,(int)offsetof(MainMenu_obj,bg),HX_("bg",c5,55,00,00)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *MainMenu_obj_sStaticStorageInfo = 0;
#endif

static ::String MainMenu_obj_sMemberFields[] = {
	HX_("bg",c5,55,00,00),
	HX_("create",fc,66,0f,7c),
	HX_("update",09,86,05,87),
	::String(null()) };

::hx::Class MainMenu_obj::__mClass;

void MainMenu_obj::__register()
{
	MainMenu_obj _hx_dummy;
	MainMenu_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("funkinMain.states.MainMenu",e0,5d,e8,87);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(MainMenu_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< MainMenu_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = MainMenu_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = MainMenu_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace funkinMain
} // end namespace states
