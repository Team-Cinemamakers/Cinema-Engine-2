// Generated by Haxe 4.3.6
#include <hxcpp.h>

#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
#endif
#ifndef INCLUDED_flixel_FlxCamera
#include <flixel/FlxCamera.h>
#endif
#ifndef INCLUDED_flixel_FlxG
#include <flixel/FlxG.h>
#endif
#ifndef INCLUDED_flixel_FlxGame
#include <flixel/FlxGame.h>
#endif
#ifndef INCLUDED_flixel_FlxObject
#include <flixel/FlxObject.h>
#endif
#ifndef INCLUDED_flixel_FlxSprite
#include <flixel/FlxSprite.h>
#endif
#ifndef INCLUDED_flixel_system_debug_log_LogStyle
#include <flixel/system/debug/log/LogStyle.h>
#endif
#ifndef INCLUDED_flixel_system_frontEnds_CameraFrontEnd
#include <flixel/system/frontEnds/CameraFrontEnd.h>
#endif
#ifndef INCLUDED_flixel_system_frontEnds_LogFrontEnd
#include <flixel/system/frontEnds/LogFrontEnd.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxDestroyable
#include <flixel/util/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_flixel_util_IFlxSignal
#include <flixel/util/IFlxSignal.h>
#endif
#ifndef INCLUDED_flixel_util__FlxSignal_FlxBaseSignal
#include <flixel/util/_FlxSignal/FlxBaseSignal.h>
#endif
#ifndef INCLUDED_flixel_util__FlxSignal_FlxSignal1
#include <flixel/util/_FlxSignal/FlxSignal1.h>
#endif
#ifndef INCLUDED_openfl_display_BitmapData
#include <openfl/display/BitmapData.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObject
#include <openfl/display/DisplayObject.h>
#endif
#ifndef INCLUDED_openfl_display_DisplayObjectContainer
#include <openfl/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_openfl_display_Graphics
#include <openfl/display/Graphics.h>
#endif
#ifndef INCLUDED_openfl_display_IBitmapDrawable
#include <openfl/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_openfl_display_InteractiveObject
#include <openfl/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_openfl_display_Sprite
#include <openfl/display/Sprite.h>
#endif
#ifndef INCLUDED_openfl_events_EventDispatcher
#include <openfl/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_events_IEventDispatcher
#include <openfl/events/IEventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_geom_Rectangle
#include <openfl/geom/Rectangle.h>
#endif

