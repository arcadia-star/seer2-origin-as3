package com.taomee.seer2.app.actor.attach {
import com.taomee.seer2.app.actor.Actor;

public interface IActorAttach {


    function attach(param1:Actor):void;

    function detach():void;

    function excute(param1:*):void;

    function get type():String;
}
}
