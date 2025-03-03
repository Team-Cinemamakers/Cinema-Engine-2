// Generated by Haxe 4.3.6
#include <hxcpp.h>

#ifndef INCLUDED_Std
#include <Std.h>
#endif
#ifndef INCLUDED_flixel_system__FlxBasePreloader_DefaultPreloader
#include <flixel/system/_FlxBasePreloader/DefaultPreloader.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObject
#include <openfl/display/DisplayObject.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObjectContainer
#include <openfl/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_openfl_display_IBitmapDrawable
#include <openfl/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_openfl_display_InteractiveObject
#include <openfl/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_openfl_display_LoaderInfo
#include <openfl/display/LoaderInfo.h>
#endif
#ifndef INCLUDED_openfl_display_Sprite
#include <openfl/display/Sprite.h>
#endif
#ifndef INCLUDED_openfl_events_Event
#include <openfl/events/Event.h>
#endif
#ifndef INCLUDED_openfl_events_EventDispatcher
#include <openfl/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_IEventDispatcher
#include <openfl/events/IEventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_ProgressEvent
#include <openfl/events/ProgressEvent.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_b5ad01cadf9f6950_411_new,"flixel.system._FlxBasePreloader.DefaultPreloader","new",0xd190e230,"flixel.system._FlxBasePreloader.DefaultPreloader.new","flixel/system/FlxBasePreloader.hx",411,0x863b5dde)
HX_LOCAL_STACK_FRAME(_hx_pos_b5ad01cadf9f6950_417_onAddedToStage,"flixel.system._FlxBasePreloader.DefaultPreloader","onAddedToStage",0x45f82252,"flixel.system._FlxBasePreloader.DefaultPreloader.onAddedToStage","flixel/system/FlxBasePreloader.hx",417,0x863b5dde)
HX_LOCAL_STACK_FRAME(_hx_pos_b5ad01cadf9f6950_428_onComplete,"flixel.system._FlxBasePreloader.DefaultPreloader","onComplete",0xb0729d28,"flixel.system._FlxBasePreloader.DefaultPreloader.onComplete","flixel/system/FlxBasePreloader.hx",428,0x863b5dde)
HX_LOCAL_STACK_FRAME(_hx_pos_b5ad01cadf9f6950_439_onProgress,"flixel.system._FlxBasePreloader.DefaultPreloader","onProgress",0xb6d5941c,"flixel.system._FlxBasePreloader.DefaultPreloader.onProgress","flixel/system/FlxBasePreloader.hx",439,0x863b5dde)
HX_LOCAL_STACK_FRAME(_hx_pos_b5ad01cadf9f6950_442_onInit,"flixel.system._FlxBasePreloader.DefaultPreloader","onInit",0x814533ff,"flixel.system._FlxBasePreloader.DefaultPreloader.onInit","flixel/system/FlxBasePreloader.hx",442,0x863b5dde)
HX_LOCAL_STACK_FRAME(_hx_pos_b5ad01cadf9f6950_446_onLoaded,"flixel.system._FlxBasePreloader.DefaultPreloader","onLoaded",0x051c9ab4,"flixel.system._FlxBasePreloader.DefaultPreloader.onLoaded","flixel/system/FlxBasePreloader.hx",446,0x863b5dde)
HX_LOCAL_STACK_FRAME(_hx_pos_b5ad01cadf9f6950_450_onUpdate,"flixel.system._FlxBasePreloader.DefaultPreloader","onUpdate",0x33b2d8b8,"flixel.system._FlxBasePreloader.DefaultPreloader.onUpdate","flixel/system/FlxBasePreloader.hx",450,0x863b5dde)
namespace flixel{
namespace _hx_system{
namespace _FlxBasePreloader{

void DefaultPreloader_obj::__construct(){
            	HX_STACKFRAME(&_hx_pos_b5ad01cadf9f6950_411_new)
HXLINE( 412)		super::__construct();
HXLINE( 413)		this->addEventListener(HX_("addedToStage",63,22,55,0c),this->onAddedToStage_dyn(),null(),null(),null());
            	}

Dynamic DefaultPreloader_obj::__CreateEmpty() { return new DefaultPreloader_obj; }

void *DefaultPreloader_obj::_hx_vtable = 0;

Dynamic DefaultPreloader_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< DefaultPreloader_obj > _hx_result = new DefaultPreloader_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool DefaultPreloader_obj::_hx_isInstanceOf(int inClassId) {
	if (inClassId<=(int)0x1f4df417) {
		if (inClassId<=(int)0x0c89e854) {
			if (inClassId<=(int)0x0330636f) {
				return inClassId==(int)0x00000001 || inClassId==(int)0x0330636f;
			} else {
				return inClassId==(int)0x0c89e854;
			}
		} else {
			return inClassId==(int)0x1f4df417;
		}
	} else {
		if (inClassId<=(int)0x4af7dd8e) {
			return inClassId==(int)0x318ede3c || inClassId==(int)0x4af7dd8e;
		} else {
			return inClassId==(int)0x6b353933;
		}
	}
}

void DefaultPreloader_obj::onAddedToStage( ::openfl::events::Event _){
            	HX_STACKFRAME(&_hx_pos_b5ad01cadf9f6950_417_onAddedToStage)
HXLINE( 418)		this->removeEventListener(HX_("addedToStage",63,22,55,0c),this->onAddedToStage_dyn(),null());
HXLINE( 420)		this->onInit();
HXLINE( 421)		int _hx_tmp = this->get_loaderInfo()->bytesLoaded;
HXDLIN( 421)		this->onUpdate(_hx_tmp,this->get_loaderInfo()->bytesTotal);
HXLINE( 423)		this->addEventListener(HX_("progress",ad,f7,2a,86),this->onProgress_dyn(),null(),null(),null());
HXLINE( 424)		this->addEventListener(HX_("complete",b9,00,c8,7f),this->onComplete_dyn(),null(),null(),null());
            	}


HX_DEFINE_DYNAMIC_FUNC1(DefaultPreloader_obj,onAddedToStage,(void))

void DefaultPreloader_obj::onComplete( ::openfl::events::Event event){
            	HX_STACKFRAME(&_hx_pos_b5ad01cadf9f6950_428_onComplete)
HXLINE( 429)		event->preventDefault();
HXLINE( 431)		this->removeEventListener(HX_("progress",ad,f7,2a,86),this->onProgress_dyn(),null());
HXLINE( 432)		this->removeEventListener(HX_("complete",b9,00,c8,7f),this->onComplete_dyn(),null());
HXLINE( 434)		this->onLoaded();
            	}


HX_DEFINE_DYNAMIC_FUNC1(DefaultPreloader_obj,onComplete,(void))

void DefaultPreloader_obj::onProgress( ::openfl::events::ProgressEvent event){
            	HX_STACKFRAME(&_hx_pos_b5ad01cadf9f6950_439_onProgress)
HXDLIN( 439)		int _hx_tmp = ::Std_obj::_hx_int(event->bytesLoaded);
HXDLIN( 439)		this->onUpdate(_hx_tmp,::Std_obj::_hx_int(event->bytesTotal));
            	}


HX_DEFINE_DYNAMIC_FUNC1(DefaultPreloader_obj,onProgress,(void))

void DefaultPreloader_obj::onInit(){
            	HX_STACKFRAME(&_hx_pos_b5ad01cadf9f6950_442_onInit)
            	}


HX_DEFINE_DYNAMIC_FUNC0(DefaultPreloader_obj,onInit,(void))

void DefaultPreloader_obj::onLoaded(){
            	HX_GC_STACKFRAME(&_hx_pos_b5ad01cadf9f6950_446_onLoaded)
HXDLIN( 446)		this->dispatchEvent( ::openfl::events::Event_obj::__alloc( HX_CTX ,HX_("unload",ff,a0,8c,65),null(),null()));
            	}


HX_DEFINE_DYNAMIC_FUNC0(DefaultPreloader_obj,onLoaded,(void))

void DefaultPreloader_obj::onUpdate(int bytesLoaded,int bytesTotal){
            	HX_STACKFRAME(&_hx_pos_b5ad01cadf9f6950_450_onUpdate)
HXLINE( 451)		Float percentLoaded = ((Float)0.0);
HXLINE( 452)		if ((bytesTotal > 0)) {
HXLINE( 454)			percentLoaded = (( (Float)(bytesLoaded) ) / ( (Float)(bytesTotal) ));
HXLINE( 455)			if ((percentLoaded > 1)) {
HXLINE( 456)				percentLoaded = ( (Float)(1) );
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC2(DefaultPreloader_obj,onUpdate,(void))


::hx::ObjectPtr< DefaultPreloader_obj > DefaultPreloader_obj::__new() {
	::hx::ObjectPtr< DefaultPreloader_obj > __this = new DefaultPreloader_obj();
	__this->__construct();
	return __this;
}

::hx::ObjectPtr< DefaultPreloader_obj > DefaultPreloader_obj::__alloc(::hx::Ctx *_hx_ctx) {
	DefaultPreloader_obj *__this = (DefaultPreloader_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(DefaultPreloader_obj), true, "flixel.system._FlxBasePreloader.DefaultPreloader"));
	*(void **)__this = DefaultPreloader_obj::_hx_vtable;
	__this->__construct();
	return __this;
}

DefaultPreloader_obj::DefaultPreloader_obj()
{
}

::hx::Val DefaultPreloader_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"onInit") ) { return ::hx::Val( onInit_dyn() ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"onLoaded") ) { return ::hx::Val( onLoaded_dyn() ); }
		if (HX_FIELD_EQ(inName,"onUpdate") ) { return ::hx::Val( onUpdate_dyn() ); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"onComplete") ) { return ::hx::Val( onComplete_dyn() ); }
		if (HX_FIELD_EQ(inName,"onProgress") ) { return ::hx::Val( onProgress_dyn() ); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"onAddedToStage") ) { return ::hx::Val( onAddedToStage_dyn() ); }
	}
	return super::__Field(inName,inCallProp);
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *DefaultPreloader_obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo *DefaultPreloader_obj_sStaticStorageInfo = 0;
#endif

static ::String DefaultPreloader_obj_sMemberFields[] = {
	HX_("onAddedToStage",22,82,44,36),
	HX_("onComplete",f8,d4,7e,5d),
	HX_("onProgress",ec,cb,e1,63),
	HX_("onInit",cf,43,45,e8),
	HX_("onLoaded",84,3e,1c,38),
	HX_("onUpdate",88,7c,b2,66),
	::String(null()) };

::hx::Class DefaultPreloader_obj::__mClass;

void DefaultPreloader_obj::__register()
{
	DefaultPreloader_obj _hx_dummy;
	DefaultPreloader_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("flixel.system._FlxBasePreloader.DefaultPreloader",3e,4a,10,91);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(DefaultPreloader_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< DefaultPreloader_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = DefaultPreloader_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = DefaultPreloader_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace flixel
} // end namespace system
} // end namespace _FlxBasePreloader