HX_DEFINE_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_15_new,"flixel.system.frontEnds.CameraFrontEnd","new",0xc6f5a1a3,"flixel.system.frontEnds.CameraFrontEnd.new","flixel/system/frontEnds/CameraFrontEnd.hx",15,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_66_add,"flixel.system.frontEnds.CameraFrontEnd","add",0xc6ebc364,"flixel.system.frontEnds.CameraFrontEnd.add","flixel/system/frontEnds/CameraFrontEnd.hx",66,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_91_insert,"flixel.system.frontEnds.CameraFrontEnd","insert",0x43bd5dd6,"flixel.system.frontEnds.CameraFrontEnd.insert","flixel/system/frontEnds/CameraFrontEnd.hx",91,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_121_remove,"flixel.system.frontEnds.CameraFrontEnd","remove",0xaa68b6e1,"flixel.system.frontEnds.CameraFrontEnd.remove","flixel/system/frontEnds/CameraFrontEnd.hx",121,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_159_setDefaultDrawTarget,"flixel.system.frontEnds.CameraFrontEnd","setDefaultDrawTarget",0xada9a7f1,"flixel.system.frontEnds.CameraFrontEnd.setDefaultDrawTarget","flixel/system/frontEnds/CameraFrontEnd.hx",159,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_181_reset,"flixel.system.frontEnds.CameraFrontEnd","reset",0xf67331d2,"flixel.system.frontEnds.CameraFrontEnd.reset","flixel/system/frontEnds/CameraFrontEnd.hx",181,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_206_flash,"flixel.system.frontEnds.CameraFrontEnd","flash",0x12371db3,"flixel.system.frontEnds.CameraFrontEnd.flash","flixel/system/frontEnds/CameraFrontEnd.hx",206,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_223_fade,"flixel.system.frontEnds.CameraFrontEnd","fade",0x4aaafed9,"flixel.system.frontEnds.CameraFrontEnd.fade","flixel/system/frontEnds/CameraFrontEnd.hx",223,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_240_shake,"flixel.system.frontEnds.CameraFrontEnd","shake",0x8bc7c6c9,"flixel.system.frontEnds.CameraFrontEnd.shake","flixel/system/frontEnds/CameraFrontEnd.hx",240,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_258_lock,"flixel.system.frontEnds.CameraFrontEnd","lock",0x4eace548,"flixel.system.frontEnds.CameraFrontEnd.lock","flixel/system/frontEnds/CameraFrontEnd.hx",258,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_300_render,"flixel.system.frontEnds.CameraFrontEnd","render",0xab0985f3,"flixel.system.frontEnds.CameraFrontEnd.render","flixel/system/frontEnds/CameraFrontEnd.hx",300,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_318_unlock,"flixel.system.frontEnds.CameraFrontEnd","unlock",0x0b6cbd61,"flixel.system.frontEnds.CameraFrontEnd.unlock","flixel/system/frontEnds/CameraFrontEnd.hx",318,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_345_update,"flixel.system.frontEnds.CameraFrontEnd","update",0x2ce5a0a6,"flixel.system.frontEnds.CameraFrontEnd.update","flixel/system/frontEnds/CameraFrontEnd.hx",345,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_360_resize,"flixel.system.frontEnds.CameraFrontEnd","resize",0xae5b7491,"flixel.system.frontEnds.CameraFrontEnd.resize","flixel/system/frontEnds/CameraFrontEnd.hx",360,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_368_get_bgColor,"flixel.system.frontEnds.CameraFrontEnd","get_bgColor",0x99072db8,"flixel.system.frontEnds.CameraFrontEnd.get_bgColor","flixel/system/frontEnds/CameraFrontEnd.hx",368,0x7a57d3ec)
HX_LOCAL_STACK_FRAME(_hx_pos_37a8fd7f84c9d590_372_set_bgColor,"flixel.system.frontEnds.CameraFrontEnd","set_bgColor",0xa37434c4,"flixel.system.frontEnds.CameraFrontEnd.set_bgColor","flixel/system/frontEnds/CameraFrontEnd.hx",372,0x7a57d3ec)
namespace flixel{
namespace _hx_system{
namespace frontEnds{

void CameraFrontEnd_obj::__construct(){
            	HX_GC_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_15_new)
HXLINE(  53)		this->_cameraRect =  ::openfl::geom::Rectangle_obj::__alloc( HX_CTX ,null(),null(),null(),null());
HXLINE(  48)		this->useBufferLocking = false;
HXLINE(  42)		this->cameraResized =  ::flixel::util::_FlxSignal::FlxSignal1_obj::__alloc( HX_CTX );
HXLINE(  39)		this->cameraRemoved =  ::flixel::util::_FlxSignal::FlxSignal1_obj::__alloc( HX_CTX );
HXLINE(  36)		this->cameraAdded =  ::flixel::util::_FlxSignal::FlxSignal1_obj::__alloc( HX_CTX );
HXLINE(  28)		this->defaults = ::Array_obj< ::Dynamic>::__new(0);
HXLINE(  22)		this->list = ::Array_obj< ::Dynamic>::__new(0);
HXLINE( 249)		::flixel::FlxCamera_obj::_defaultCameras = this->defaults;
            	}

Dynamic CameraFrontEnd_obj::__CreateEmpty() { return new CameraFrontEnd_obj; }

void *CameraFrontEnd_obj::_hx_vtable = 0;

Dynamic CameraFrontEnd_obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< CameraFrontEnd_obj > _hx_result = new CameraFrontEnd_obj();
	_hx_result->__construct();
	return _hx_result;
}

bool CameraFrontEnd_obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x683a772d;
}

 ::Dynamic CameraFrontEnd_obj::add( ::Dynamic NewCamera,::hx::Null< bool >  __o_DefaultDrawTarget){
            		bool DefaultDrawTarget = __o_DefaultDrawTarget.Default(true);
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_66_add)
HXLINE(  67)		 ::flixel::FlxGame _hx_tmp = ::flixel::FlxG_obj::game;
HXDLIN(  67)		 ::openfl::display::Sprite NewCamera1 = ( ( ::flixel::FlxCamera)(NewCamera) )->flashSprite;
HXDLIN(  67)		_hx_tmp->addChildAt(NewCamera1,::flixel::FlxG_obj::game->getChildIndex(::flixel::FlxG_obj::game->_inputContainer));
HXLINE(  69)		this->list->push(NewCamera);
HXLINE(  70)		if (DefaultDrawTarget) {
HXLINE(  71)			this->defaults->push(NewCamera);
            		}
