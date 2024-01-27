package com.taomee.seer2.app.utils {
import com.taomee.seer2.app.config.AnimationDialog;
import com.taomee.seer2.app.config.info.AnimationBaseInfo;
import com.taomee.seer2.app.config.info.AnimationInfo;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.sound.SoundManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import org.taomee.utils.DisplayUtil;

public class MovieClipUtil {

    private static var _swfLoaderVec:Vector.<MovieClipUtilLoader>;

    private static var _assetIndex:int;

    private static var _assetCount:int;

    private static var _assetVec:Vector.<DisplayObject>;

    private static var _assetCallBack:Function;

    private static var _assetHolder:MovieClip;

    private static var _mcList:Vector.<MovieClip> = Vector.<MovieClip>([]);

    private static var _callBackList:Vector.<Function> = Vector.<Function>([]);

    private static var _indexList:Vector.<int> = Vector.<int>([]);

    private static var _fullScreenMc:MovieClip;

    private static var _isColseSound:Boolean;

    private static var _hasFullScreenSkipBtn:Boolean;

    private static var _fullScreenCallBack:Function;

    private static var _fullScreenSkipBtn:SimpleButton;

    private static var _npcTalkCallBack:Function;

    private static var _npcTalkAnimation:MovieClip;

    private static var _npcTalkIndex:int;

    private static var _npcTalkContentCallBack:Function;

    private static var _npcTalkContent:MovieClip;

    private static var _npcTalkBtn:SimpleButton;

    private static const NPC_TALK_BTN_ARR:Array = [[773, 480], [784, 410]];

    private static var _talkBtn:SimpleButton = UIManager.getButton("UI_NpcTalkBtn");

    private static var _talkContent:MovieClip;

    private static var _talkArr:Array;

    private static var _talkTotal:int;

    private static var _talkIndex:int;

    private static var _talkCallBack:Function;

    private static var _hasClickArea:Boolean;

    private static var _clickArea:MovieClip;

    private static var _hahaContent:MovieClip;

    private static var _hahaTalkCallBack:Function;

    private static var _hahaBtn:SimpleButton;

    private static var _hahaCount:int;

    private static var _hahaIndex:int;

    private static var _yesCallBack:Function;

    private static var _noCallBack:Function;

    private static var _selectTalkContent:MovieClip;

    private static var _selectList:Vector.<SimpleButton>;

    private static var _allSelectList:Vector.<SimpleButton>;

    private static var _clearBtn:SimpleButton;

    private static var _clearFun:Function;

    private static var _selectTalkInfo:AnimationInfo;

    private static var _currBaseInfo:AnimationBaseInfo;

    private static var _selectTalkIndex:int;

    private static var cartoonIndex:int;

    private static var cartoonMc:MovieClip;

    private static var cartoonOut:uint;

    private static var cartoonCallBack:Function;

    private static var maxCartoonNum:uint;

    {
        staticInit();
    }

    public function MovieClipUtil() {
        super();
    }

    private static function staticInit():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_START, onMapStart);
    }

    private static function onMapStart(param1:SceneEvent):void {
        cancelAllLoader();
    }

    public static function getSwfContent(param1:String, param2:Function, param3:String = ""):void {
        if (_swfLoaderVec == null) {
            _swfLoaderVec = new Vector.<MovieClipUtilLoader>();
        }
        _swfLoaderVec.push(new MovieClipUtilLoader(param1, param2, param3));
    }

    private static function cancelAllLoader():void {
        var _loc1_:MovieClipUtilLoader = null;
        if (_swfLoaderVec != null) {
            for each(_loc1_ in _swfLoaderVec) {
                _loc1_.cancel();
            }
            _swfLoaderVec = null;
        }
    }

    public static function getChildList(param1:MovieClip, param2:*, param3:Array, param4:Function):void {
        var mc:MovieClip = param1;
        var frame:* = param2;
        var childArr:Array = param3;
        var callBack:Function = param4;
        mc.addEventListener(Event.FRAME_CONSTRUCTED, function (param1:Event):void {
            var _loc4_:Vector.<DisplayObject> = null;
            var _loc5_:int = 0;
            var _loc6_:DisplayObject = null;
            var _loc3_:* = false;
            if (frame is int) {
                _loc3_ = int(frame) == mc.currentFrame;
            } else if (frame is String) {
                _loc3_ = String(frame) == mc.currentLabel;
            }
            if (_loc3_) {
                mc.removeEventListener(Event.FRAME_CONSTRUCTED, arguments.callee);
                _loc4_ = new Vector.<DisplayObject>();
                _loc5_ = 0;
                while (_loc5_ < childArr.length) {
                    if (childArr[_loc5_] is int) {
                        _loc4_.push(mc.getChildAt(int(childArr[_loc5_])));
                    } else if (childArr[_loc5_] is String) {
                        _loc4_.push(mc.getChildByName(String(childArr[_loc5_])));
                    }
                    _loc5_++;
                }
                callBack(_loc4_);
            }
        });
        mc.gotoAndStop(frame);
    }

    public static function extractAssests(param1:MovieClip, param2:*, param3:int, param4:Function):void {
        var mc:MovieClip = param1;
        var frame:* = param2;
        var count:int = param3;
        var callBack:Function = param4;
        _assetCount = count;
        _assetCallBack = callBack;
        _assetVec = new Vector.<DisplayObject>();
        MovieClipUtil.getChildList(mc, frame, [0], function (param1:Vector.<DisplayObject>):void {
            _assetHolder = param1[0] as MovieClip;
            _assetIndex = 0;
            extractAssestsHelper();
        });
    }

    private static function extractAssestsHelper():void {
        if (_assetIndex == _assetCount) {
            _assetCallBack(_assetVec);
        } else {
            ++_assetIndex;
            MovieClipUtil.getChildList(_assetHolder, _assetIndex, [0], function (param1:Vector.<DisplayObject>):void {
                var _loc3_:Point = null;
                var _loc2_:DisplayObject = param1[0];
                _loc3_ = _loc2_.parent.localToGlobal(new Point(_loc2_.x, _loc2_.y));
                _loc2_.x = _loc3_.x;
                _loc2_.y = _loc3_.y;
                _assetVec.push(_loc2_);
                extractAssestsHelper();
            });
        }
    }

    public static function getChild(param1:MovieClip, param2:*, param3:*, param4:Function):void {
        var mc:MovieClip = param1;
        var frame:* = param2;
        var child:* = param3;
        var callBack:Function = param4;
        mc.addEventListener(Event.FRAME_CONSTRUCTED, function (param1:Event):void {
            var _loc3_:* = false;
            if (frame is int) {
                _loc3_ = int(frame) == mc.currentFrame;
            } else if (frame is String) {
                _loc3_ = String(frame) == mc.currentLabel;
            }
            if (_loc3_) {
                mc.removeEventListener(Event.FRAME_CONSTRUCTED, arguments.callee);
                if (child is int) {
                    callBack(mc.getChildAt(int(child)));
                } else if (child is String) {
                    callBack(mc.getChildByName(String(child)));
                }
            }
        });
        mc.gotoAndStop(frame);
    }

    public static function playMcList(param1:MovieClip, param2:*, param3:*, param4:Function = null, param5:int = 0):void {
        _mcList.push(param1);
        _callBackList.push(param4);
        _indexList.push(param5);
        playList(param1);
    }

    private static function playList(param1:MovieClip):void {
        var mc:MovieClip = param1;
        mc.gotoAndPlay(2);
        mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            if (mc.currentFrame == mc.totalFrames) {
                mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                mc.gotoAndStop(mc.totalFrames);
                _callBackList[_mcList.indexOf(mc)](_indexList[_mcList.indexOf(mc)]);
                DisplayUtil.removeForParent(mc);
            }
        });
    }

    public static function playMc(param1:MovieClip, param2:*, param3:*, param4:Function = null, param5:Boolean = false):void {
        var mc:MovieClip = param1;
        var startFrame:* = param2;
        var endFrame:* = param3;
        var callBack:Function = param4;
        var focusLayer:Boolean = param5;
        mc.gotoAndPlay(startFrame);
        if (focusLayer) {
            LayerManager.focusOnTopLayer();
        }
        mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            var _loc3_:* = false;
            if (endFrame is int) {
                _loc3_ = int(endFrame) == mc.currentFrame;
            } else if (endFrame is String) {
                _loc3_ = String(endFrame) == mc.currentLabel;
            }
            if (_loc3_) {
                mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                mc.gotoAndStop(endFrame);
                if (focusLayer) {
                    LayerManager.resetOperation();
                }
                if (callBack != null) {
                    callBack();
                }
            }
        });
    }

    public static function playToEnd(param1:MovieClip, param2:*, param3:Function = null):void {
        var mc:MovieClip = param1;
        var frame:* = param2;
        var callBack:Function = param3;
        mc.gotoAndPlay(frame);
        mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            if (mc.currentFrame == mc.totalFrames) {
                mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                if (callBack != null) {
                    callBack();
                }
            }
        });
    }

    public static function turnPlayMC(param1:MovieClip, param2:Function = null):void {
        var mc:MovieClip = param1;
        var callBack:Function = param2;
        mc.gotoAndStop(mc.totalFrames);
        mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            if (mc.currentFrame == 1) {
                mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                if (callBack != null) {
                    callBack();
                }
            } else {
                mc.prevFrame();
            }
        });
    }

    public static function backPlayMC(param1:MovieClip, param2:int, param3:int, param4:Function = null, param5:Boolean = false):void {
        var mc:MovieClip = param1;
        var startFrame:int = param2;
        var endFrame:int = param3;
        var callBack:Function = param4;
        var focusLayer:Boolean = param5;
        mc.gotoAndStop(startFrame);
        if (focusLayer) {
            LayerManager.focusOnTopLayer();
        }
        mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            if (startFrame > endFrame) {
                mc.prevFrame();
            } else if (startFrame < endFrame) {
                mc.nextFrame();
            }
            if (mc.currentFrame == endFrame) {
                mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                mc.gotoAndStop(endFrame);
                if (focusLayer) {
                    LayerManager.resetOperation();
                }
                if (callBack != null) {
                    callBack();
                }
            }
        });
    }

    public static function playFullScreen(param1:String, param2:Function = null, param3:Boolean = true, param4:Boolean = false, param5:uint = 1, param6:Boolean = true):void {
        var url:String = param1;
        var callBack:Function = param2;
        var isCloseSound:Boolean = param3;
        var hasSkipBtn:Boolean = param4;
        var initCurrentAnimation:uint = param5;
        var hideMap:Boolean = param6;
        _fullScreenCallBack = callBack;
        _isColseSound = isCloseSound;
        _hasFullScreenSkipBtn = true;
        getSwfContent(url, function (param1:MovieClip):void {
            _fullScreenMc = param1;
            if (_fullScreenMc == null) {
                if (_fullScreenCallBack != null) {
                    _fullScreenCallBack();
                }
                return;
            }
            _fullScreenMc.x += 120;
            _fullScreenMc.y += 50;
            if (_isColseSound) {
                SoundManager.enabled = false;
            }
            LayerManager.focusOnTopLayer();
            if (hideMap) {
                LayerManager.topLayer.addChild(_fullScreenMc);
                LayerManager.hideMap();
            } else {
                LayerManager.topLayer.addChild(_fullScreenMc);
            }
            var _loc2_:MovieClip = UIManager.getMovieClip("UI_PlayScreen");
            _loc2_.x -= 120;
            _loc2_.y -= 50;
            _fullScreenMc.addChild(_loc2_);
            if (_hasFullScreenSkipBtn) {
                addFullScreenSkipBtn();
            }
            _fullScreenMc.gotoAndPlay(initCurrentAnimation);
            _fullScreenMc.addEventListener(Event.ENTER_FRAME, onFullScreenEnter);
        }, "加载全屏动画...");
    }

    public static function playFullScreenNoSkip(param1:String, param2:Function = null, param3:Boolean = true, param4:Boolean = false, param5:uint = 1, param6:Boolean = true):void {
        var url:String = param1;
        var callBack:Function = param2;
        var isCloseSound:Boolean = param3;
        var hasSkipBtn:Boolean = param4;
        var initCurrentAnimation:uint = param5;
        var hideMap:Boolean = param6;
        _fullScreenCallBack = callBack;
        _isColseSound = isCloseSound;
        _hasFullScreenSkipBtn = false;
        getSwfContent(url, function (param1:MovieClip):void {
            _fullScreenMc = param1;
            if (_fullScreenMc == null) {
                if (_fullScreenCallBack != null) {
                    _fullScreenCallBack();
                }
                return;
            }
            _fullScreenMc.x += 120;
            _fullScreenMc.y += 50;
            if (_isColseSound) {
                SoundManager.enabled = false;
            }
            LayerManager.focusOnTopLayer();
            if (hideMap) {
                LayerManager.topLayer.addChild(_fullScreenMc);
                LayerManager.hideMap();
            } else {
                LayerManager.topLayer.addChild(_fullScreenMc);
            }
            var _loc2_:MovieClip = UIManager.getMovieClip("UI_PlayScreen");
            _loc2_.x -= 120;
            _loc2_.y -= 50;
            _fullScreenMc.addChild(_loc2_);
            if (_hasFullScreenSkipBtn) {
                addFullScreenSkipBtn();
            }
            _fullScreenMc.gotoAndPlay(initCurrentAnimation);
            _fullScreenMc.addEventListener(Event.ENTER_FRAME, onFullScreenEnter);
        }, "加载全屏动画...");
    }

    private static function onFullScreenEnter(param1:Event):void {
        if (_fullScreenMc.currentFrame == _fullScreenMc.totalFrames) {
            clearFullScreen();
        }
    }

    private static function clearFullScreen():void {
        if (_hasFullScreenSkipBtn) {
            removeFullScreenSkipBtn();
        }
        LayerManager.resetOperation();
        LayerManager.showMap();
        if (_fullScreenMc) {
            _fullScreenMc.stop();
            _fullScreenMc.removeEventListener(Event.ENTER_FRAME, onFullScreenEnter);
        }
        DisplayObjectUtil.removeFromParent(_fullScreenMc);
        _fullScreenMc = null;
        if (_fullScreenCallBack != null) {
            _fullScreenCallBack();
        }
        if (_isColseSound) {
            SoundManager.enabled = true;
        }
    }

    private static function addFullScreenSkipBtn():void {
        if (_fullScreenSkipBtn == null) {
            _fullScreenSkipBtn = UIManager.getButton("UI_SkipBtn");
            _fullScreenSkipBtn.x = LayerManager.rootRect.width - 100;
            _fullScreenSkipBtn.y = LayerManager.rootRect.height - 50;
            _fullScreenSkipBtn.addEventListener(MouseEvent.CLICK, onFullScreenSkillBtnClick);
        }
        LayerManager.topLayer.addChild(_fullScreenSkipBtn);
    }

    private static function removeFullScreenSkipBtn():void {
        DisplayObjectUtil.removeFromParent(_fullScreenSkipBtn);
    }

    private static function onFullScreenSkillBtnClick(param1:MouseEvent):void {
        clearFullScreen();
    }

    public static function playNpcTalk(param1:String, param2:Function):void {
        _npcTalkCallBack = param2;
        QueueLoader.load(param1, LoadType.SWF, onNpcTalkLoadComplete);
    }

    private static function onNpcTalkLoadComplete(param1:ContentInfo):void {
        _npcTalkAnimation = DisplayObjectContainer(param1.content).getChildAt(0) as MovieClip;
        _npcTalkAnimation.x += 120;
        _npcTalkAnimation.y += 50;
        LayerManager.topLayer.addChild(_npcTalkAnimation);
        LayerManager.focusOnTopLayer();
        _npcTalkIndex = 2;
        playNpcTalkHelper();
    }

    private static function playNpcTalkHelper():void {
        playNpcTalkContent(_npcTalkIndex, function ():void {
            if (_npcTalkIndex == _npcTalkAnimation.totalFrames) {
                DisplayObjectUtil.removeFromParent(_npcTalkAnimation);
                LayerManager.resetOperation();
                _npcTalkCallBack();
            } else {
                ++_npcTalkIndex;
                playNpcTalkHelper();
            }
        });
    }

    private static function playNpcTalkContent(param1:*, param2:Function):void {
        var frame:* = param1;
        var callBack:Function = param2;
        _npcTalkContentCallBack = callBack;
        MovieClipUtil.getChild(_npcTalkAnimation, frame, 0, function (param1:DisplayObject):void {
            _npcTalkContent = param1 as MovieClip;
            _npcTalkContent.gotoAndPlay(1);
            _npcTalkContent.addEventListener("showBtn", onNpcTalkShowBtn);
            _npcTalkContent.addEventListener(Event.ENTER_FRAME, onNpcTalkEnterFrame);
        });
    }

    private static function onNpcTalkShowBtn(param1:Event):void {
        _npcTalkContent.stop();
        if (_npcTalkBtn == null) {
            _npcTalkBtn = UIManager.getButton("UI_NpcTalkBtn");
            _npcTalkBtn.x = 870;
            _npcTalkBtn.y = 519;
        }
        LayerManager.topLayer.addChild(_npcTalkBtn);
        _npcTalkBtn.addEventListener(MouseEvent.CLICK, onNpcTalkBtnClick);
    }

    public static function getFrameMc(param1:MovieClip, param2:Object, param3:String = "", param4:Function = null):void {
        var child:MovieClip = null;
        var parentMC:MovieClip = param1;
        var frame:Object = param2;
        var name:String = param3;
        var func:Function = param4;
        parentMC.gotoAndStop(frame);
        if (name == "") {
            child = parentMC.getChildAt(0) as MovieClip;
        } else {
            child = parentMC.getChildByName(name) as MovieClip;
        }
        if (child) {
            if (func != null) {
                func(child);
            }
        } else {
            parentMC.addEventListener(Event.ENTER_FRAME, function ():void {
                if (name == "") {
                    child = parentMC.getChildAt(0) as MovieClip;
                } else {
                    child = parentMC.getChildByName(name) as MovieClip;
                }
                if (child) {
                    parentMC.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                    if (func != null) {
                        func(child);
                    }
                }
            });
        }
    }

    private static function onNpcTalkBtnClick(param1:MouseEvent):void {
        _npcTalkContent.play();
        DisplayObjectUtil.removeFromParent(_npcTalkBtn);
        _npcTalkBtn.removeEventListener(Event.ENTER_FRAME, onNpcTalkBtnClick);
    }

    private static function onNpcTalkEnterFrame(param1:Event):void {
        if (_npcTalkContent.currentFrame == _npcTalkContent.totalFrames) {
            _npcTalkContent.removeEventListener("showBtn", onNpcTalkShowBtn);
            _npcTalkContent.removeEventListener(Event.ENTER_FRAME, onNpcTalkEnterFrame);
            _npcTalkContentCallBack();
        }
    }

    public static function playNpcTalkNew(param1:String, param2:int, param3:Array, param4:Function, param5:Boolean = false):void {
        var url:String = param1;
        var count:int = param2;
        var arr:Array = param3;
        var callback:Function = param4;
        var hasClickArea:Boolean = param5;
        _hasClickArea = hasClickArea;
        _talkTotal = count;
        _talkArr = arr;
        _talkCallBack = callback;
        getSwfContent(url, function (param1:MovieClip):void {
            _talkContent = param1;
            _talkContent.x += 120;
            _talkContent.y += 50;
            if (_hasClickArea) {
                _clickArea = _talkContent["click"];
            }
            LayerManager.focusOnTopLayer();
            LayerManager.topLayer.addChild(_talkContent);
            _talkIndex = 0;
            playNpcTalk1();
        }, "加载对话资源...");
    }

    private static function playNpcTalk1():void {
        var startFrame:* = _talkIndex == 0 ? 1 : "talk" + _talkIndex;
        var endFrame:* = _talkIndex == _talkTotal ? _talkContent.totalFrames : "talk" + (_talkIndex + 1);
        MovieClipUtil.playMc(_talkContent, startFrame, endFrame, function ():void {
            if (_talkIndex == _talkTotal) {
                DisplayObjectUtil.removeFromParent(_talkContent);
                _talkContent = null;
                _clickArea = null;
                LayerManager.resetOperation();
                _talkCallBack();
            } else {
                _talkBtn.x = caculateNpcTalkBtnPos()[0] + 120;
                _talkBtn.y = caculateNpcTalkBtnPos()[1] + 50;
                _talkBtn.mouseEnabled = false;
                _talkContent.buttonMode = true;
                _talkContent.addEventListener(MouseEvent.CLICK, onTalkBtnClick);
                if (_hasClickArea) {
                    DisplayObjectUtil.enableButtonMode(_clickArea);
                    _clickArea.addEventListener(MouseEvent.CLICK, onTalkBtnClick);
                }
                LayerManager.topLayer.addChild(_talkBtn);
            }
        });
    }

    private static function onTalkBtnClick(param1:MouseEvent):void {
        if (_hasClickArea) {
            DisplayObjectUtil.disableButtonMode(_clickArea);
            _clickArea.removeEventListener(MouseEvent.CLICK, onTalkBtnClick);
        }
        _talkBtn.removeEventListener(MouseEvent.CLICK, onTalkBtnClick);
        DisplayObjectUtil.removeFromParent(_talkBtn);
        _talkContent.buttonMode = false;
        _talkContent.removeEventListener(MouseEvent.CLICK, onTalkBtnClick);
        ++_talkIndex;
        playNpcTalk1();
    }

    private static function caculateNpcTalkBtnPos():Array {
        var _loc1_:int = _talkIndex + 1;
        var _loc2_:int = 0;
        while (_loc2_ < _talkArr.length) {
            if (_talkArr[_loc2_][0] > _loc1_) {
                break;
            }
            _loc2_++;
        }
        return NPC_TALK_BTN_ARR[_talkArr[_loc2_ - 1][1]];
    }

    public static function playHahaTalk(param1:String, param2:int, param3:Array, param4:Function = null):void {
        _hahaCount = param2;
        _hahaTalkCallBack = param4;
        _hahaBtn = UIManager.getButton("UI_NpcTalkBtn");
        _hahaBtn.x = 871;
        _hahaBtn.y = 533;
        QueueLoader.load(param1, LoadType.SWF, onLoadHaha);
    }

    private static function onLoadHaha(param1:ContentInfo):void {
        _hahaContent = DisplayObjectContainer(param1.content).getChildAt(0) as MovieClip;
        LayerManager.focusOnTopLayer();
        LayerManager.topLayer.addChild(_hahaContent);
        _hahaContent.x += 120;
        _hahaContent.y += 50;
        _hahaIndex = 1;
        playHahaContent();
    }

    private static function playHahaContent():void {
        var startFrame:* = _hahaIndex == 1 ? 1 : "talk" + (_hahaIndex - 1);
        MovieClipUtil.playMc(_hahaContent, startFrame, "talk" + _hahaIndex, function ():void {
            _hahaBtn.addEventListener(MouseEvent.CLICK, onHahBtnClick);
            LayerManager.topLayer.addChild(_hahaBtn);
        });
    }

    private static function onHahBtnClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        _hahaBtn.removeEventListener(MouseEvent.CLICK, onHahBtnClick);
        DisplayObjectUtil.removeFromParent(_hahaBtn);
        ++_hahaIndex;
        if (_hahaIndex > _hahaCount) {
            MovieClipUtil.playMc(_hahaContent, "talk" + _hahaCount, _hahaContent.totalFrames, function ():void {
                DisplayObjectUtil.removeFromParent(_hahaContent);
                LayerManager.resetOperation();
                if (_hahaTalkCallBack != null) {
                    _hahaTalkCallBack();
                }
            });
        } else {
            playHahaContent();
        }
    }

    public static function playEndAndRemove(param1:MovieClip, param2:Object = 1):void {
        var mc:MovieClip = param1;
        var frame:Object = param2;
        mc.addEventListener(Event.ENTER_FRAME, function onEnter(param1:Event):void {
            var _loc3_:MovieClip = param1.currentTarget as MovieClip;
            if (_loc3_.currentFrame == _loc3_.totalFrames) {
                _loc3_.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                DisplayObjectUtil.removeFromParent(_loc3_);
            }
        });
        mc.gotoAndPlay(frame);
    }

    public static function playSelectNpcTalk(param1:String, param2:uint, param3:Function, param4:Function, param5:Function = null):void {
        var url:String = param1;
        var id:uint = param2;
        var yesCallBack:Function = param3;
        var noCallBack:Function = param4;
        var clearFun:Function = param5;
        _yesCallBack = yesCallBack;
        _noCallBack = noCallBack;
        _clearFun = clearFun;
        _selectTalkInfo = AnimationDialog.getInfo(id);
        getSwfContent(url, function (param1:MovieClip):void {
            _selectTalkContent = param1;
            updateAllSelectList();
            updateTalkSelect(_selectTalkInfo.list[0].select1, _selectTalkInfo.list[0].select2);
            _clearBtn = _selectTalkContent["clearBtn"];
            LayerManager.focusOnTopLayer();
            LayerManager.topLayer.addChild(_selectTalkContent);
            _selectTalkIndex = 0;
            updateSelectDialog();
            selectNpcEvent();
        }, "加载对话资源...");
    }

    private static function updateAllSelectList():void {
        var _loc1_:SimpleButton = null;
        _allSelectList = Vector.<SimpleButton>([]);
        _allSelectList.push(_selectTalkContent["shide"]);
        _allSelectList.push(_selectTalkContent["meiyou"]);
        _allSelectList.push(_selectTalkContent["haoba"]);
        _allSelectList.push(_selectTalkContent["zoukai"]);
        _allSelectList.push(_selectTalkContent["dui"]);
        _allSelectList.push(_selectTalkContent["budui"]);
        for each(_loc1_ in _allSelectList) {
            _loc1_.visible = false;
        }
    }

    private static function updateTalkSelect(param1:String, param2:String):void {
        var _loc3_:SimpleButton = null;
        _selectList = Vector.<SimpleButton>([]);
        for each(_loc3_ in _allSelectList) {
            if (_loc3_.name == param1) {
                _selectList[0] = _loc3_;
                _selectList[0].visible = true;
            }
            if (_loc3_.name == param2) {
                _selectList[1] = _loc3_;
                _selectList[1].visible = true;
            }
        }
    }

    private static function updateSelectDialog():void {
        _currBaseInfo = _selectTalkInfo.list[_selectTalkIndex];
        _selectTalkContent["contentTxt"].text = _currBaseInfo.content;
        updateAllSelectList();
        updateTalkSelect(_selectTalkInfo.list[_selectTalkIndex].select1, _selectTalkInfo.list[_selectTalkIndex].select2);
    }

    private static function selectNpcEvent():void {
        var _loc1_:SimpleButton = null;
        for each(_loc1_ in _allSelectList) {
            _loc1_.addEventListener(MouseEvent.CLICK, onSelectTalkClick);
        }
        _clearBtn.addEventListener(MouseEvent.CLICK, onClear);
    }

    private static function onSelectTalkClick(param1:MouseEvent):void {
        var btn:SimpleButton = null;
        var event:MouseEvent = param1;
        var index:int = _selectList.indexOf(event.currentTarget as SimpleButton);
        if (index + 1 == _currBaseInfo.yesIndex) {
            if (_selectTalkIndex + 2 >= _selectTalkInfo.list.length) {
                ++_selectTalkIndex;
                updateSelectDialog();
                for each(btn in _selectList) {
                    btn.removeEventListener(MouseEvent.CLICK, onSelectTalkClick);
                }
                _clearBtn.removeEventListener(MouseEvent.CLICK, onClear);
                setTimeout(function ():void {
                    if (_yesCallBack != null) {
                        _yesCallBack();
                    }
                    selectTalkDispose();
                }, 1500);
            } else {
                ++_selectTalkIndex;
                updateSelectDialog();
            }
        } else {
            if (_noCallBack != null) {
                _noCallBack();
            }
            selectTalkDispose();
        }
    }

    private static function onClear(param1:MouseEvent):void {
        if (_clearFun != null) {
            _clearFun();
        }
        selectTalkDispose();
    }

    private static function selectTalkDispose():void {
        DisplayObjectUtil.removeFromParent(_selectTalkContent);
        _selectTalkContent = null;
        _yesCallBack = null;
        _noCallBack = null;
        _clearFun = null;
        _selectTalkInfo = null;
        LayerManager.resetOperation();
    }

    public static function playClickMc(param1:MovieClip, param2:int, param3:int, param4:Function = null, param5:Boolean = false):void {
        var mc:MovieClip = param1;
        var startFrame:int = param2;
        var endFrame:int = param3;
        var callBack:Function = param4;
        var focusLayer:Boolean = param5;
        mc.gotoAndStop(startFrame);
        if (focusLayer) {
            LayerManager.focusOnTopLayer();
        }
        mc.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
            mc.gotoAndPlay(mc.currentFrame + 1);
        });
        mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
            var _loc3_:* = false;
            _loc3_ = endFrame == mc.currentFrame;
            if (_loc3_) {
                mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                mc.removeEventListener(MouseEvent.CLICK, arguments.callee);
                mc.gotoAndStop(endFrame);
                if (focusLayer) {
                    LayerManager.resetOperation();
                }
                if (callBack != null) {
                    callBack();
                }
            }
        });
    }

    public static function playCartoon(param1:String, param2:uint, param3:Function = null):void {
        var url:String = param1;
        var cartoonNum:uint = param2;
        var call:Function = param3;
        cartoonCallBack = call;
        cartoonIndex = 0;
        maxCartoonNum = cartoonNum;
        getSwfContent(url, function (param1:MovieClip):void {
            cartoonMc = param1;
            cartoonMc.x = 120;
            cartoonMc.y = 50;
            cartoonMc.gotoAndStop(1);
            LayerManager.topLayer.addChild(cartoonMc);
            LayerManager.stage.addEventListener(MouseEvent.CLICK, clickCartoon);
            playNextCartoon();
        }, "加载对话资源...");
    }

    private static function clickCartoon(param1:MouseEvent):void {
        if (cartoonMc.currentLabel != "talk" + cartoonIndex) {
            clearTimeout(cartoonOut);
            cartoonMc.gotoAndStop("talk" + cartoonIndex);
            cartoonOut = setTimeout(playNextCartoon, 5000);
        } else {
            clearTimeout(cartoonOut);
            playNextCartoon();
        }
    }

    private static function playNextCartoon():void {
        ++cartoonIndex;
        LayerManager.resetOperation();
        if (cartoonIndex > maxCartoonNum) {
            cartoonMc.stop();
            LayerManager.stage.removeEventListener(MouseEvent.CLICK, clickCartoon);
            DisplayObjectUtil.removeFromParent(cartoonMc);
            if (cartoonCallBack != null) {
                cartoonCallBack();
            }
            clearTimeout(cartoonOut);
            return;
        }
        MovieClipUtil.playMc(cartoonMc, cartoonMc.currentFrame, "talk" + cartoonIndex, function ():void {
            clearTimeout(cartoonOut);
            cartoonMc.gotoAndStop("talk" + cartoonIndex);
            cartoonOut = setTimeout(playNextCartoon, 5000);
        });
    }
}
}

import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.UILoader;

import flash.display.MovieClip;

class MovieClipUtilLoader {


    private var _url:String;

    private var _title:String;

    private var _callBack:Function;

    private var _isLoading:Boolean;

    public function MovieClipUtilLoader(param1:String, param2:Function, param3:String) {
        super();
        this._url = param1;
        this._isLoading = true;
        this._callBack = param2;
        UILoader.load(this._url, LoadType.SWF, this.onSwfLoadComplete, this.onError, param3);
    }

    private function onSwfLoadComplete(param1:ContentInfo):void {
        var _loc2_:MovieClip = null;
        this._isLoading = false;
        if (this._callBack != null) {
            _loc2_ = param1.content as MovieClip;
            this._callBack(_loc2_);
            this._callBack = null;
        }
    }

    private function onError(param1:ContentInfo):void {
        if (this._callBack != null) {
            this._callBack(null);
            this._callBack = null;
        }
    }

    public function cancel():void {
        if (this._isLoading) {
            UILoader.cancel(this._url, this.onSwfLoadComplete);
        }
        this._callBack = null;
    }
}
