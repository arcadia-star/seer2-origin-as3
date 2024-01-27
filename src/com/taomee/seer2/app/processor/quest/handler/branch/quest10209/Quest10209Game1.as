package com.taomee.seer2.app.processor.quest.handler.branch.quest10209 {
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.utils.setTimeout;

import org.taomee.utils.DisplayUtil;

public class Quest10209Game1 {


    private var _mc:MovieClip;

    private var _comFun:Function;

    private var _point1List:Vector.<MovieClip>;

    private var _point2List:Vector.<MovieClip>;

    private var _yesList:Vector.<MovieClip>;

    private var _yes2List:Vector.<MovieClip>;

    private var _helpList:Vector.<MovieClip>;

    private var _help2List:Vector.<MovieClip>;

    private var _helpBtn:SimpleButton;

    private var _closeBtn:SimpleButton;

    private var _yes1Num:uint;

    private var _yes2Num:uint;

    private var _setTime:uint;

    public function Quest10209Game1(param1:MovieClip, param2:Function) {
        super();
        this._mc = param1;
        this._yes1Num = 0;
        this._yes2Num = 0;
        this._comFun = param2;
        this._helpBtn = param1["helpBtn"];
        this._helpBtn.addEventListener(MouseEvent.CLICK, this.onHelp);
        this._closeBtn = param1["closeBtn"];
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
        this._yesList = Vector.<MovieClip>([]);
        this._yes2List = Vector.<MovieClip>([]);
        this._helpList = Vector.<MovieClip>([]);
        this._help2List = Vector.<MovieClip>([]);
        this._point1List = Vector.<MovieClip>([]);
        this._point2List = Vector.<MovieClip>([]);
        var _loc3_:int = 0;
        while (_loc3_ < 2) {
            this._yesList.push(param1["yes" + _loc3_]);
            this._yesList[_loc3_].visible = false;
            this._yes2List.push(param1["yesTwo" + _loc3_]);
            this._yes2List[_loc3_].visible = false;
            this._helpList.push(param1["help" + _loc3_]);
            this._helpList[_loc3_].visible = false;
            this._help2List.push(param1["helpTwo" + _loc3_]);
            this._help2List[_loc3_].visible = false;
            this._point1List.push(param1["pointOne" + _loc3_]);
            this._point2List.push(param1["pointTwo" + _loc3_]);
            this._point1List[_loc3_].addEventListener(MouseEvent.CLICK, this.onPoint);
            this._point2List[_loc3_].addEventListener(MouseEvent.CLICK, this.onPoint);
            _loc3_++;
        }
    }

    private function onHelp(param1:MouseEvent):void {
        if (this._yes1Num == 0) {
            this._helpList[0].visible = true;
            this._help2List[0].visible = true;
        }
        if (this._yes2Num == 0) {
            this._helpList[1].visible = true;
            this._help2List[1].visible = true;
        }
    }

    private function onPoint(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        var index:int = this._point1List.indexOf(event.currentTarget as MovieClip);
        if (index == -1) {
            index = this._point2List.indexOf(event.currentTarget as MovieClip);
        }
        this._point1List[index].removeEventListener(MouseEvent.CLICK, this.onPoint);
        this._point2List[index].removeEventListener(MouseEvent.CLICK, this.onPoint);
        this._yesList[index].visible = true;
        this._yes2List[index].visible = true;
        this._helpList[index].visible = false;
        this._help2List[index].visible = false;
        if (index == 0) {
            ++this._yes1Num;
        } else {
            ++this._yes2Num;
        }
        if (this._yes1Num >= 1 && this._yes2Num >= 1) {
            this._setTime = setTimeout(function ():void {
                _comFun();
                onClose(null);
            }, 1500);
        }
    }

    private function onClose(param1:MouseEvent):void {
        this._helpBtn.removeEventListener(MouseEvent.CLICK, this.onHelp);
        this._closeBtn.removeEventListener(MouseEvent.CLICK, this.onClose);
        this._point1List[0].removeEventListener(MouseEvent.CLICK, this.onPoint);
        this._point2List[0].removeEventListener(MouseEvent.CLICK, this.onPoint);
        this._point1List[1].removeEventListener(MouseEvent.CLICK, this.onPoint);
        this._point2List[1].removeEventListener(MouseEvent.CLICK, this.onPoint);
        DisplayUtil.removeForParent(this._mc);
    }
}
}
