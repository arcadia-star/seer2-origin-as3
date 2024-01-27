package com.taomee.seer2.app.arena.controller {
import com.taomee.seer2.app.arena.Fighter;

import flash.display.Sprite;

public interface IArenaUIController {


    function dispose():void;

    function startActiveFighter():void;

    function startSelectOperate():void;

    function getContent():Sprite;

    function activeControlPetPanel(param1:Fighter):void;

    function showFighterPanel():void;

    function showSkillPanel():void;

    function updateControlledFighter(param1:Fighter):void;

    function updateOppositeFighter():void;

    function itemPanelUpdate():void;

    function updateStatusPanelInfo():void;

    function updateStatusPanel():void;

    function updateAngerBar():void;

    function entryValue(param1:String):void;

    function layOut():void;

    function hideSkillPanel():void;

    function showSkillBubble(param1:Fighter, param2:String):void;

    function changeTeam(param1:String, param2:uint, param3:uint):void;
}
}
