package com.taomee.seer2.core.module {
import com.taomee.seer2.core.utils.LifecycleType;
import com.taomee.seer2.core.utils.ObjectUtil;
import com.taomee.seer2.core.utils.StringConstants;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;

import org.taomee.ds.HashMap;

public class ModuleManager {

    public static var hasHideMap:Boolean = false;

    public static var topNum:uint;

    private static var _moduleMap:HashMap = new HashMap();

    private static var _moduleDirty:Boolean;

    private static var _eventDispatcher:EventDispatcher = new EventDispatcher();


    public function ModuleManager() {
        super();
    }

    public static function setup(param1:Stage):void {
        var stage:Stage = param1;
        stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        stage.addEventListener(Event.RESIZE, function (param1:Event):void {
            _moduleDirty = true;
        });
    }

    private static function enterFrameHandler(param1:Event):void {
        if (_moduleDirty) {
            _moduleMap.eachValue(resizeHandler);
            _moduleDirty = false;
        }
    }

    private static function resizeHandler(param1:ModuleProxy):void {
        if (Boolean(param1.module) && Boolean(param1.module.stage)) {
            param1.module.align();
        }
    }

    public static function contains(param1:String, param2:String = ""):Boolean {
        return _moduleMap.containsKey(param1 + param2);
    }

    public static function getModuleStatus(param1:String, param2:String = ""):String {
        var _loc3_:ModuleProxy = _moduleMap.getValue(param1 + param2);
        if (_loc3_) {
            return _loc3_.hasParent ? ModuleProxy.SHOW : ModuleProxy.HIDE;
        }
        return ModuleProxy.CLOSE;
    }

    public static function getModule(param1:String, param2:String = ""):ModuleProxy {
        var _loc3_:ModuleProxy = _moduleMap.getValue(param1 + param2);
        if (_loc3_) {
            return _loc3_;
        }
        return null;
    }

    public static function showModule(param1:String, param2:String, param3:Object = null, param4:String = ""):void {
        var _loc5_:ModuleProxy;
        if ((_loc5_ = _moduleMap.getValue(URLUtil.getFileName(param1) + param4)) != null) {
            _loc5_.init(param3);
            _loc5_.show();
        } else {
            createModule(param1, param2, param3, param4);
        }
    }

    public static function toggleModule(param1:String, param2:String = "打开面板中...", param3:Object = null, param4:String = ""):void {
        var _loc5_:ModuleProxy;
        if (_loc5_ = _moduleMap.getValue(URLUtil.getFileName(param1) + param4)) {
            if (_loc5_.state == ModuleProxy.SHOW) {
                _loc5_.hide();
            } else {
                _loc5_.init(param3);
                _loc5_.show();
            }
        } else {
            createModule(param1, param2, param3, param4);
        }
    }

    private static function createModule(param1:String, param2:String, param3:Object = null, param4:String = ""):void {
        var _loc5_:String = (_loc5_ = param1.replace("module/app/", "")).slice(0, _loc5_.indexOf("."));
        if (ModulesToRemoveXMLInfo.checkIsModuleToRemove(_loc5_)) {
            return;
        }
        var _loc6_:ModuleProxy;
        (_loc6_ = new ModuleProxy(param1, param2, param4)).init(param3);
        _loc6_.show();
        var _loc7_:String = URLUtil.getFileName(param1);
        if (_moduleMap.containsKey(_loc7_ + param4)) {
            throw new Error("模块名有冲突");
        }
        _moduleMap.add(_loc7_ + param4, _loc6_);
    }

    public static function closeAll():void {
        _moduleMap.eachValue(function (param1:ModuleProxy):void {
            if (param1.lifecycleType == LifecycleType.NONCE || param1.lifecycleType == LifecycleType.MAP) {
                param1.dispose();
            } else {
                param1.hide();
            }
        });
    }

    public static function removeForName(param1:String, param2:String = ""):void {
        _moduleMap.remove(param1 + param2);
    }

    public static function disposeForLifecycle(param1:String):void {
        var lifecycleType:String = param1;
        _moduleMap.eachValue(function (param1:ModuleProxy):void {
            if (param1.lifecycleType == lifecycleType) {
                param1.dispose();
            }
        });
    }

    public static function hideForLifecycle(param1:String):void {
        var lifecycleType:String = param1;
        _moduleMap.eachValue(function (param1:ModuleProxy):void {
            if (param1.lifecycleType == lifecycleType) {
                param1.hide();
            }
        });
    }

    public static function showAppModule(param1:String, param2:Object = null):void {
        ModuleManager.toggleModule(URLUtil.getAppModule(param1), "打开面板中...", param2);
    }

    public static function disposeForName(param1:String, param2:String = ""):void {
        var _loc3_:ModuleProxy = _moduleMap.remove(param1 + param2);
        if (_loc3_) {
            _loc3_.dispose();
        }
    }

    public static function disposeForInstance(param1:Object, param2:String = ""):void {
        disposeForName(ObjectUtil.getClassName(param1) + param2);
    }

    public static function closeForName(param1:String, param2:String = ""):void {
        var _loc3_:ModuleProxy = _moduleMap.getValue(param1 + param2);
        if (_loc3_) {
            if (_loc3_.lifecycleType == LifecycleType.NONCE) {
                _moduleMap.remove(param1 + param2);
                _loc3_.dispose();
            } else {
                _loc3_.hide();
            }
        }
    }

    public static function closeForInstance(param1:Object, param2:String = ""):void {
        closeForName(ObjectUtil.getClassName(param1) + param2);
    }

    public static function addEventListener(param1:String, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false):void {
        _eventDispatcher.addEventListener(param1 + StringConstants.SIGN + param2, param3, param4, param5, param6);
    }

    public static function addEventListener1(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _eventDispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:String, param3:Function, param4:Boolean = false):void {
        _eventDispatcher.removeEventListener(param1 + StringConstants.SIGN + param2, param3, param4);
    }

    public static function dispatchEvent1(param1:String, param2:String, param3:* = null):void {
        if (_eventDispatcher.hasEventListener(param2)) {
            _eventDispatcher.dispatchEvent(new ModuleEvent(param1, param2, param3));
        }
    }

    public static function dispatchEvent(param1:String, param2:String, param3:* = null):void {
        if (_eventDispatcher.hasEventListener(param1 + StringConstants.SIGN + param2)) {
            _eventDispatcher.dispatchEvent(new ModuleEvent(param1, param2, param3));
        }
    }

    public static function hasEventListener(param1:String, param2:String):Boolean {
        return _eventDispatcher.hasEventListener(param1 + StringConstants.SIGN + param2);
    }
}
}