HXLINE(  73)		( ( ::flixel::FlxBasic)(NewCamera) )->ID = (this->list->length - 1);
HXLINE(  74)		this->cameraAdded->dispatch(( ( ::flixel::FlxCamera)(NewCamera) ));
HXLINE(  75)		return NewCamera;
            	}


HX_DEFINE_DYNAMIC_FUNC2(CameraFrontEnd_obj,add,return )

 ::Dynamic CameraFrontEnd_obj::insert( ::Dynamic newCamera,int position,::hx::Null< bool >  __o_defaultDrawTarget){
            		bool defaultDrawTarget = __o_defaultDrawTarget.Default(true);
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_91_insert)
HXLINE(  93)		if ((position < 0)) {
HXLINE(  94)			position = (position + this->list->length);
            		}
HXLINE(  97)		if ((position >= this->list->length)) {
HXLINE(  98)			return this->add(newCamera,null());
            		}
HXLINE( 100)		int childIndex = ::flixel::FlxG_obj::game->getChildIndex(this->list->__get(position).StaticCast<  ::flixel::FlxCamera >()->flashSprite);
HXLINE( 101)		::flixel::FlxG_obj::game->addChildAt(( ( ::flixel::FlxCamera)(newCamera) )->flashSprite,childIndex);
HXLINE( 103)		this->list->insert(position,newCamera);
HXLINE( 104)		if (defaultDrawTarget) {
HXLINE( 105)			this->defaults->push(newCamera);
            		}
HXLINE( 107)		{
HXLINE( 107)			int _g = position;
HXDLIN( 107)			int _g1 = this->list->length;
HXDLIN( 107)			while((_g < _g1)){
HXLINE( 107)				_g = (_g + 1);
HXDLIN( 107)				int i = (_g - 1);
HXLINE( 108)				this->list->__get(i).StaticCast<  ::flixel::FlxCamera >()->ID = i;
            			}
            		}
HXLINE( 110)		this->cameraAdded->dispatch(( ( ::flixel::FlxCamera)(newCamera) ));
HXLINE( 111)		return newCamera;
            	}


HX_DEFINE_DYNAMIC_FUNC3(CameraFrontEnd_obj,insert,return )

void CameraFrontEnd_obj::remove( ::flixel::FlxCamera Camera,::hx::Null< bool >  __o_Destroy){
            		bool Destroy = __o_Destroy.Default(true);
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_121_remove)
HXLINE( 122)		int index = this->list->indexOf(Camera,null());
HXLINE( 123)		bool _hx_tmp;
HXDLIN( 123)		if (::hx::IsNotNull( Camera )) {
HXLINE( 123)			_hx_tmp = (index != -1);
            		}
            		else {
HXLINE( 123)			_hx_tmp = false;
            		}
HXDLIN( 123)		if (_hx_tmp) {
HXLINE( 125)			::flixel::FlxG_obj::game->removeChild(Camera->flashSprite);
HXLINE( 126)			this->list->removeRange(index,1);
HXLINE( 127)			this->defaults->remove(Camera);
            		}
            		else {
HXLINE( 131)			::flixel::FlxG_obj::log->advanced(HX_("FlxG.cameras.remove(): The camera you attempted to remove is not a part of the game.",63,6f,2b,31),::flixel::_hx_system::debug::log::LogStyle_obj::WARNING,true,::hx::SourceInfo(HX_("flixel/system/frontEnds/CameraFrontEnd.hx",ec,d3,57,7a),131,HX_("flixel.system.frontEnds.CameraFrontEnd",31,94,3d,41),HX_("remove",44,9c,88,04)));
HXLINE( 132)			return;
            		}
HXLINE( 135)		if (::flixel::FlxG_obj::renderTile) {
HXLINE( 137)			int _g = 0;
HXDLIN( 137)			int _g1 = this->list->length;
HXDLIN( 137)			while((_g < _g1)){
HXLINE( 137)				_g = (_g + 1);
HXDLIN( 137)				int i = (_g - 1);
HXLINE( 139)				this->list->__get(i).StaticCast<  ::flixel::FlxCamera >()->ID = i;
            			}
            		}
HXLINE( 143)		if (Destroy) {
HXLINE( 144)			Camera->destroy();
            		}
HXLINE( 146)		this->cameraRemoved->dispatch(Camera);
            	}


HX_DEFINE_DYNAMIC_FUNC2(CameraFrontEnd_obj,remove,(void))

