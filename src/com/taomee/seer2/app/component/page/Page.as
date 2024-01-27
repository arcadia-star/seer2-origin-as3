package com.taomee.seer2.app.component.page {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Page extends Sprite {

    public static const SELECT_ITEM_CHANGE:String = "selectItemChange";

    public static const PAGE_INDEX_CHANGE:String = "pageIndexChange";


    protected var _mainUI:MovieClip;

    protected var _itemVec:Vector.<PageItem>;

    private var _itemCls:Class;

    protected var _dataArr:Array;

    protected var _pageCount:int;

    protected var _selectedIndex:int;

    protected var _selectable:Boolean;

    public function Page(param1:MovieClip, param2:Class, param3:PageLayoutInfo, param4:Boolean = false) {
        super();
        this._mainUI = param1;
        addChild(this._mainUI);
        this._itemCls = param2;
        this._pageCount = param3.count;
        this._selectable = param4;
        this._selectedIndex = -1;
        this.createItemVec(param3);
        this.initEventListener();
    }

    private function createItemVec(param1:PageLayoutInfo):void {
        var _loc3_:PageItem = null;
        this._itemVec = new Vector.<PageItem>();
        var _loc2_:int = 0;
        while (_loc2_ < this._pageCount) {
            _loc3_ = new this._itemCls(this._selectable);
            _loc3_.x = param1.caculatePostion(_loc2_).x;
            _loc3_.y = param1.caculatePostion(_loc2_).y;
            this._mainUI.addChild(_loc3_);
            this._itemVec.push(_loc3_);
            _loc2_++;
        }
    }

    private function initEventListener():void {
        var _loc1_:int = 0;
        if (this._selectable) {
            _loc1_ = 0;
            while (_loc1_ < this._pageCount) {
                this._itemVec[_loc1_].addEventListener(MouseEvent.CLICK, this.onItemClick);
                _loc1_++;
            }
        }
    }

    private function onItemClick(param1:MouseEvent):void {
        var _loc2_:PageItem = param1.currentTarget as PageItem;
        var _loc3_:int = 0;
        while (_loc3_ < this._pageCount) {
            if (_loc2_ == this._itemVec[_loc3_]) {
                this._selectedIndex = this.offset + _loc3_;
                break;
            }
            _loc3_++;
        }
        this.updateSelectedItem();
        dispatchEvent(new Event(SELECT_ITEM_CHANGE));
    }

    public function clear():void {
        var _loc1_:int = 0;
        while (_loc1_ < this._pageCount) {
            this._itemVec[_loc1_].clear();
            _loc1_++;
        }
        this.selectedIndex = -1;
    }

    public function update(param1:*):void {
        this._dataArr = param1;
        this._selectedIndex = -1;
        this.updateDisplay();
    }

    protected function updateDisplay():void {
        var _loc2_:int = 0;
        var _loc1_:int = 0;
        while (_loc1_ < this._pageCount) {
            _loc2_ = this.offset + _loc1_;
            if (_loc2_ < this._dataArr.length) {
                this._itemVec[_loc1_].update(this._dataArr[_loc2_]);
            } else {
                this._itemVec[_loc1_].update(null);
            }
            _loc1_++;
        }
        if (this._selectable) {
            this.updateSelectedItem();
        }
    }

    public function set selectedIndex(param1:int):void {
        if (this._selectable) {
            this._selectedIndex = param1;
            this.updateSelectedItem();
        }
    }

    protected function updateSelectedItem():void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc1_:int = this._selectedIndex - this.offset;
        if (_loc1_ >= 0 && _loc1_ < this._pageCount) {
            _loc2_ = 0;
            while (_loc2_ < this._itemVec.length) {
                this._itemVec[_loc2_].isSelected = _loc1_ == _loc2_;
                _loc2_++;
            }
        } else {
            _loc3_ = 0;
            while (_loc3_ < this._itemVec.length) {
                this._itemVec[_loc3_].isSelected = false;
                _loc3_++;
            }
        }
    }

    public function dispose():void {
        var _loc1_:PageItem = null;
        for each(_loc1_ in this._itemVec) {
            _loc1_.dispose();
        }
    }

    public function get offset():int {
        return 0;
    }

    public function get pageCount():int {
        return this._pageCount;
    }

    public function get selectedData():* {
        return this._selectedIndex != -1 ? this._dataArr[this._selectedIndex] : null;
    }
}
}
