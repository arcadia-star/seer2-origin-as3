package com.taomee.seer2.app.gameRule.spt.support {
public class SptDialogInfo {


    public var bossId:uint;

    public var talks:Vector.<String>;

    public var content:Vector.<SptDialogContentInfo>;

    protected var _talk_index:uint = 0;

    public function SptDialogInfo() {
        super();
        this.talks = new Vector.<String>();
        this.content = new Vector.<SptDialogContentInfo>();
    }

    public function getTalkContent():String {
        var _loc1_:String = this.talks[this._talk_index];
        ++this._talk_index;
        if (this._talk_index > this.talks.length - 1) {
            this._talk_index = 0;
        }
        return _loc1_;
    }

    public function getDialogContent(param1:uint, param2:Array):String {
        var _loc4_:String = null;
        var _loc3_:uint = this.content.length;
        var _loc5_:uint = 0;
        while (_loc5_ < _loc3_) {
            if (this.content[_loc5_].id == param1) {
                _loc4_ = this.content[_loc5_].getContent(param2);
                break;
            }
            _loc5_++;
        }
        return _loc4_;
    }

    public function setUpTalks(param1:XMLList):void {
        var _loc2_:XMLList = param1["talk"];
        var _loc3_:uint = uint(_loc2_.length());
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            this.talks.push(XML(_loc2_[_loc4_]).attribute("content"));
            _loc4_++;
        }
    }

    public function setUpContents(param1:XMLList):void {
        var _loc5_:SptDialogContentInfo = null;
        var _loc2_:XMLList = param1["sptDialog"];
        var _loc3_:uint = uint(_loc2_.length());
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            (_loc5_ = new SptDialogContentInfo()).id = uint(XML(_loc2_[_loc4_]).attribute("id"));
            _loc5_.content = XML(XML(_loc2_[_loc4_])["dialog"]).toXMLString();
            this.content.push(_loc5_);
            _loc4_++;
        }
    }
}
}