void CameraFrontEnd_obj::setDefaultDrawTarget( ::flixel::FlxCamera camera,bool value){
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_159_setDefaultDrawTarget)
HXLINE( 160)		if (!(this->list->contains(camera))) {
HXLINE( 162)			::flixel::FlxG_obj::log->advanced(HX_("FlxG.cameras.setDefaultDrawTarget(): The specified camera is not a part of the game.",17,fb,50,a6),::flixel::_hx_system::debug::log::LogStyle_obj::WARNING,true,::hx::SourceInfo(HX_("flixel/system/frontEnds/CameraFrontEnd.hx",ec,d3,57,7a),162,HX_("flixel.system.frontEnds.CameraFrontEnd",31,94,3d,41),HX_("setDefaultDrawTarget",94,14,3f,93)));
HXLINE( 163)			return;
            		}
HXLINE( 166)		int index = this->defaults->indexOf(camera,null());
HXLINE( 168)		bool _hx_tmp;
HXDLIN( 168)		if (value) {
HXLINE( 168)			_hx_tmp = (index == -1);
            		}
            		else {
HXLINE( 168)			_hx_tmp = false;
            		}
HXDLIN( 168)		if (_hx_tmp) {
HXLINE( 169)			this->defaults->push(camera);
            		}
            		else {
HXLINE( 170)			if (!(value)) {
HXLINE( 171)				this->defaults->removeRange(index,1);
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC2(CameraFrontEnd_obj,setDefaultDrawTarget,(void))

void CameraFrontEnd_obj::reset( ::flixel::FlxCamera NewCamera){
            	HX_GC_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_181_reset)
HXLINE( 182)		::flixel::FlxG_obj::camera = null();
HXLINE( 184)		while((this->list->length > 0)){
HXLINE( 185)			this->remove(this->list->__get(0).StaticCast<  ::flixel::FlxCamera >(),null());
            		}
HXLINE( 187)		if (::hx::IsNull( NewCamera )) {
HXLINE( 188)			NewCamera =  ::flixel::FlxCamera_obj::__alloc( HX_CTX ,null(),null(),null(),null(),null());
            		}
HXLINE( 190)		::flixel::FlxG_obj::camera = ( ( ::flixel::FlxCamera)(this->add(NewCamera,null())) );
HXLINE( 191)		NewCamera->ID = 0;
HXLINE( 193)		::flixel::FlxCamera_obj::_defaultCameras = this->defaults;
            	}


HX_DEFINE_DYNAMIC_FUNC1(CameraFrontEnd_obj,reset,(void))

void CameraFrontEnd_obj::flash(::hx::Null< int >  __o_Color,::hx::Null< Float >  __o_Duration, ::Dynamic OnComplete,::hx::Null< bool >  __o_Force){
            		int Color = __o_Color.Default(-1);
            		Float Duration = __o_Duration.Default(1);
            		bool Force = __o_Force.Default(false);
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_206_flash)
HXDLIN( 206)		int _g = 0;
HXDLIN( 206)		::Array< ::Dynamic> _g1 = this->list;
HXDLIN( 206)		while((_g < _g1->length)){
HXDLIN( 206)			 ::flixel::FlxCamera camera = _g1->__get(_g).StaticCast<  ::flixel::FlxCamera >();
HXDLIN( 206)			_g = (_g + 1);
HXLINE( 208)			camera->flash(Color,Duration,OnComplete,Force);
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC4(CameraFrontEnd_obj,flash,(void))

void CameraFrontEnd_obj::fade(::hx::Null< int >  __o_Color,::hx::Null< Float >  __o_Duration,::hx::Null< bool >  __o_FadeIn, ::Dynamic OnComplete,::hx::Null< bool >  __o_Force){
            		int Color = __o_Color.Default(-16777216);
            		Float Duration = __o_Duration.Default(1);
            		bool FadeIn = __o_FadeIn.Default(false);
            		bool Force = __o_Force.Default(false);
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_223_fade)
HXDLIN( 223)		int _g = 0;
HXDLIN( 223)		::Array< ::Dynamic> _g1 = this->list;
HXDLIN( 223)		while((_g < _g1->length)){
HXDLIN( 223)			 ::flixel::FlxCamera camera = _g1->__get(_g).StaticCast<  ::flixel::FlxCamera >();
HXDLIN( 223)			_g = (_g + 1);
HXLINE( 225)			camera->fade(Color,Duration,FadeIn,OnComplete,Force);
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC5(CameraFrontEnd_obj,fade,(void))

void CameraFrontEnd_obj::shake(::hx::Null< Float >  __o_Intensity,::hx::Null< Float >  __o_Duration, ::Dynamic OnComplete,::hx::Null< bool >  __o_Force, ::Dynamic Axes){
            		Float Intensity = __o_Intensity.Default(((Float)0.05));
            		Float Duration = __o_Duration.Default(((Float)0.5));
            		bool Force = __o_Force.Default(true);
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_240_shake)
HXDLIN( 240)		int _g = 0;
HXDLIN( 240)		::Array< ::Dynamic> _g1 = this->list;
HXDLIN( 240)		while((_g < _g1->length)){
HXDLIN( 240)			 ::flixel::FlxCamera camera = _g1->__get(_g).StaticCast<  ::flixel::FlxCamera >();
HXDLIN( 240)			_g = (_g + 1);
HXLINE( 242)			camera->shake(Intensity,Duration,OnComplete,Force,Axes);
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC5(CameraFrontEnd_obj,shake,(void))

void CameraFrontEnd_obj::lock(){
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_258_lock)
HXDLIN( 258)		int _g = 0;
HXDLIN( 258)		::Array< ::Dynamic> _g1 = this->list;
HXDLIN( 258)		while((_g < _g1->length)){
HXDLIN( 258)			 ::flixel::FlxCamera camera = _g1->__get(_g).StaticCast<  ::flixel::FlxCamera >();
HXDLIN( 258)			_g = (_g + 1);
HXLINE( 260)			bool _hx_tmp;
HXDLIN( 260)			bool _hx_tmp1;
HXDLIN( 260)			if (::hx::IsNotNull( camera )) {
HXLINE( 260)				_hx_tmp1 = !(camera->exists);
            			}
            			else {
HXLINE( 260)				_hx_tmp1 = true;
            			}
HXDLIN( 260)			if (!(_hx_tmp1)) {
HXLINE( 260)				_hx_tmp = !(camera->visible);
            			}
            			else {
HXLINE( 260)				_hx_tmp = true;
            			}
HXDLIN( 260)			if (_hx_tmp) {
HXLINE( 262)				continue;
            			}
HXLINE( 265)			if (::flixel::FlxG_obj::renderBlit) {
HXLINE( 267)				camera->checkResize();
HXLINE( 269)				if (this->useBufferLocking) {
HXLINE( 271)					camera->buffer->lock();
            				}
            			}
HXLINE( 275)			if (::flixel::FlxG_obj::renderTile) {
HXLINE( 277)				camera->clearDrawStack();
HXLINE( 278)				camera->canvas->get_graphics()->clear();
            			}
HXLINE( 285)			if (::flixel::FlxG_obj::renderBlit) {
HXLINE( 287)				camera->fill(camera->bgColor,camera->useBgAlphaBlending,null(),null());
HXLINE( 288)				camera->screen->dirty = true;
            			}
            			else {
HXLINE( 292)				camera->fill((camera->bgColor & 16777215),camera->useBgAlphaBlending,(( (Float)(((camera->bgColor >> 24) & 255)) ) / ( (Float)(255) )),null());
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(CameraFrontEnd_obj,lock,(void))

void CameraFrontEnd_obj::render(){
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_300_render)
HXDLIN( 300)		if (::flixel::FlxG_obj::renderTile) {
HXLINE( 302)			int _g = 0;
HXDLIN( 302)			::Array< ::Dynamic> _g1 = this->list;
HXDLIN( 302)			while((_g < _g1->length)){
HXLINE( 302)				 ::flixel::FlxCamera camera = _g1->__get(_g).StaticCast<  ::flixel::FlxCamera >();
HXDLIN( 302)				_g = (_g + 1);
HXLINE( 304)				bool _hx_tmp;
HXDLIN( 304)				bool _hx_tmp1;
HXDLIN( 304)				if (::hx::IsNotNull( camera )) {
HXLINE( 304)					_hx_tmp1 = camera->exists;
            				}
            				else {
HXLINE( 304)					_hx_tmp1 = false;
            				}
HXDLIN( 304)				if (_hx_tmp1) {
HXLINE( 304)					_hx_tmp = camera->visible;
            				}
            				else {
HXLINE( 304)					_hx_tmp = false;
            				}
HXDLIN( 304)				if (_hx_tmp) {
HXLINE( 306)					camera->render();
            				}
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(CameraFrontEnd_obj,render,(void))

void CameraFrontEnd_obj::unlock(){
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_318_unlock)
HXDLIN( 318)		int _g = 0;
HXDLIN( 318)		::Array< ::Dynamic> _g1 = this->list;
HXDLIN( 318)		while((_g < _g1->length)){
HXDLIN( 318)			 ::flixel::FlxCamera camera = _g1->__get(_g).StaticCast<  ::flixel::FlxCamera >();
HXDLIN( 318)			_g = (_g + 1);
HXLINE( 320)			bool _hx_tmp;
HXDLIN( 320)			bool _hx_tmp1;
HXDLIN( 320)			if (::hx::IsNotNull( camera )) {
HXLINE( 320)				_hx_tmp1 = !(camera->exists);
            			}
            			else {
HXLINE( 320)				_hx_tmp1 = true;
            			}
HXDLIN( 320)			if (!(_hx_tmp1)) {
HXLINE( 320)				_hx_tmp = !(camera->visible);
            			}
            			else {
HXLINE( 320)				_hx_tmp = true;
            			}
HXDLIN( 320)			if (_hx_tmp) {
HXLINE( 322)				continue;
            			}
HXLINE( 325)			camera->drawFX();
HXLINE( 327)			if (::flixel::FlxG_obj::renderBlit) {
HXLINE( 329)				if (this->useBufferLocking) {
HXLINE( 331)					camera->buffer->unlock(null());
            				}
HXLINE( 334)				camera->screen->dirty = true;
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(CameraFrontEnd_obj,unlock,(void))

void CameraFrontEnd_obj::update(Float elapsed){
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_345_update)
HXDLIN( 345)		int _g = 0;
HXDLIN( 345)		::Array< ::Dynamic> _g1 = this->list;
HXDLIN( 345)		while((_g < _g1->length)){
HXDLIN( 345)			 ::flixel::FlxCamera camera = _g1->__get(_g).StaticCast<  ::flixel::FlxCamera >();
HXDLIN( 345)			_g = (_g + 1);
HXLINE( 347)			bool _hx_tmp;
HXDLIN( 347)			bool _hx_tmp1;
HXDLIN( 347)			if (::hx::IsNotNull( camera )) {
HXLINE( 347)				_hx_tmp1 = camera->exists;
            			}
            			else {
HXLINE( 347)				_hx_tmp1 = false;
            			}
HXDLIN( 347)			if (_hx_tmp1) {
HXLINE( 347)				_hx_tmp = camera->active;
            			}
            			else {
HXLINE( 347)				_hx_tmp = false;
            			}
HXDLIN( 347)			if (_hx_tmp) {
HXLINE( 349)				camera->update(elapsed);
            			}
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC1(CameraFrontEnd_obj,update,(void))

void CameraFrontEnd_obj::resize(){
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_360_resize)
HXDLIN( 360)		int _g = 0;
HXDLIN( 360)		::Array< ::Dynamic> _g1 = this->list;
HXDLIN( 360)		while((_g < _g1->length)){
HXDLIN( 360)			 ::flixel::FlxCamera camera = _g1->__get(_g).StaticCast<  ::flixel::FlxCamera >();
HXDLIN( 360)			_g = (_g + 1);
HXLINE( 362)			camera->onResize();
            		}
            	}


HX_DEFINE_DYNAMIC_FUNC0(CameraFrontEnd_obj,resize,(void))

int CameraFrontEnd_obj::get_bgColor(){
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_368_get_bgColor)
HXDLIN( 368)		if (::hx::IsNull( ::flixel::FlxG_obj::camera )) {
HXDLIN( 368)			return -16777216;
            		}
            		else {
HXDLIN( 368)			return ::flixel::FlxG_obj::camera->bgColor;
            		}
HXDLIN( 368)		return null();
            	}


HX_DEFINE_DYNAMIC_FUNC0(CameraFrontEnd_obj,get_bgColor,return )

int CameraFrontEnd_obj::set_bgColor(int Color){
            	HX_STACKFRAME(&_hx_pos_37a8fd7f84c9d590_372_set_bgColor)
HXLINE( 373)		{
HXLINE( 373)			int _g = 0;
HXDLIN( 373)			::Array< ::Dynamic> _g1 = this->list;
HXDLIN( 373)			while((_g < _g1->length)){
HXLINE( 373)				 ::flixel::FlxCamera camera = _g1->__get(_g).StaticCast<  ::flixel::FlxCamera >();
HXDLIN( 373)				_g = (_g + 1);
HXLINE( 375)				camera->bgColor = Color;
            			}
            		}
HXLINE( 378)		return Color;
            	}


HX_DEFINE_DYNAMIC_FUNC1(CameraFrontEnd_obj,set_bgColor,return )


::hx::ObjectPtr< CameraFrontEnd_obj > CameraFrontEnd_obj::__new() {
	::hx::ObjectPtr< CameraFrontEnd_obj > __this = new CameraFrontEnd_obj();
	__this->__construct();
	return __this;
}

::hx::ObjectPtr< CameraFrontEnd_obj > CameraFrontEnd_obj::__alloc(::hx::Ctx *_hx_ctx) {
	CameraFrontEnd_obj *__this = (CameraFrontEnd_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(CameraFrontEnd_obj), true, "flixel.system.frontEnds.CameraFrontEnd"));
	*(void **)__this = CameraFrontEnd_obj::_hx_vtable;
	__this->__construct();
	return __this;
}

CameraFrontEnd_obj::CameraFrontEnd_obj()
{
}

void CameraFrontEnd_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(CameraFrontEnd);
	HX_MARK_MEMBER_NAME(list,"list");
	HX_MARK_MEMBER_NAME(defaults,"defaults");
	HX_MARK_MEMBER_NAME(cameraAdded,"cameraAdded");
	HX_MARK_MEMBER_NAME(cameraRemoved,"cameraRemoved");
	HX_MARK_MEMBER_NAME(cameraResized,"cameraResized");
	HX_MARK_MEMBER_NAME(useBufferLocking,"useBufferLocking");
	HX_MARK_MEMBER_NAME(_cameraRect,"_cameraRect");
	HX_MARK_END_CLASS();
}

void CameraFrontEnd_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(list,"list");
	HX_VISIT_MEMBER_NAME(defaults,"defaults");
	HX_VISIT_MEMBER_NAME(cameraAdded,"cameraAdded");
	HX_VISIT_MEMBER_NAME(cameraRemoved,"cameraRemoved");
	HX_VISIT_MEMBER_NAME(cameraResized,"cameraResized");
	HX_VISIT_MEMBER_NAME(useBufferLocking,"useBufferLocking");
	HX_VISIT_MEMBER_NAME(_cameraRect,"_cameraRect");
}

::hx::Val CameraFrontEnd_obj::__Field(const ::String &inName,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"add") ) { return ::hx::Val( add_dyn() ); }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"list") ) { return ::hx::Val( list ); }
		if (HX_FIELD_EQ(inName,"fade") ) { return ::hx::Val( fade_dyn() ); }
		if (HX_FIELD_EQ(inName,"lock") ) { return ::hx::Val( lock_dyn() ); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"reset") ) { return ::hx::Val( reset_dyn() ); }
		if (HX_FIELD_EQ(inName,"flash") ) { return ::hx::Val( flash_dyn() ); }
		if (HX_FIELD_EQ(inName,"shake") ) { return ::hx::Val( shake_dyn() ); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"insert") ) { return ::hx::Val( insert_dyn() ); }
		if (HX_FIELD_EQ(inName,"remove") ) { return ::hx::Val( remove_dyn() ); }
		if (HX_FIELD_EQ(inName,"render") ) { return ::hx::Val( render_dyn() ); }
		if (HX_FIELD_EQ(inName,"unlock") ) { return ::hx::Val( unlock_dyn() ); }
		if (HX_FIELD_EQ(inName,"update") ) { return ::hx::Val( update_dyn() ); }
		if (HX_FIELD_EQ(inName,"resize") ) { return ::hx::Val( resize_dyn() ); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"bgColor") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( get_bgColor() ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"defaults") ) { return ::hx::Val( defaults ); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"cameraAdded") ) { return ::hx::Val( cameraAdded ); }
		if (HX_FIELD_EQ(inName,"_cameraRect") ) { return ::hx::Val( _cameraRect ); }
		if (HX_FIELD_EQ(inName,"get_bgColor") ) { return ::hx::Val( get_bgColor_dyn() ); }
		if (HX_FIELD_EQ(inName,"set_bgColor") ) { return ::hx::Val( set_bgColor_dyn() ); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"cameraRemoved") ) { return ::hx::Val( cameraRemoved ); }
		if (HX_FIELD_EQ(inName,"cameraResized") ) { return ::hx::Val( cameraResized ); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"useBufferLocking") ) { return ::hx::Val( useBufferLocking ); }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"setDefaultDrawTarget") ) { return ::hx::Val( setDefaultDrawTarget_dyn() ); }
	}
	return super::__Field(inName,inCallProp);
}

