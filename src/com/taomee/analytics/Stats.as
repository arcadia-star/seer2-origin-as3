package com.taomee.analytics {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.ContextMenuEvent;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.system.System;
import flash.text.StyleSheet;
import flash.text.TextField;
import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;
import flash.utils.ByteArray;
import flash.utils.getTimer;

internal class Stats extends Sprite {


    private var _memMaxGraph:uint;

    private var _fpsPrev:uint;

    private var _text:TextField;

    private var _mem:uint;

    private const WIDTH:uint = 80;

    private const HEIGHT:uint = 100;

    private var _fps:uint;

    private var _style:StyleSheet;

    private var _rect:Rectangle;

    private var _fpsGraph:uint;

    private var _timer:uint;

    private const theme:Object = {
        "bg": 0,
        "fps": 16776960,
        "mem": 65535,
        "memMax": 15597568
    };

    private var _graph:Bitmap;

    private var _memList:Array;

    private var _xml:XML;

    private var _memGraph:uint;

    private var _fpsList:Array;

    private var _memPrev:uint;

    private var _memMax:uint;

    private var _stage:Stage;

    public function Stats() {
        _fpsList = [];
        _memList = [];
        super();
        mouseChildren = false;
        graphics.beginFill(theme.bg);
        graphics.drawRect(0, 0, WIDTH, HEIGHT);
        graphics.endFill();
        createContextMenu();
    }

    private function updateView(param1:uint, param2:uint, param3:uint):void {
        if (stage) {
            _fpsGraph = Math.min(_graph.height, param1 / _stage.frameRate * _graph.height);
            _memGraph = Math.min(_graph.height, Math.sqrt(Math.sqrt(param2 * 5000))) - 2;
            _memMaxGraph = Math.min(_graph.height, Math.sqrt(Math.sqrt(param3 * 5000))) - 2;
            _graph.bitmapData.scroll(-1, 0);
            _graph.bitmapData.fillRect(_rect, theme.bg);
            _graph.bitmapData.setPixel(_graph.width - 1, _graph.height - _fpsGraph, theme.fps);
            _graph.bitmapData.setPixel(_graph.width - 1, _graph.height - _memGraph, theme.mem);
            _graph.bitmapData.setPixel(_graph.width - 1, _graph.height - _memMaxGraph, theme.memMax);
            _xml.fps = "fps: " + param1 + " / " + _stage.frameRate;
            _xml.mem = "mem: " + param2;
            _xml.memMax = "memMax: " + param3;
            _text.htmlText = _xml;
        }
    }

    private function init():void {
        _fpsPrev = getTimer();
        _memPrev = getTimer();
        _stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function createContextMenu():void {
        var _loc1_:ContextMenu = null;
        var _loc2_:ContextMenuItem = null;
        if ("isSupported" in ContextMenu) {
            if (ContextMenu["isSupported"]) {
                _loc1_ = new ContextMenu();
                _loc1_.hideBuiltInItems();
                _loc2_ = new ContextMenuItem("复制数据");
                _loc2_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onContextMenu);
                _loc1_.customItems.push(_loc2_);
                contextMenu = _loc1_;
            }
        }
    }

    private function onDeactivate(param1:Event):void {
        _stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    public function getMemoryBytes():ByteArray {
        var _loc2_:uint = 0;
        var _loc1_:ByteArray = new ByteArray();
        for each(_loc2_ in _memList) {
            _loc1_.writeShort(_loc2_);
        }
        _loc1_.position = 0;
        return _loc1_;
    }

    private function onEnterFrame(param1:Event):void {
        _timer = getTimer();
        if (_timer - 1000 > _fpsPrev) {
            _fpsPrev = _timer;
            if (_fpsList.length >= 1000) {
                _fpsList.shift();
            }
            _fpsList.push(uint(_fps / _stage.frameRate * 100));
            updateView(_fps, _mem, _memMax);
            _fps = 0;
        }
        ++_fps;
        if (_timer - 10000 > _memPrev) {
            _memPrev = _timer;
            if (_memList.length >= 1000) {
                _memList.shift();
            }
            _mem = uint(System.totalMemory * 9.54e-7);
            _memMax = _memMax > _mem ? _memMax : _mem;
            _memList.push(_mem);
        }
    }

    public function hide():void {
        if (parent) {
            parent.removeChild(this);
            while (numChildren) {
                removeChildAt(0);
            }
            if (_graph) {
                if (_graph.bitmapData) {
                    _graph.bitmapData.dispose();
                }
            }
            _xml = null;
            _text = null;
            _style = null;
            _graph = null;
            _rect = null;
            return;
        }
    }

    private function onContextMenu(param1:ContextMenuEvent):void {
        var _loc2_:* = "fps: " + _fpsList.join(" ");
        _loc2_ += "\n";
        _loc2_ += "mem:" + _memList.join(" ");
        System.setClipboard(_loc2_);
    }

    public function getEqualityFps():int {
        var _loc1_:int = 0;
        var _loc2_:uint = 0;
        for each(_loc2_ in _fpsList) {
            _loc1_ += _loc2_;
        }
        return int(_loc1_ / _fpsList.length);
    }

    public function start(param1:Stage):void {
        _stage = param1;
        init();
        _stage.addEventListener(Event.DEACTIVATE, onDeactivate);
        _stage.addEventListener(Event.ACTIVATE, onActivate);
    }

    private function hex2css(param1:int):String {
        return "#" + param1.toString(16);
    }

    private function onActivate(param1:Event):void {
        init();
    }

    public function getFpsBytes():ByteArray {
        var _loc2_:uint = 0;
        var _loc1_:ByteArray = new ByteArray();
        for each(_loc2_ in _fpsList) {
            _loc1_.writeByte(_loc2_);
        }
        _loc1_.position = 0;
        return _loc1_;
    }

    public function show(param1:DisplayObjectContainer):void {
        if (parent) {
            if (param1 != parent) {
                param1.addChild(this);
            }
            return;
        }
        _xml = <xml>
            <fps>FPS:</fps>
            <mem>MEM:</mem>
            <memMax>MAX:</memMax>
        </xml>;
        _style = new StyleSheet();
        _style.setStyle("xml", {
            "fontSize": "11px",
            "fontFamily": "_sans"
        });
        _style.setStyle("fps", {"color": hex2css(theme.fps)});
        _style.setStyle("mem", {"color": hex2css(theme.mem)});
        _style.setStyle("memMax", {"color": hex2css(theme.memMax)});
        _text = new TextField();
        _text.width = WIDTH;
        _text.height = 50;
        _text.styleSheet = _style;
        _text.condenseWhite = true;
        _text.selectable = false;
        addChild(_text);
        _graph = new Bitmap();
        _graph.y = _text.height;
        _rect = new Rectangle(WIDTH - 1, 0, 1, HEIGHT - _text.height);
        addChild(_graph);
        _graph.bitmapData = new BitmapData(WIDTH, HEIGHT - _text.height, false, theme.bg);
        param1.addChild(this);
    }
}
}
