package com.taomee.seer2.core.entity.handler {
import com.taomee.seer2.core.entity.definition.EntityDefinition;

import flash.events.Event;

public interface IEntityEventHandler {


    function set type(param1:String):void;

    function get type():String;

    function setEntityDefinition(param1:EntityDefinition):void;

    function initData(param1:XML):void;

    function onEvent(param1:Event):void;
}
}