::hx::Val CameraFrontEnd_obj::__SetField(const ::String &inName,const ::hx::Val &inValue,::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"list") ) { list=inValue.Cast< ::Array< ::Dynamic> >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"bgColor") ) { if (inCallProp == ::hx::paccAlways) return ::hx::Val( set_bgColor(inValue.Cast< int >()) ); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"defaults") ) { defaults=inValue.Cast< ::Array< ::Dynamic> >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"cameraAdded") ) { cameraAdded=inValue.Cast<  ::flixel::util::_FlxSignal::FlxSignal1 >(); return inValue; }
		if (HX_FIELD_EQ(inName,"_cameraRect") ) { _cameraRect=inValue.Cast<  ::openfl::geom::Rectangle >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"cameraRemoved") ) { cameraRemoved=inValue.Cast<  ::flixel::util::_FlxSignal::FlxSignal1 >(); return inValue; }
		if (HX_FIELD_EQ(inName,"cameraResized") ) { cameraResized=inValue.Cast<  ::flixel::util::_FlxSignal::FlxSignal1 >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"useBufferLocking") ) { useBufferLocking=inValue.Cast< bool >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void CameraFrontEnd_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_("list",5e,1c,b3,47));
	outFields->push(HX_("defaults",92,d0,99,af));
	outFields->push(HX_("bgColor",5e,81,83,f7));
	outFields->push(HX_("cameraAdded",db,c7,89,10));
	outFields->push(HX_("cameraRemoved",7b,4f,fd,fa));
	outFields->push(HX_("cameraResized",cb,8b,70,6b));
	outFields->push(HX_("useBufferLocking",f0,43,3c,76));
	outFields->push(HX_("_cameraRect",88,43,4f,84));
	super::__GetFields(outFields);
};

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo CameraFrontEnd_obj_sMemberStorageInfo[] = {
	{::hx::fsObject /* ::Array< ::Dynamic> */ ,(int)offsetof(CameraFrontEnd_obj,list),HX_("list",5e,1c,b3,47)},
	{::hx::fsObject /* ::Array< ::Dynamic> */ ,(int)offsetof(CameraFrontEnd_obj,defaults),HX_("defaults",92,d0,99,af)},
	{::hx::fsObject /*  ::flixel::util::_FlxSignal::FlxSignal1 */ ,(int)offsetof(CameraFrontEnd_obj,cameraAdded),HX_("cameraAdded",db,c7,89,10)},
	{::hx::fsObject /*  ::flixel::util::_FlxSignal::FlxSignal1 */ ,(int)offsetof(CameraFrontEnd_obj,cameraRemoved),HX_("cameraRemoved",7b,4f,fd,fa)},
	{::hx::fsObject /*  ::flixel::util::_FlxSignal::FlxSignal1 */ ,(int)offsetof(CameraFrontEnd_obj,cameraResized),HX_("cameraResized",cb,8b,70,6b)},
	{::hx::fsBool,(int)offsetof(CameraFrontEnd_obj,useBufferLocking),HX_("useBufferLocking",f0,43,3c,76)},
	{::hx::fsObject /*  ::openfl::geom::Rectangle */ ,(int)offsetof(CameraFrontEnd_obj,_cameraRect),HX_("_cameraRect",88,43,4f,84)},
	{ ::hx::fsUnknown, 0, null()}
};
static ::hx::StaticInfo *CameraFrontEnd_obj_sStaticStorageInfo = 0;
#endif

static ::String CameraFrontEnd_obj_sMemberFields[] = {
	HX_("list",5e,1c,b3,47),
	HX_("defaults",92,d0,99,af),
	HX_("cameraAdded",db,c7,89,10),
	HX_("cameraRemoved",7b,4f,fd,fa),
	HX_("cameraResized",cb,8b,70,6b),
	HX_("useBufferLocking",f0,43,3c,76),
	HX_("_cameraRect",88,43,4f,84),
	HX_("add",21,f2,49,00),
	HX_("insert",39,43,dd,9d),
	HX_("remove",44,9c,88,04),
	HX_("setDefaultDrawTarget",94,14,3f,93),
	HX_("reset",cf,49,c8,e6),
	HX_("flash",b0,35,8c,02),
	HX_("fade",7c,b5,b5,43),
	HX_("shake",c6,de,1c,7c),
	HX_("lock",eb,9b,b7,47),
	HX_("render",56,6b,29,05),
	HX_("unlock",c4,a2,8c,65),
	HX_("update",09,86,05,87),
	HX_("resize",f4,59,7b,08),
	HX_("get_bgColor",75,e1,7d,7d),
	HX_("set_bgColor",81,e8,ea,87),
	::String(null()) };

::hx::Class CameraFrontEnd_obj::__mClass;

void CameraFrontEnd_obj::__register()
{
	CameraFrontEnd_obj _hx_dummy;
	CameraFrontEnd_obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("flixel.system.frontEnds.CameraFrontEnd",31,94,3d,41);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &::hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(CameraFrontEnd_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TCanCast< CameraFrontEnd_obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = CameraFrontEnd_obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = CameraFrontEnd_obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace flixel
} // end namespace system
} // end namespace frontEnds
